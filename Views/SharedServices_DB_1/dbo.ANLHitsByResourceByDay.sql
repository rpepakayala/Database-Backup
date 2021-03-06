/****** Object:  View [dbo].[ANLHitsByResourceByDay]    Script Date: 5/15/2018 12:14:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------
-- Create Views
-------------------------------------------------------------------------------

CREATE VIEW dbo.ANLHitsByResourceByDay
WITH SCHEMABINDING 
AS
SELECT r.ResourceId, r.SiteGuid, r.WebGuid, r.DocName, r.FullUrl, h.DayId, COUNT_BIG(*) AS HitCount 
FROM dbo.ANLHit h INNER JOIN dbo.ANLResource r
ON h.ResourceId = r.ResourceId
GROUP BY r.ResourceId, r.SiteGuid, r.WebGuid, r.DocName, r.FullUrl, h.DayId


GO
