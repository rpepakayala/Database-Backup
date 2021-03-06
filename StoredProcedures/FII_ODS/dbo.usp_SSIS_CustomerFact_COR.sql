/****** Object:  StoredProcedure [dbo].[usp_SSIS_CustomerFact_COR]    Script Date: 5/15/2018 12:09:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_CustomerFact_COR]
 AS 
-- INSERT [Contact].[CompanyNameDim] table
INSERT INTO [Contact].[CompanyNameDim](
  [CompanyNameName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [CompanyName] AS [CompanyNameName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[CustomerFact] 
  WHERE [CompanyName] NOT IN ( SELECT [CompanyNameName] FROM [Contact].[CompanyNameDim] WHERE [CompanyNameName] IS NOT NULL )

-- INSERT [Contact].[DepartmentDim] table
INSERT INTO [Contact].[DepartmentDim](
  [DepartmentName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Department] AS [DepartmentName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[CustomerFact] 
  WHERE [Department] NOT IN ( SELECT [DepartmentName] FROM [Contact].[DepartmentDim] WHERE [DepartmentName] IS NOT NULL )

-- INSERT [Contact].[ZipDim] table
INSERT INTO [Contact].[ZipDim](
  [ZipName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Zip] AS [ZipName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[CustomerFact] 
  WHERE [Zip] NOT IN ( SELECT ZipName FROM [Contact].[ZipDim] WHERE ZipName IS NOT NULL)

-- INSERT [Contact].[CountyDim] table
INSERT INTO [Contact].[CountyDim](
  [CountyName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [County] AS [CountyName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[CustomerFact] 
  WHERE [County] NOT IN ( SELECT [CountyName] FROM [Contact].[CountyDim] WHERE [CountyName] is NOT null)

-- INSERT [Contact].[CountryDim] table
INSERT INTO [Contact].[CountryDim](
  [CountryName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Country] AS [CountryName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[CustomerFact] 
  WHERE [Country] NOT IN ( SELECT [CountryName] FROM [Contact].[CountryDim] WHERE [CountryName] IS NOT NULL  )

-- INSERT [Contact].[NotesDim] table
INSERT INTO [Contact].[NotesDim](
  [NotesName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Notes] AS [NotesName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[CustomerFact] 
  WHERE [Notes] NOT IN ( SELECT [NotesName] FROM [Contact].[NotesDim] WHERE [NotesName] IS NOT null)

-- INSERT [Contact].[ImportBatchDim] table
INSERT INTO [Contact].[ImportBatchDim](
  [ImportBatchName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [ImportBatch] AS [ImportBatchName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[CustomerFact] 
  WHERE [ImportBatch] NOT IN ( SELECT [ImportBatchName] FROM [Contact].[ImportBatchDim] WHERE [ImportBatchName] IS NOT null )

-- INSERT [Contact].[FlagsDim] table
INSERT INTO [Contact].[FlagsDim](
  [FlagsName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Flags] AS [FlagsName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[CustomerFact] 
  WHERE [Flags] NOT IN ( SELECT [FlagsName] FROM [Contact].[FlagsDim] WHERE [FlagsName] IS NOT NULL )

-- INSERT [Contact].[MktgList1Dim] table
INSERT INTO [Contact].[MktgList1Dim](
  [MktgList1Name] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [MktgList1] AS [MktgList1Name] ,
  1 as IsVaild 
FROM [Staging].[dbo].[CustomerFact] 
  WHERE [MktgList1] NOT IN ( SELECT [MktgList1Name] FROM [Contact].[MktgList1Dim] WHERE [MktgList1Name] IS NOT NULL )

-- INSERT [Contact].[MktgList2Dim] table
INSERT INTO [Contact].[MktgList2Dim](
  [MktgList2Name] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [MktgList2] AS [MktgList2Name] ,
  1 as IsVaild 
FROM [Staging].[dbo].[CustomerFact] 
  WHERE [MktgList2] NOT IN ( SELECT [MktgList2Name] FROM [Contact].[MktgList2Dim] WHERE [MktgList2Name] IS NOT NULL )


-- For Corebridge

INSERT INTO [Contact].[IndustryTypeDim](
  [IndustryTypeName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [IndustryType] AS [IndustryTypeName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[CustomerFact] 
  WHERE [IndustryType] NOT IN ( SELECT [IndustryTypeName] FROM [Contact].[IndustryTypeDim] WHERE [IndustryTypeName] IS NOT NULL  )



GO
