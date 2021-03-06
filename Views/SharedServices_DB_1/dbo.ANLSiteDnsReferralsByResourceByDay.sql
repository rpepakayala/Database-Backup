/****** Object:  View [dbo].[ANLSiteDnsReferralsByResourceByDay]    Script Date: 5/15/2018 12:14:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------

CREATE VIEW dbo.ANLSiteDnsReferralsByResourceByDay
WITH SCHEMABINDING 
AS
SELECT r.SiteGuid AS TargetSiteGuid, ref.HostDns AS ReferrerHostDns, h.DayId, COUNT_BIG(*) AS ReferralCount 
FROM dbo.ANLHit h, dbo.ANLResource ref, dbo.ANLResource r, dbo.ANLDay d
where h.ReferrerResourceId = ref.ResourceId and h.ResourceId = r.ResourceId AND h.DayId = d.DayId
and not r.SiteGuid = ref.SiteGuid AND d.IsHistorical = 0
GROUP BY r.SiteGuid, ref.HostDns, h.DayId


GO
