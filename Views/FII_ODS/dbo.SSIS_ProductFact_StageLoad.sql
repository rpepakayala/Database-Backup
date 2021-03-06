/****** Object:  View [dbo].[SSIS_ProductFact_StageLoad]    Script Date: 5/15/2018 12:13:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE VIEW [dbo].[SSIS_ProductFact_StageLoad]
 AS 
SELECT [Staging].[dbo].[ProductFact].* 
   ,ProductCodeKey 
   ,DescriptionKey 
   ,ForegroundColorsKey 
   ,BackgroundColorKey 
   ,PriceBasedOnKey 
   ,ThicknessKey 
   ,DetailDescriptionKey 
   ,MaterialTypeNameKey 
   ,PriceFormulaKey 
   ,CostFormulaKey 
   ,SetupFormulaKey 
   ,DefaultProdNotesKey 
   ,FlagsKey
   ,CenterKey 
FROM [Staging].[dbo].[ProductFact] 
LEFT JOIN [Product].[ProductCodeDim] WITH (NOLOCK) ON [Product].[ProductCodeDim].[ProductCodeName]=[ProductFact].[ProductCode] 
LEFT JOIN [Product].[DescriptionDim] WITH (NOLOCK) ON [Product].[DescriptionDim].[DescriptionName]=[ProductFact].[Description] 
LEFT JOIN [Product].[ForegroundColorsDim] WITH (NOLOCK) ON [Product].[ForegroundColorsDim].[ForegroundColorsName]=[ProductFact].[ForegroundColors] 
LEFT JOIN [Product].[BackgroundColorDim] WITH (NOLOCK) ON [Product].[BackgroundColorDim].[BackgroundColorName]=[ProductFact].[BackgroundColor] 
LEFT JOIN [Product].[PriceBasedOnDim] WITH (NOLOCK) ON [Product].[PriceBasedOnDim].[PriceBasedOnName]=[ProductFact].[PriceBasedOn] 
LEFT JOIN [Product].[ThicknessDim] WITH (NOLOCK) ON [Product].[ThicknessDim].[ThicknessName]=[ProductFact].[Thickness] 
LEFT JOIN [Product].[DetailDescriptionDim] WITH (NOLOCK) ON [Product].[DetailDescriptionDim].[DetailDescriptionName]=[ProductFact].[DetailDescription] 
LEFT JOIN [Product].[MaterialTypeNameDim] WITH (NOLOCK) ON [Product].[MaterialTypeNameDim].[MaterialTypeNameName]=[ProductFact].[MaterialTypeName] 
LEFT JOIN [Product].[PriceFormulaDim] WITH (NOLOCK) ON [Product].[PriceFormulaDim].[PriceFormulaName]=[ProductFact].[PriceFormula] 
LEFT JOIN [Product].[CostFormulaDim] WITH (NOLOCK) ON [Product].[CostFormulaDim].[CostFormulaName]=[ProductFact].[CostFormula] 
LEFT JOIN [Product].[SetupFormulaDim] WITH (NOLOCK) ON [Product].[SetupFormulaDim].[SetupFormulaName]=[ProductFact].[SetupFormula] 
LEFT JOIN [Product].[DefaultProdNotesDim] WITH (NOLOCK) ON [Product].[DefaultProdNotesDim].[DefaultProdNotesName]=[ProductFact].[DefaultProdNotes] 
LEFT JOIN [Product].[FlagsDim] WITH (NOLOCK) ON [Product].[FlagsDim].[FlagsName]=[ProductFact].[Flags] 
JOIN Store.StoreFact WITH (NOLOCK) ON ProductFact.ZW_Franchise_ID = StoreFact.ZW_Franchise_ID


GO
