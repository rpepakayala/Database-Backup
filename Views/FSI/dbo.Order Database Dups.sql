/****** Object:  View [dbo].[Order Database Dups]    Script Date: 5/15/2018 12:13:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [dbo].[Order Database Dups] AS 
SELECT OrderID AS ID, ZW_Franchise_ID AS FranID, MAX(sys_du) AS LastUpdate 
FROM  [Order Database] WITH (NOLOCK) 
GROUP BY OrderID, ZW_Franchise_ID HAVING COUNT(*) > 1


GO
