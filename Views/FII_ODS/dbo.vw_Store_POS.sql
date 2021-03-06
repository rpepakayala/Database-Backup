/****** Object:  View [dbo].[vw_Store_POS]    Script Date: 5/15/2018 12:13:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW vw_Store_POS as

SELECT 
      sf.[ZW_Franchise_ID]
      ,sf.[StoreNumber]     
      ,sf.[Email]     
      ,sf.[Zip]
      ,sf.[OpenStatus]
      ,sf.[Address]
      ,sf.[Region]
      ,sf.[Phone]   
      ,sf.[FBC]
      ,sf.[Director]
   ,CASE 
   WHEN ISNULL(sc.[DataSource],'') like '%KEY%' THEN 'KEYSTONE' 
   WHEN ISNULL(ci.[SystemofRecord],'') = 'FSI' THEN 'RPM' 
	ELSE '' END    AS POS
   ,CASE when ci.[LastColledted] is NOT NULL THEN ci.[LastColledted]
   WHEN sc.[DataSource] is NOT NULL THEN sc.[DataSource]
   ELSE NULL END AS LASTCollectedOrDateConverted 
   
   --,ci.[LastColledted]
   --,sc.[DataSource]
   --,sc.AsOfDate
  FROM [FII_ODS].[Store].[StoreFact]  sf
  LEFT OUTER JOIN  [System].[CollectionInfo] ci  on  ci.zw_franchise_id = sf.ZW_Franchise_ID
  LEFT OUTER JOIN  [System].[StoreControl] sc  on  sc.zw_franchise_id = sf.ZW_Franchise_ID
 wHERE sf.openstatus = 'open' 
GO
