/****** Object:  StoredProcedure [dbo].[proc_ANL_SiteSummary]    Script Date: 5/15/2018 12:11:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------
CREATE PROCEDURE dbo.proc_ANL_SiteSummary
 @siteGuid uniqueidentifier,
 @todayDayId int
AS

BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @locked INT
EXEC @locked = proc_ANL_LockMasterTablesForRead
IF @locked = -1
BEGIN 
 ROLLBACK TRANSACTION
 RETURN 0
END

DECLARE @days INT
SELECT @days = dbo.fn_ANL_GetNumDetailedReportingDays()

DECLARE @siteId INT
EXEC @siteId = proc_MSS_QLog_GetSiteId @siteGuid, 0

SELECT 0 AS MeasureIndex, 'Average hits over past 30 days' AS Measure, ISNULL(CAST(SUM(HitCount)*100/@days AS FLOAT)/100,0) AS Value
FROM ANLHitsByResourceByDay WITH (NOLOCK)
WHERE (SiteGuid = @siteGuid)
UNION
SELECT 1 AS MeasureIndex, 'Distinct users over past 30 days' AS Measure, COUNT(DISTINCT UserName) AS Value 
FROM ANLHitsByResourceByUserByDay WITH (NOLOCK)
WHERE (SiteGuid = @siteGuid)
UNION
SELECT 2 AS MeasureIndex, 'Distinct users yesterday' AS Measure, COUNT(DISTINCT UserName) AS Value 
FROM ANLHitsByResourceByUserByDay WITH (NOLOCK)
WHERE (SiteGuid = @siteGuid) AND (DayId = @todayDayId-1)
UNION
SELECT 3 AS MeasureIndex, 'Requests yesterday' AS Measure, ISNULL(SUM(HitCount), 0) AS Value
FROM ANLHitsByResourceByUserByDay WITH (NOLOCK)
WHERE (SiteGuid = @siteGuid) AND (DayId = @todayDayId-1)
UNION
SELECT 4 AS MeasureIndex, 'Queries yesterday' AS Measure, Sum(numQueries) AS Value
FROM MSSQLogHistorical
WHERE (siteId = @siteId) AND searchDate = DATEADD(day, DATEDIFF(day, '20000101', GETDATE()) - 1, '20000101')
UNION
SELECT 5 AS MeasureIndex, 'Queries over past 30 days' AS Measure, Sum(numQueries) AS Value
FROM MSSQLogHistorical
WHERE (siteId = @siteId) AND searchDate >= DATEADD(day, DATEDIFF(day, '20000101', GETDATE()) - 30, '20000101')

ROLLBACK TRANSACTION
RETURN 1

GO
