/****** Object:  StoredProcedure [dbo].[proc_ANL_WebSummary]    Script Date: 5/15/2018 12:11:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------

CREATE PROCEDURE dbo.proc_ANL_WebSummary
 @webGuid uniqueidentifier,
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

SELECT 0 AS MeasureIndex, 'Average hits over past 30 days' AS Measure, ISNULL(CAST(SUM(HitCount)*100/@days AS FLOAT)/100,0) AS Value
FROM ANLHitsByResourceByDay WITH (NOLOCK)
WHERE (WebGuid = @webGuid)
UNION
SELECT 1 AS MeasureIndex, 'Distinct users over past 30 days' AS Measure, COUNT(DISTINCT UserName) AS Value 
FROM ANLHitsByResourceByUserByDay WITH (NOLOCK)
WHERE (WebGuid = @webGuid)
UNION
SELECT 2 AS MeasureIndex, 'Distinct users yesterday' AS Measure, COUNT(DISTINCT UserName) AS Value 
FROM ANLHitsByResourceByUserByDay WITH (NOLOCK)
WHERE (WebGuid = @webGuid) AND (DayId = @todayDayId-1)
UNION
SELECT 3 AS MeasureIndex, 'Requests yesterday' AS Measure, ISNULL(SUM(HitCount), 0)
FROM ANLHitsByResourceByUserByDay WITH (NOLOCK)
WHERE (WebGuid = @webGuid) AND (DayId = @todayDayId-1)

ROLLBACK TRANSACTION
RETURN 1


GO
