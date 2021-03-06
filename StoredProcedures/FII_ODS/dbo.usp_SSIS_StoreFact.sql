/****** Object:  StoredProcedure [dbo].[usp_SSIS_StoreFact]    Script Date: 5/15/2018 12:09:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_StoreFact]
 AS 
-- INSERT [Store].[OperationalDim] table
INSERT INTO [Store].[OperationalDim](
  [OperationalName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Operational] AS [OperationalName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[StoreFact] 
  WHERE [Operational] NOT IN ( SELECT ISNULL([OperationalName],'') FROM [Store].[OperationalDim] )

-- INSERT [Store].[VanityNameDim] table
INSERT INTO [Store].[VanityNameDim](
  [VanityNameName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [VanityName] AS [VanityNameName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[StoreFact] 
  WHERE [VanityName] NOT IN ( SELECT [VanityNameName] FROM [Store].[VanityNameDim] WHERE [VanityNameName] IS NOT NULL )

-- INSERT [Store].[STBLevelDim] table
INSERT INTO [Store].[STBLevelDim](
  [STBLevelName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [STBLevel] AS [STBLevelName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[StoreFact] 
  WHERE [STBLevel] NOT IN ( SELECT ISNULL([STBLevelName],'') FROM [Store].[STBLevelDim] )

-- INSERT [Store].[LocationTypeDim] table
INSERT INTO [Store].[LocationTypeDim](
  [LocationTypeName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [LocationType] AS [LocationTypeName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[StoreFact] 
  WHERE [LocationType] NOT IN ( SELECT ISNULL([LocationTypeName],'') FROM [Store].[LocationTypeDim] )

-- INSERT [Store].[StoreTypeDim] table
INSERT INTO [Store].[StoreTypeDim](
  [StoreTypeName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [StoreType] AS [StoreTypeName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[StoreFact] 
  WHERE [StoreType] NOT IN ( SELECT ISNULL([StoreTypeName],'') FROM [Store].[StoreTypeDim] )

-- INSERT [Store].[CountryDim] table
INSERT INTO [Store].[CountryDim](
  [CountryName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Country] AS [CountryName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[StoreFact] 
  WHERE [Country] NOT IN ( SELECT ISNULL([CountryName],'') FROM [Store].[CountryDim] )

-- INSERT [Store].[CityDim] table
INSERT INTO [Store].[CityDim](
  [CityName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [City] AS [CityName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[StoreFact] 
  WHERE [City] NOT IN ( SELECT ISNULL([CityName],'') FROM [Store].[CityDim] )

-- INSERT [Store].[StateDim] table
INSERT INTO [Store].[StateDim](
  [StateName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [State] AS [StateName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[StoreFact] 
  WHERE [State] NOT IN ( SELECT ISNULL([StateName],'') FROM [Store].[StateDim] )


GO
