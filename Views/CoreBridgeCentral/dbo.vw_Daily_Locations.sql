/****** Object:  View [dbo].[vw_Daily_Locations]    Script Date: 5/15/2018 12:13:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW vw_Daily_Locations
AS
Select
  DailyDim.ReportType,
  DailyDim.ReportItem,
  CompaniesLocations.Value AS CompanyLocationID,
  CompaniesLocations.ZW_Franchise_ID
From
  DailyDim,
  CompaniesLocations
GO
