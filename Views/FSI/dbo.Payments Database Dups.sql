/****** Object:  View [dbo].[Payments Database Dups]    Script Date: 5/15/2018 12:13:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[Payments Database Dups] AS 
SELECT PaymentID AS ID, ZW_Franchise_ID AS FranID, MAX(sys_du) AS LastUpdate 
FROM  [Payments Database] WITH (NOLOCK) 
GROUP BY PaymentID, ZW_Franchise_ID HAVING COUNT(*) > 1

GO
