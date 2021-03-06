/****** Object:  StoredProcedure [dbo].[proc_ANL_SiteDnsReferrersByHits]    Script Date: 5/15/2018 12:11:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------

CREATE PROCEDURE dbo.proc_ANL_SiteDnsReferrersByHits
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

DECLARE @days INT
SELECT @days = dbo.fn_ANL_GetNumDetailedReportingDays()

SELECT TOP 300 ReferrerHostDns AS Referrer, CAST(SUM(ReferralCount) AS FLOAT)/@days AS AvgDailyReferrals
FROM ANLSiteDnsReferralsByResourceByDay WITH (NOLOCK)
WHERE TargetSiteGuid = @siteGuid
GROUP BY ReferrerHostDns
ORDER BY AvgDailyReferrals DESC

ROLLBACK TRANSACTION
RETURN 1


GO
