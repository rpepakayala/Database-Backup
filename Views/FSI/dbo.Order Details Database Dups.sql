/****** Object:  View [dbo].[Order Details Database Dups]    Script Date: 5/15/2018 12:13:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[Order Details Database Dups] AS 
SELECT OrderDetailID AS ID, ZW_Franchise_ID AS FranID, MAX(sys_du) AS LastUpdate 
FROM  [Order Details Database] WITH (NOLOCK) 
GROUP BY OrderDetailID, ZW_Franchise_ID HAVING COUNT(*) > 1

GO
