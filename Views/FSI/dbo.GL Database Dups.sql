/****** Object:  View [dbo].[GL Database Dups]    Script Date: 5/15/2018 12:13:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[GL Database Dups] AS 
SELECT ID AS ID, ZW_Franchise_ID AS FranID, MAX(sys_du) AS LastUpdate 
FROM  [GL Database] WITH (NOLOCK) 
GROUP BY ID, ZW_Franchise_ID HAVING COUNT(*) > 1

GO
