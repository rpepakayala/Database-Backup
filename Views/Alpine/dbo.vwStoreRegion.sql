/****** Object:  View [dbo].[vwStoreRegion]    Script Date: 5/15/2018 12:13:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[vwStoreRegion]
AS
SELECT     cs.StoreNumber, csr.FullName
FROM         dbo.COR_STORES AS cs INNER JOIN
                      dbo.COR_STORES_ADDRESSES_LINK AS cral ON cs.StoreID = cral.StoreID INNER JOIN
                      dbo.COR_ADDRESSES AS ca ON cral.AddressID = ca.AddressID INNER JOIN
                      dbo.COR_POLITICAL_DIVISION AS cpd ON ca.PoliticalDivisionID = cpd.PoliticalDivisionID INNER JOIN
                      dbo.COR_SALES_REGIONS AS csr ON cpd.SalesRegionID = csr.SalesRegionID



GO
