/****** Object:  View [dbo].[AVI Database Dups]    Script Date: 5/15/2018 12:13:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[AVI Database Dups] AS 
SELECT AVID AS ID, ZW_Franchise_ID AS FranID, MAX(sys_du) AS LastUpdate 
FROM  [AVI Database] WITH (NOLOCK) 
GROUP BY AVID, ZW_Franchise_ID HAVING COUNT(*) > 1

GO
