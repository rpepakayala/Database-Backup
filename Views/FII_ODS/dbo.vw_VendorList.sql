/****** Object:  View [dbo].[vw_VendorList]    Script Date: 5/15/2018 12:13:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON



/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [dbo].[vw_VendorList]
AS
SELECT [ID]
      ,[recordid]
      ,[status_activity]
      ,[vendor_company]
      ,[Name]
      ,[addr_street_1]
      ,[addr_street_2]
      ,[addr_city]
      ,[addr_state]
      ,[addr_ZIP]
      ,[addr_country]
      ,[vendor_type]
      ,[Email]
      ,[Phone]
      ,[Extension]
      ,[Fax]
      ,[GeoLocation]
      ,[lat]
      ,[long]
      ,[web]
      ,[ExternalKey]
      ,[Type]
	  ,CenterNumber,WebNumber
  FROM [FII_ODS].[System].[GalaxyVendors]   WITH ( NOLOCK ) 



GO
