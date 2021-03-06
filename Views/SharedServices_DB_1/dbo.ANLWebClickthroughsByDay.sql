/****** Object:  View [dbo].[ANLWebClickthroughsByDay]    Script Date: 5/15/2018 12:14:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------

CREATE VIEW dbo.ANLWebClickthroughsByDay
WITH SCHEMABINDING 
AS
SELECT ref.SiteGuid as ReferrerSiteGuid, ref.WebGuid AS ReferrerWebGuid, w.WebUrl AS TargetFullUrl, h.DayId, COUNT_BIG(*) AS ClickthroughCount 
FROM dbo.ANLHit h, dbo.ANLResource r, dbo.ANLWeb w, dbo.ANLResource ref
WHERE h.ResourceId = r.ResourceId AND h.ReferrerResourceId = ref.ResourceId AND ref.SiteGuid = r.SiteGuid AND w.WebGuid = r.WebGuid
GROUP BY ref.SiteGuid, ref.WebGuid, w.WebUrl, h.DayId


GO
