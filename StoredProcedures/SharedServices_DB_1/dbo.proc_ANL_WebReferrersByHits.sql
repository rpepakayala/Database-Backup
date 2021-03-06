/****** Object:  StoredProcedure [dbo].[proc_ANL_WebReferrersByHits]    Script Date: 5/15/2018 12:11:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------

CREATE PROCEDURE dbo.proc_ANL_WebReferrersByHits
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

SELECT TOP 300 ReferrerFullUrl AS Referrer, CAST(SUM(ReferralCount) AS FLOAT)/@days AS AvgDailyReferrals
FROM ANLWebReferralsByResourceByDay WITH (NOLOCK)
WHERE TargetWebGuid = @webGuid
GROUP BY ReferrerFullUrl
ORDER BY AvgDailyReferrals DESC

ROLLBACK TRANSACTION
RETURN 1


GO
