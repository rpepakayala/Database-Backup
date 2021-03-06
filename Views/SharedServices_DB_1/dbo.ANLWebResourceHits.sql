/****** Object:  View [dbo].[ANLWebResourceHits]    Script Date: 5/15/2018 12:14:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-------------------------------------------------------------------------------

CREATE VIEW dbo.ANLWebResourceHits 
WITH SCHEMABINDING 
AS 

SELECT WebGuid, DocName, FullUrl, DayId, ANLResource.ResourceId, COUNT_BIG(*) AS ANLWebResourceHits 
FROM dbo.ANLResource, dbo.ANLHit
WHERE (ANLHit.ResourceId = ANLResource.ResourceId) 
GROUP BY WebGuid, DocName, FullUrl, DayId, ANLResource.ResourceId


SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF

/****** Object:  Index [IX_ANLWebResourceHits]    Script Date: 5/15/2018 12:14:23 PM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_ANLWebResourceHits] ON [dbo].[ANLWebResourceHits]
(
	[WebGuid] ASC,
	[DayId] ASC,
	[ResourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
