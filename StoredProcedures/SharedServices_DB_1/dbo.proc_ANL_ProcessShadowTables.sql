/****** Object:  StoredProcedure [dbo].[proc_ANL_ProcessShadowTables]    Script Date: 5/15/2018 12:11:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------
-- Usage data processing stored procedures
-------------------------------------------------------------------------------

--
-- Imports the data from the shadow tables into the master tables.
--
-- Both the Shadow and Master locks must have been acquired before calling 
-- this procedure in order to guarantee that this procedure and the reporting 
-- procedures will behave predictably and reliably.
--
CREATE PROCEDURE dbo.proc_ANL_ProcessShadowTables 
 @TodayDayId INT
AS

-- 0. Check if any work actually needs to be done before we start the heavy
-- lifting. Even though it is safe to process usage data multiple times per 
-- day, it can be very taxing to the database server.

-- The most common need for processing is newly-imported usage data. Check for
-- that first.

DECLARE @Hits INT, @Resources INT
SELECT @Hits = COUNT(*) FROM ANLShadowHit
SELECT @Resources = COUNT(*) FROM ANLShadowResource

IF @Hits + @Resources = 0
BEGIN
-- Check if the ANLHit table needs to be aggregated into historical data. 
-- We expect to have at most 30 days of daily detailed usage data and at 
-- most 335 days of daily summary data. The 30 days starts with "yesterday"'s 
-- data (i.e. @TodayDayId-1) and goes back to @TodayDayId-30. The summary data 
-- starts at @TodayDayId-365 and goes to @TodayDayId-31.
--
-- Check if there is any old data in ANLHit (the detailed data) which needs to 
-- be aggregated into the historical tables.
 DECLARE @MinDayId INT
 SELECT @MinDayId = MIN(DayId) FROM ANLHit

 IF @MinDayId >= (@TodayDayId-30)
 BEGIN
  -- Next, check if old data in the historical tables need to be deleted. We
  -- only need to inspect ANLHistoricalWebUsage because ANLHistoricalSiteUsage 
  -- won't have anything older.
  SELECT @MinDayId = MIN(DayId) FROM ANLHistoricalWebUsage
  IF @MinDayId >= (@TodayDayId-365)
  BEGIN
   -- Lastly, check if ANLDay needs to be updated. If we got here then we know
   -- we have no usage data for 'yesterday' but may still need to create a new
   -- row for 'yesterday' in ANLDay so that we see it with 0 hits in our 
   -- reports. Similarily, we know we don't have any historical usage data 
   -- older than Today-365, but we may have a row in ANLDay for it which needs
   -- to be deleted.

   -- Note: at this point we have the option of very cheaply removing or adding
   -- the appropriate rows in ANLDay. Consider this an optimization for sites
   -- that have a very uneven usage distribution and may receive no hits at all
   -- on some days but over the year accumulate a large amount of usage data.
   IF EXISTS (SELECT * FROM ANLDay WHERE DayId = (@TodayDayId-1)) AND NOT EXISTS (SELECT * FROM ANLDay WHERE DayId < (@TodayDayId-365))
   BEGIN
    -- Nothing to do; all usage data is up to date.
    RETURN -- EARLY RETURN; 
   END
  END
 END
END

-- Take out table-level locks on all analytics tables to avoid row-level locking.
SELECT COUNT(*) FROM ANLDay WITH (TABLOCK, HOLDLOCK)
SELECT COUNT(*) FROM ANLHistoricalSiteUsage WITH (TABLOCK, HOLDLOCK)
SELECT COUNT(*) FROM ANLHistoricalWebUsage WITH (TABLOCK, HOLDLOCK)
SELECT COUNT(*) FROM ANLHit WITH (TABLOCK, HOLDLOCK)
SELECT COUNT(*) FROM ANLResource WITH (TABLOCK, HOLDLOCK)
SELECT COUNT(*) FROM ANLWeb WITH (TABLOCK, HOLDLOCK)
SELECT COUNT(*) FROM ANLShadowHit WITH (TABLOCK, HOLDLOCK)
SELECT COUNT(*) FROM ANLShadowResource WITH (TABLOCK, HOLDLOCK)
SELECT COUNT(*) FROM ANLShadowWeb WITH (TABLOCK, HOLDLOCK)
SELECT COUNT(*) FROM ANLShadowUser WITH (TABLOCK, HOLDLOCK)
SELECT COUNT(*) FROM ANLUser WITH (TABLOCK, HOLDLOCK)

-- 1. Reconfigure the indexes and drop indexed views to optimize for bulk 
-- inserts and updates.

-- 2. Import users, webs and resources. WSS makes it impossible to track rename 
-- and move operations on resources so when that happens we'll just treat
-- it as a new resource.

-- 2a. Import ANLShadowUser into ANLUser

-- Import all new users from ANLShadowUser
INSERT INTO ANLUser (UserName)
SELECT DISTINCT UserName FROM ANLShadowUser
    WHERE NOT EXISTS (SELECT * FROM ANLUser u WHERE u.UserName = ANLShadowUser.UserName)

-- Update ANLShadowHit to point to the correct ANLUser record 
UPDATE ANLShadowHit
SET UserId = u.UserId 
FROM ANLUser u, ANLShadowUser su
WHERE su.UserId = ShadowUserId AND u.UserName = su.UserName

-- Clear out ANLShadowUser
TRUNCATE TABLE ANLShadowUser

-- 2b. Import ANLShadowWeb into ANLWeb

-- There is a remote chance that we'll have two different WebUrls for the same 
-- WebGuid. This could happen if a Web is renamed, and will only occur in the 
-- logs for that one day. To mitigate this we'll just drop an arbitrary 
-- duplicate Web and fix the broken URL on the next day's import.

-- Delete the duplicates (very rare)
DELETE FROM ANLShadowWeb 
WHERE EXISTS 
    (SELECT * FROM ANLShadowWeb sw2 WHERE sw2.WebGuid = ANLShadowWeb.WebGuid AND sw2.WebUrl < ANLShadowWeb.WebUrl)

-- Update the names of any renamed webs
UPDATE ANLWeb 
SET WebUrl = sw.WebURL
FROM ANLShadowWeb sw
WHERE ANLWeb.WebGuid = sw.WebGuid

-- Import all new webs from ANLShadowWeb
INSERT INTO ANLWeb (WebGuid, WebUrl)
SELECT DISTINCT WebGuid, WebUrl FROM ANLShadowWeb
    WHERE NOT WebGuid = '00000000-0000-0000-0000-000000000000'
    AND NOT EXISTS (SELECT * FROM ANLWeb w WHERE w.WebGuid = ANLShadowWeb.WebGuid)

-- Clear out ANLShadowUser
TRUNCATE TABLE ANLShadowWeb

-- 2c. Import ANLShadowResource into ANLResource

-- Update any non-resolved resources in ANLResource with resolved versions from
-- ANLShadowResource.
UPDATE ANLResource
SET WebAppGuid = s.WebAppGuid, SiteGuid = s.SiteGuid, WebGuid = s.WebGuid, DocName = s.DocName
FROM ANLShadowResource s
WHERE ANLResource.WebAppGuid = '00000000-0000-0000-0000-000000000000' AND NOT s.WebAppGuid = '00000000-0000-0000-0000-000000000000'
AND ANLResource.FullUrl = s.FullUrl

-- Insert any WSS resources which exist in ANLShadowResource but not ANLResource.
INSERT INTO ANLResource
SELECT DISTINCT WebAppGuid, SiteGuid, WebGuid, DocName, FullUrl, HostDns FROM ANLShadowResource a
WHERE NOT EXISTS (SELECT * FROM ANLResource b WHERE a.FullUrl = b.FullUrl)

-- Try to resolve URLs which have no WSS reference info (such as webguid, etc)
-- by looking them up in ANLResource. 

-- Update ANLShadowHit to point to the correct ANLResource records. 

UPDATE ANLShadowHit 
SET ResourceId = r.ResourceId 
FROM ANLResource r, ANLShadowResource sr
WHERE ShadowResourceId = sr.ResourceId 
AND r.FullUrl = sr.FullUrl

-- Fix referrers. We're using 0 to mark null referrers, and we know that no 
-- resources have that ID so those ShadowReferrerResourceIds will become
-- null ReferrerResourceIds.

-- Update referring resources which we know are internal (ones where WebAppGuid 
-- is not null).
UPDATE ANLShadowHit 
SET ReferrerResourceId = r.ResourceId 
FROM ANLResource r, ANLShadowResource sr
WHERE ShadowReferrerResourceId = sr.ResourceId 
AND NOT sr.WebAppGuid = '00000000-0000-0000-0000-000000000000' 
AND r.FullUrl = sr.FullUrl

-- Update resources which we suspect to be external but may just be unresolved
-- internals (ones where WebAppGuid is null).
UPDATE ANLShadowHit 
SET ReferrerResourceId = r.ResourceId 
FROM ANLResource r, ANLShadowResource sr
WHERE ShadowReferrerResourceId = sr.ResourceId 
AND sr.WebAppGuid = '00000000-0000-0000-0000-000000000000' 
AND r.FullUrl = sr.FullUrl

-- Clear out ANLShadowResource
TRUNCATE TABLE ANLShadowResource

-- 3. Summarize and archive hits older than 30 days into the Historical tables.

-- #TempSummary is used as a temporary bucket of stats which makes it a little 
-- easier to store the aggregations before putting them into the Historical 
-- tables. SummaryGuid can refer to WebGuid or SiteGuid, depending on what type 
-- of object we're summarizing.
CREATE TABLE #TempSummary (SummaryDayId int, SummaryGuid uniqueidentifier, Value int, CONSTRAINT PK_WebHitsSummary PRIMARY KEY (SummaryDayId, SummaryGuid))

-- ANLHistoricalWebUsage.Hits
insert into #TempSummary (SummaryDayId, SummaryGuid, Value) 
select DayId, WebGuid, count_big(*) 
from ANLShadowHit, ANLResource 
where ANLShadowHit.ResourceId = ANLResource.ResourceId 
group by DayId, WebGuid

-- Update the the existing records, then insert any missing ones.

update ANLHistoricalWebUsage 
set Hits = Hits + Value 
from #TempSummary
where SummaryGuid = WebGuid and SummaryDayId = DayId

-- The following INSERT statement will seed the other 3 aggregations 
-- (UniqueUsers, HomePageHits, HomePageUniqueUsers) with 0 values so that they
-- do not need to be inserted anymore, just updated.

INSERT INTO ANLHistoricalWebUsage (DayId, WebGuid, Hits, UniqueUsers, HomePageHits, HomePageUniqueUsers) 
SELECT SummaryDayId, SummaryGuid, Value, 0, 0, 0 from #TempSummary WHERE NOT EXISTS (
	SELECT * FROM ANLHistoricalWebUsage WHERE SummaryGuid = WebGuid AND SummaryDayId = DayId)

TRUNCATE TABLE #TempSummary

-- ANLHistoricalWebUsage.UniqueUsers
insert into #TempSummary (SummaryDayId, SummaryGuid, Value) 
select DayId, WebGuid, count_big(distinct UserId) 
from ANLShadowHit, ANLResource
where ANLShadowHit.ResourceId = ANLResource.ResourceId
group by DayId, WebGuid

update ANLHistoricalWebUsage
set UniqueUsers = UniqueUsers + Value 
from #TempSummary
where SummaryGuid = WebGuid and SummaryDayId = DayId

truncate table #TempSummary

-- ANLHistoricalWebUsage.HomePageHits
insert into #TempSummary (SummaryDayId, SummaryGuid, Value) 
select DayId, WebGuid, count_big(*) 
from ANLShadowHit, ANLResource
where ANLShadowHit.ResourceId = ANLResource.ResourceId AND (DocName = N'' OR DocName = NULL OR LOWER(DocName) = N'default.aspx' OR RIGHT(LOWER(DocName),13) = N'/default.aspx')
group by DayId, WebGuid 

update ANLHistoricalWebUsage
set HomePageHits = HomePageHits + Value 
from #TempSummary
where SummaryGuid = WebGuid and SummaryDayId = DayId

truncate table #TempSummary

-- ANLHistoricalWebUsage.HomePageUniqueUsers
insert into #TempSummary (SummaryDayId, SummaryGuid, Value) 
select DayId, WebGuid, count_big(distinct UserId) 
from ANLShadowHit, ANLResource 
where ANLShadowHit.ResourceId = ANLResource.ResourceId AND (DocName = N'' OR DocName = NULL OR LOWER(DocName) = N'default.aspx' OR RIGHT(LOWER(DocName),13) = N'/default.aspx')
group by DayId, WebGuid

update ANLHistoricalWebUsage
set HomePageUniqueUsers = HomePageUniqueUsers + Value 
from #TempSummary
where SummaryGuid = WebGuid and SummaryDayId = DayId

truncate table #TempSummary

DELETE FROM ANLHistoricalWebUsage WHERE DayId < (@TodayDayId - 365)

-- ANLHistoricalSiteUsage.Hits

INSERT INTO #TempSummary (SummaryDayId, SummaryGuid, Value) 
SELECT DayId, SiteGuid, COUNT_BIG(*) 
FROM ANLShadowHit, ANLResource 
WHERE ANLShadowHit.ResourceId = ANLResource.ResourceId
GROUP BY DayId, SiteGuid

UPDATE ANLHistoricalSiteUsage
SET Hits = Hits + Value 
FROM #TempSummary
WHERE SummaryGuid = SiteGuid AND SummaryDayId = DayId

-- The following INSERT statement will seed the other aggregation (UniqueUsers) 
-- with a 0 values so that it does not need to be inserted anymore, just 
-- updated.

INSERT INTO ANLHistoricalSiteUsage (DayId, SiteGuid, Hits, UniqueUsers) 
SELECT SummaryDayId, SummaryGuid, Value, 0 FROM #TempSummary 
WHERE NOT EXISTS (SELECT * FROM ANLHistoricalSiteUsage WHERE SummaryGuid = SiteGuid AND SummaryDayId = DayId)

TRUNCATE TABLE #TempSummary

-- ANLHistoricalSiteUsage.UniqueUsers

INSERT INTO #TempSummary (SummaryDayId, SummaryGuid, Value) 
SELECT DayId, SiteGuid, COUNT_BIG(DISTINCT UserId) 
FROM ANLShadowHit, ANLResource
WHERE ANLShadowHit.ResourceId = ANLResource.ResourceId
GROUP BY DayId, SiteGuid 

UPDATE ANLHistoricalSiteUsage
SET UniqueUsers = UniqueUsers + Value 
FROM #TempSummary
WHERE SummaryGuid = SiteGuid AND SummaryDayId = DayId

TRUNCATE TABLE #TempSummary

-- Note that the most recent hits in ANLHit are from yesterday, hence " < (today-30)" and not " <= (today-30)"
DELETE FROM ANLHit WHERE DayId < (@TodayDayId - 30)

-- 4. Import ANLShadowHit

-- Fix the unknown referrers in ANLShadowHit. Do this in two passes: first try 
-- finding fully-resolved resources in ANLShadowResource, then go to 
-- ANLResource for anything left unresolved.
--
-- NOTE: we are not enforcing uniqueness on dbo.ANLHit.FullUrl so weirdness may 
-- 	occur with really long URLs that are truncated and result in 
--	duplicates.

-- Copy the shadow hits into the master table.
INSERT INTO ANLHit (DayId, ResourceId, UserId, ReferrerResourceId) 
SELECT DayId, ResourceId, UserId, ReferrerResourceId FROM ANLShadowHit

-- We're now done with ANLShadowHit
TRUNCATE TABLE ANLShadowHit

-- 5. Delete any resources that are no longer referenced by any hits. Also 
-- check that the summary tables don't use the resources. Note that we're not
-- checking against ANLHistoricalSiteUsage because ANLHistoricalWebUsage is 
-- a superset.

-- Note that we're keeping just the home page of webs that have historical 
-- usage data.
DELETE FROM ANLResource
WHERE NOT EXISTS (SELECT * FROM ANLHit h WHERE h.ResourceId = ResourceId) 
AND NOT (DocName = N'' OR DocName = NULL OR LOWER(DocName) = N'default.aspx' OR RIGHT(LOWER(DocName),13) = N'/default.aspx') AND EXISTS (SELECT * FROM ANLHistoricalWebUsage s WHERE s.WebGuid = WebGuid)

-- Clean up the ANLWeb table. Because this table is only used for 30d reports
-- we don't have to check if the Historical tables are using these webs.
DELETE FROM ANLWeb 
WHERE NOT EXISTS (SELECT * FROM ANLHit INNER JOIN ANLResource ON ANLHit.ResourceId = ANLResource.ResourceId WHERE ANLResource.WebGuid = ANLWeb.WebGuid)

-- 6. Update ANLDay

-- Create any missing ANLDay entries by inserting all days into ANLDay between 
-- the oldest day day in ANLHistoricalWebUsage and yesterday. 
DECLARE @newDayId INT
SELECT @newDayId = ISNULL(MIN(DayId), @TodayDayId-1) FROM ANLHistoricalSiteUsage
WHILE @newDayId < @TodayDayId
BEGIN
 IF (SELECT COUNT(*) FROM ANLDay WHERE DayId = @newDayId) = 0
 BEGIN
  INSERT INTO ANLDay (DayId, FullDate, IsHistorical) VALUES (@newDayId, DATEADD(DAY,@newDayId,'20000101'), 0)
 END
 SELECT @newDayId = @newDayId + 1
END

-- Delete days older than 365 days from today
DELETE FROM ANLDay WHERE DayId < (@TodayDayId - 365)

-- Update the IsHistorical flag to 1 on all DayIds older than 30 days
UPDATE ANLDay SET IsHistorical = CASE WHEN DayId < @TodayDayId - 30 THEN 1 ELSE 0 END


GO
