/****** Object:  View [dbo].[AVI To Product Database Dups]    Script Date: 5/15/2018 12:13:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[AVI To Product Database Dups] AS 
SELECT ID AS ID, ZW_Franchise_ID AS FranID, MAX(sys_du) AS LastUpdate 
FROM  [AVI To Product Database] WITH (NOLOCK) 
GROUP BY ID, ZW_Franchise_ID HAVING COUNT(*) > 1

GO
