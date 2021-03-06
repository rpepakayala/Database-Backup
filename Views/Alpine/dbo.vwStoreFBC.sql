/****** Object:  View [dbo].[vwStoreFBC]    Script Date: 5/15/2018 12:13:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [dbo].[vwStoreFBC]
AS
-- Use GoldminePlacement as 7 for FBC when reloading
SELECT     StoreNumber,
                          (SELECT     TOP (1) cp.FirstName + ' ' + cp.LastName AS Expr1
                            FROM          dbo.COR_STORES_PERSONS_LINK AS cs2 INNER JOIN
                                                   dbo.COR_STORES AS css ON cs2.StoreID = css.StoreID INNER JOIN
                                                   dbo.COR_PERSONS AS cp ON cs2.PersonID = cp.PersonID
                            WHERE      (css.StoreNumber = cs.StoreNumber) AND (cp.PersonType = 2005)) AS FBC
FROM         dbo.COR_STORES AS cs




GO
