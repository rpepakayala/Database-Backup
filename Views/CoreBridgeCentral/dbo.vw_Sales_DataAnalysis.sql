/****** Object:  View [dbo].[vw_Sales_DataAnalysis]    Script Date: 5/15/2018 12:13:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
  CREATE VIEW vw_Sales_DataAnalysis
  AS
  SELECT DISTINCT
  vw_Store.WebNumber,
  vw_Store.StoreNumber,
  SalesResultsAllDispositions.ProductCategory,
  SalesResultsAllDispositions.IndustryType,
  SalesResultsAllDispositions.CustomerType,
  SalesResultsAllDispositions.GL_Account,
  SalesResultsAllDispositions.Currency,
  SalesResultsAllDispositions.IsVended,
  SalesResultsAllDispositions.IncomeTypeDescription,
  SalesResultsAllDispositions.IncomeTypeText,
  SalesResultsAllDispositions.SortAccount,
  vw_Store.OpenStatus,
  vw_Store.Region,
  vw_Store.RegionName,
  vw_Store.StoreOpenDate,
  vw_Store.ResaleOpenDate,
  vw_Store.StoreTypeName
FROM
  SalesResultsAllDispositions
  INNER JOIN vw_Locations ON SalesResultsAllDispositions.CompanyLocationId = vw_Locations.Value
  INNER JOIN vw_Store ON vw_Locations.ZW_Franchise_ID = vw_Store.ZW_Franchise_ID
WHERE
  vw_Store.DataSource = 'Core' AND
  SalesResultsAllDispositions.OrderCompletionDate >= vw_Store.AsOfDate
GO
