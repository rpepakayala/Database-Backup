/****** Object:  View [dbo].[ANLHomePageHit]    Script Date: 5/15/2018 12:14:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------

CREATE VIEW dbo.ANLHomePageHit
WITH SCHEMABINDING
AS

SELECT h.DayId, r.SiteGuid, r.WebGuid, u.UserName, ref.FullUrl AS ReferrerFullUrl
FROM dbo.ANLUser u, dbo.ANLResource r, dbo.ANLHit h LEFT OUTER JOIN dbo.ANLResource ref
ON h.ReferrerResourceId = ref.ResourceId 
WHERE (r.DocName = N'' OR r.DocName = NULL OR LOWER(r.DocName) = N'default.aspx' OR RIGHT(LOWER(r.DocName),13) = N'/default.aspx')
AND u.UserId = h.UserId
AND h.ResourceId = r.ResourceId


GO
