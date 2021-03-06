/****** Object:  View [dbo].[vw_Products]    Script Date: 5/15/2018 12:13:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [dbo].[vw_Products]
AS
SELECT        Product.ProductFact.ProductKey, Product.ProductFact.ProductID, Product.ProductFact.ZW_Franchise_ID, Product.ProductCodeDim.ProductCodeName AS ProductCode,
                          Product.ProductFact.ProductCategoryID, Product.ProductFact.VolumeCategoryID, Product.ProductFact.AVICategoryID, 
                         Product.DescriptionDim.DescriptionName AS Description, Product.ProductFact.PricingStructure, Product.ProductFact.DefaultProductionLocation, 
                         Product.ForegroundColorsDim.ForegroundColorsName AS ForegroundColors, Product.BackgroundColorDim.BackgroundColorName AS BackgroundColor, 
                         Product.ProductFact.Font, Product.PriceBasedOnDim.PriceBasedOnName AS PriceBasedOn, Product.ProductFact.DefaultHeight, Product.ProductFact.DefaultWidth, 
                         Product.ProductFact.InputUnits, Product.ProductFact.PricingUnits, Product.ThicknessDim.ThicknessName AS Thickness, Product.ProductFact.MinNumberSides, 
                         Product.ProductFact.MaxNumberSides, Product.ProductFact.DefaultSides, Product.ProductFact.SecondSidePremium, Product.ProductFact.SetupCharge, 
                         Product.ProductFact.MinUnitPrice, Product.ProductFact.MinLineItemPrice, Product.ProductFact.BaseUnitCharge, Product.ProductFact.Taxable, 
                         Product.ProductFact.AllInstallation, Product.ProductFact.StandardDeliveryTime, Product.ProductFact.ProductionRate, Product.ProductFact.RoundingType, 
                         Product.ProductFact.FGColorListID, Product.ProductFact.RestrictFGColorToList, Product.ProductFact.BGColorListID, Product.ProductFact.RestrictBGColorToList, 
                         Product.ProductFact.FontListID, Product.ProductFact.RestrictFontToList, Product.ProductFact.RoundSizeToTable, Product.ProductFact.ExtrapolateTable, 
                         Product.ProductFact.FixedPerPieceCharge, Product.ProductFact.SecondSideSetup, Product.ProductFact.SecondSidePerPieceCharge, 
                         Product.ProductFact.ProductImageID, Product.ProductFact.PriceSheetID, Product.ProductFact.BaseUnitCost, 
                         Product.DetailDescriptionDim.DetailDescriptionName AS DetailDescription, Product.ProductFact.SymmetricTable, Product.ProductFact.TotalSizeDiscounts, 
                         Product.ProductFact.InterpolateTable, Product.MaterialTypeNameDim.MaterialTypeNameName AS MaterialType, Product.ProductFact.ChargeForScrap, 
                         Product.ProductFact.ScrapChargeRate, Product.ProductFact.MaterialHeight, Product.ProductFact.MaterialWidth, Product.ProductFact.MaterialDepth, 
                         Product.ProductFact.PanelMaterial, Product.ProductFact.PanelGap, Product.ProductFact.Material2Sided, Product.ProductFact.HiddenByDefault, 
                         Product.ProductFact.ProductActive, Product.ProductFact.CostToPriceMargin, Product.PriceFormulaDim.PriceFormulaName AS PriceFormula, 
                         Product.CostFormulaDim.CostFormulaName AS CostFormula, Product.ProductFact.OEEntryFormatID, Product.SetupFormulaDim.SetupFormulaName AS SetupFormula,
                          Product.ProductFact.TilePieces, Product.ProductFact.RotatePieces, Product.ProductFact.AvoidPaneling, Product.ProductFact.ChargeForExtraPanels, 
                         Product.ProductFact.PanelChargeRate, Product.ProductFact.PanelChargeAmount, Product.DefaultProdNotesDim.DefaultProdNotesName AS DefaultProdNotes, 
                         Product.ProductFact.xSortMarker, Product.ProductFact.LimitToTable, Product.FlagsDim.FlagsName AS Flags, Product.ProductFact.RoyaltyGroupID, 
                         Product.ProductFact.KeystoneProductKey
FROM            Product.ProductFact   WITH ( NOLOCK ) LEFT OUTER JOIN
                         Product.ProductCodeDim   WITH ( NOLOCK ) ON Product.ProductFact.ProductCodeKey = Product.ProductCodeDim.ProductCodeKey LEFT OUTER JOIN
                         Product.DescriptionDim   WITH ( NOLOCK ) ON Product.ProductFact.DescriptionKey = Product.DescriptionDim.DescriptionKey LEFT OUTER JOIN
                         Product.ForegroundColorsDim   WITH ( NOLOCK ) ON Product.ProductFact.ForegroundColorsKey = Product.ForegroundColorsDim.ForegroundColorsKey LEFT OUTER JOIN
                         Product.BackgroundColorDim   WITH ( NOLOCK ) ON Product.ProductFact.BackgroundColorKey = Product.BackgroundColorDim.BackgroundColorKey LEFT OUTER JOIN
                         Product.PriceBasedOnDim   WITH ( NOLOCK ) ON Product.ProductFact.PriceBasedOnKey = Product.PriceBasedOnDim.PriceBasedOnKey LEFT OUTER JOIN
                         Product.ThicknessDim   WITH ( NOLOCK ) ON Product.ProductFact.ThicknessKey = Product.ThicknessDim.ThicknessKey LEFT OUTER JOIN
                         Product.DetailDescriptionDim   WITH ( NOLOCK ) ON Product.ProductFact.DetailDescriptionKey = Product.DetailDescriptionDim.DetailDescriptionKey LEFT OUTER JOIN
                         Product.MaterialTypeNameDim   WITH ( NOLOCK ) ON Product.ProductFact.MaterialTypeNameKey = Product.MaterialTypeNameDim.MaterialTypeNameKey LEFT OUTER JOIN
                         Product.PriceFormulaDim   WITH ( NOLOCK ) ON Product.ProductFact.PriceFormulaKey = Product.PriceFormulaDim.PriceFormulaKey LEFT OUTER JOIN
                         Product.CostFormulaDim   WITH ( NOLOCK ) ON Product.ProductFact.CostFormulaKey = Product.CostFormulaDim.CostFormulaKey LEFT OUTER JOIN
                         Product.SetupFormulaDim   WITH ( NOLOCK ) ON Product.ProductFact.SetupFormulaKey = Product.SetupFormulaDim.SetupFormulaKey LEFT OUTER JOIN
                         Product.DefaultProdNotesDim   WITH ( NOLOCK ) ON Product.ProductFact.DefaultProdNotesKey = Product.DefaultProdNotesDim.DefaultProdNotesKey LEFT OUTER JOIN
                         Product.FlagsDim   WITH ( NOLOCK ) ON Product.ProductFact.FlagsKey = Product.FlagsDim.FlagsKey


GO
