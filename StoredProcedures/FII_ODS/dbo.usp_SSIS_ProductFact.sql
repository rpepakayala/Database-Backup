/****** Object:  StoredProcedure [dbo].[usp_SSIS_ProductFact]    Script Date: 5/15/2018 12:09:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_ProductFact]
 AS 
-- INSERT [Product].[ProductCodeDim] table
INSERT INTO [Product].[ProductCodeDim](
  [ProductCodeName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [ProductCode] AS [ProductCodeName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[ProductFact] 
  WHERE [ProductCode] NOT IN ( SELECT ISNULL([ProductCodeName],'') FROM [Product].[ProductCodeDim] )

-- INSERT [Product].[DescriptionDim] table
INSERT INTO [Product].[DescriptionDim](
  [DescriptionName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Description] AS [DescriptionName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[ProductFact] 
  WHERE [Description] NOT IN ( SELECT ISNULL([DescriptionName],'') FROM [Product].[DescriptionDim] )

-- INSERT [Product].[ForegroundColorsDim] table
INSERT INTO [Product].[ForegroundColorsDim](
  [ForegroundColorsName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [ForegroundColors] AS [ForegroundColorsName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[ProductFact] 
  WHERE [ForegroundColors] NOT IN ( SELECT ISNULL([ForegroundColorsName],'') FROM [Product].[ForegroundColorsDim] )

-- INSERT [Product].[BackgroundColorDim] table
INSERT INTO [Product].[BackgroundColorDim](
  [BackgroundColorName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [BackgroundColor] AS [BackgroundColorName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[ProductFact] 
  WHERE [BackgroundColor] NOT IN ( SELECT ISNULL([BackgroundColorName],'') FROM [Product].[BackgroundColorDim] )

-- INSERT [Product].[PriceBasedOnDim] table
INSERT INTO [Product].[PriceBasedOnDim](
  [PriceBasedOnName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [PriceBasedOn] AS [PriceBasedOnName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[ProductFact] 
  WHERE [PriceBasedOn] NOT IN ( SELECT ISNULL([PriceBasedOnName],'') FROM [Product].[PriceBasedOnDim] )

-- INSERT [Product].[ThicknessDim] table
INSERT INTO [Product].[ThicknessDim](
  [ThicknessName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Thickness] AS [ThicknessName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[ProductFact] 
  WHERE [Thickness] NOT IN ( SELECT ISNULL([ThicknessName],'') FROM [Product].[ThicknessDim] )

-- INSERT [Product].[DetailDescriptionDim] table
INSERT INTO [Product].[DetailDescriptionDim](
  [DetailDescriptionName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [DetailDescription] AS [DetailDescriptionName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[ProductFact] 
  WHERE [DetailDescription] NOT IN ( SELECT ISNULL([DetailDescriptionName],'') FROM [Product].[DetailDescriptionDim] )

-- INSERT [Product].[MaterialTypeNameDim] table
INSERT INTO [Product].[MaterialTypeNameDim](
  [MaterialTypeNameName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [MaterialTypeName] AS [MaterialTypeNameName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[ProductFact] 
  WHERE [MaterialTypeName] NOT IN ( SELECT ISNULL([MaterialTypeNameName],'') FROM [Product].[MaterialTypeNameDim] )

-- INSERT [Product].[PriceFormulaDim] table
INSERT INTO [Product].[PriceFormulaDim](
  [PriceFormulaName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [PriceFormula] AS [PriceFormulaName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[ProductFact] 
  WHERE [PriceFormula] NOT IN ( SELECT ISNULL([PriceFormulaName],'') FROM [Product].[PriceFormulaDim] )

-- INSERT [Product].[CostFormulaDim] table
INSERT INTO [Product].[CostFormulaDim](
  [CostFormulaName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [CostFormula] AS [CostFormulaName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[ProductFact] 
  WHERE [CostFormula] NOT IN ( SELECT ISNULL([CostFormulaName],'') FROM [Product].[CostFormulaDim] )

-- INSERT [Product].[SetupFormulaDim] table
INSERT INTO [Product].[SetupFormulaDim](
  [SetupFormulaName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [SetupFormula] AS [SetupFormulaName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[ProductFact] 
  WHERE [SetupFormula] NOT IN ( SELECT ISNULL([SetupFormulaName],'') FROM [Product].[SetupFormulaDim] )

-- INSERT [Product].[DefaultProdNotesDim] table
INSERT INTO [Product].[DefaultProdNotesDim](
  [DefaultProdNotesName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [DefaultProdNotes] AS [DefaultProdNotesName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[ProductFact] 
  WHERE [DefaultProdNotes] NOT IN ( SELECT ISNULL([DefaultProdNotesName],'') FROM [Product].[DefaultProdNotesDim] )

-- INSERT [Product].[FlagsDim] table
INSERT INTO [Product].[FlagsDim](
  [FlagsName] ,
  [IsValid] ) 
 SELECT DISTINCT 
  [Flags] AS [FlagsName] ,
  1 as IsVaild 
FROM [Staging].[dbo].[ProductFact] 
  WHERE [Flags] NOT IN ( SELECT ISNULL([FlagsName],'') FROM [Product].[FlagsDim] )


GO
