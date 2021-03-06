/****** Object:  StoredProcedure [dbo].[proc_ANL_SiteHistoricalUniqueUsersByDay]    Script Date: 5/15/2018 12:11:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------

CREATE PROCEDURE dbo.proc_ANL_SiteHistoricalUniqueUsersByDay
 @siteGuid uniqueidentifier
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

SELECT FullDate, ISNULL(UniqueUsers,0) AS UniqueUsers
FROM ANLDay WITH (NOLOCK) LEFT OUTER JOIN ANLHistoricalSiteUsage WITH (NOLOCK)
ON dbo.ANLDay.DayId = ANLHistoricalSiteUsage.DayId
AND SiteGuid = @siteGuid
ORDER BY ANLDay.DayId ASC

ROLLBACK TRANSACTION
RETURN 1


GO
