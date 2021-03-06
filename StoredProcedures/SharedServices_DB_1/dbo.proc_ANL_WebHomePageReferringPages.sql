/****** Object:  StoredProcedure [dbo].[proc_ANL_WebHomePageReferringPages]    Script Date: 5/15/2018 12:11:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------

CREATE PROCEDURE dbo.proc_ANL_WebHomePageReferringPages
 @webGuid uniqueidentifier
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

SELECT TOP 300 ReferrerFullUrl AS Referrer, CAST(COUNT_BIG(*) AS FLOAT)/@days AS AvgDailyReferrals, CAST(COUNT_BIG(DISTINCT UserName) AS FLOAT)/@days AS AvgDailyUniqueUsersReferred
FROM ANLHomePageHit WITH (NOLOCK)
WHERE WebGuid = @webGuid AND ReferrerFullUrl IS NOT NULL
GROUP BY ReferrerFullUrl
ORDER BY AvgDailyReferrals DESC, AvgDailyUniqueUsersReferred DESC

ROLLBACK TRANSACTION
RETURN 1


GO
