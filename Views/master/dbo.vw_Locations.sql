/****** Object:  View [dbo].[vw_Locations]    Script Date: 5/15/2018 12:14:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW vw_Locations as
SELECT Distinct [Value]
      ,[ZW_Franchise_ID]
    FROM [CoreBridgeCentral].[dbo].[CompaniesLocations]
GO
