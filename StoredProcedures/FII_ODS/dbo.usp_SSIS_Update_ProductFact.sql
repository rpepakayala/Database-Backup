/****** Object:  StoredProcedure [dbo].[usp_SSIS_Update_ProductFact]    Script Date: 5/15/2018 12:09:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_Update_ProductFact]
 AS UPDATE F SET 
 F.ZW_Franchise_ID = U.ZW_Franchise_ID 
 , F.ProductID = U.ProductID 
 , F.ProductCodeKey = U.ProductCodeKey 
 , F.ProductCategoryID = U.ProductCategoryID 
 , F.VolumeCategoryID = U.VolumeCategoryID 
 , F.AVICategoryID = U.AVICategoryID 
 , F.DescriptionKey = U.DescriptionKey 
 , F.PricingStructure = U.PricingStructure 
 , F.DefaultProductionLocation = U.DefaultProductionLocation 
 , F.ForegroundColorsKey = U.ForegroundColorsKey 
 , F.BackgroundColorKey = U.BackgroundColorKey 
 , F.Font = U.Font 
 , F.PriceBasedOnKey = U.PriceBasedOnKey 
 , F.DefaultHeight = U.DefaultHeight 
 , F.DefaultWidth = U.DefaultWidth 
 , F.InputUnits = U.InputUnits 
 , F.PricingUnits = U.PricingUnits 
 , F.ThicknessKey = U.ThicknessKey 
 , F.MinNumberSides = U.MinNumberSides 
 , F.MaxNumberSides = U.MaxNumberSides 
 , F.DefaultSides = U.DefaultSides 
 , F.SecondSidePremium = U.SecondSidePremium 
 , F.SetupCharge = U.SetupCharge 
 , F.MinUnitPrice = U.MinUnitPrice 
 , F.MinLineItemPrice = U.MinLineItemPrice 
 , F.BaseUnitCharge = U.BaseUnitCharge 
 , F.Taxable = U.Taxable 
 , F.AllInstallation = U.AllInstallation 
 , F.StandardDeliveryTime = U.StandardDeliveryTime 
 , F.ProductionRate = U.ProductionRate 
 , F.RoundingType = U.RoundingType 
 , F.FGColorListID = U.FGColorListID 
 , F.RestrictFGColorToList = U.RestrictFGColorToList 
 , F.BGColorListID = U.BGColorListID 
 , F.RestrictBGColorToList = U.RestrictBGColorToList 
 , F.FontListID = U.FontListID 
 , F.RestrictFontToList = U.RestrictFontToList 
 , F.RoundSizeToTable = U.RoundSizeToTable 
 , F.ExtrapolateTable = U.ExtrapolateTable 
 , F.FixedPerPieceCharge = U.FixedPerPieceCharge 
 , F.SecondSideSetup = U.SecondSideSetup 
 , F.SecondSidePerPieceCharge = U.SecondSidePerPieceCharge 
 , F.ProductImageID = U.ProductImageID 
 , F.PriceSheetID = U.PriceSheetID 
 , F.BaseUnitCost = U.BaseUnitCost 
 , F.DetailDescriptionKey = U.DetailDescriptionKey 
 , F.SymmetricTable = U.SymmetricTable 
 , F.TotalSizeDiscounts = U.TotalSizeDiscounts 
 , F.InterpolateTable = U.InterpolateTable 
 , F.MaterialTypeNameKey = U.MaterialTypeNameKey 
 , F.ChargeForScrap = U.ChargeForScrap 
 , F.ScrapChargeRate = U.ScrapChargeRate 
 , F.MaterialHeight = U.MaterialHeight 
 , F.MaterialWidth = U.MaterialWidth 
 , F.MaterialDepth = U.MaterialDepth 
 , F.PanelMaterial = U.PanelMaterial 
 , F.PanelGap = U.PanelGap 
 , F.Material2Sided = U.Material2Sided 
 , F.HiddenByDefault = U.HiddenByDefault 
 , F.ProductActive = U.ProductActive 
 , F.CostToPriceMargin = U.CostToPriceMargin 
 , F.PriceFormulaKey = U.PriceFormulaKey 
 , F.CostFormulaKey = U.CostFormulaKey 
 , F.OEEntryFormatID = U.OEEntryFormatID 
 , F.SetupFormulaKey = U.SetupFormulaKey 
 , F.TilePieces = U.TilePieces 
 , F.RotatePieces = U.RotatePieces 
 , F.AvoidPaneling = U.AvoidPaneling 
 , F.ChargeForExtraPanels = U.ChargeForExtraPanels 
 , F.PanelChargeRate = U.PanelChargeRate 
 , F.PanelChargeAmount = U.PanelChargeAmount 
 , F.DefaultProdNotesKey = U.DefaultProdNotesKey 
 , F.xSortMarker = U.xSortMarker 
 , F.LimitToTable = U.LimitToTable 
 , F.FlagsKey = U.FlagsKey 
 , F.RoyaltyGroupID = U.RoyaltyGroupID 
 , F.OLTP_InsertDate = U.OLTP_InsertDate 
 , F.OLTP_UpdateDate = U.OLTP_UpdateDate 
 , F.UpdateCheckSum = U.UpdateCheckSum 
 , F.CenterKey = U.CenterKey
 , F.KeystoneProductKey = U.KeystoneProductKey
FROM [Staging].[dbo].[ProductFactUpdate] U 
     JOIN [Product].[ProductFact] F ON U.ProductKey = F.ProductKey 
 WHERE U.ProductKey > 0 
 
INSERT INTO  [Product].[ProductFact] 
    ( ZW_Franchise_ID 
 , ProductID 
 , ProductCodeKey 
 , ProductCategoryID 
 , VolumeCategoryID 
 , AVICategoryID 
 , DescriptionKey 
 , PricingStructure 
 , DefaultProductionLocation 
 , ForegroundColorsKey 
 , BackgroundColorKey 
 , Font 
 , PriceBasedOnKey 
 , DefaultHeight 
 , DefaultWidth 
 , InputUnits 
 , PricingUnits 
 , ThicknessKey 
 , MinNumberSides 
 , MaxNumberSides 
 , DefaultSides 
 , SecondSidePremium 
 , SetupCharge 
 , MinUnitPrice 
 , MinLineItemPrice 
 , BaseUnitCharge 
 , Taxable 
 , AllInstallation 
 , StandardDeliveryTime 
 , ProductionRate 
 , RoundingType 
 , FGColorListID 
 , RestrictFGColorToList 
 , BGColorListID 
 , RestrictBGColorToList 
 , FontListID 
 , RestrictFontToList 
 , RoundSizeToTable 
 , ExtrapolateTable 
 , FixedPerPieceCharge 
 , SecondSideSetup 
 , SecondSidePerPieceCharge 
 , ProductImageID 
 , PriceSheetID 
 , BaseUnitCost 
 , DetailDescriptionKey 
 , SymmetricTable 
 , TotalSizeDiscounts 
 , InterpolateTable 
 , MaterialTypeNameKey 
 , ChargeForScrap 
 , ScrapChargeRate 
 , MaterialHeight 
 , MaterialWidth 
 , MaterialDepth 
 , PanelMaterial 
 , PanelGap 
 , Material2Sided 
 , HiddenByDefault 
 , ProductActive 
 , CostToPriceMargin 
 , PriceFormulaKey 
 , CostFormulaKey 
 , OEEntryFormatID 
 , SetupFormulaKey 
 , TilePieces 
 , RotatePieces 
 , AvoidPaneling 
 , ChargeForExtraPanels 
 , PanelChargeRate 
 , PanelChargeAmount 
 , DefaultProdNotesKey 
 , xSortMarker 
 , LimitToTable 
 , FlagsKey 
 , RoyaltyGroupID 
 , OLTP_InsertDate 
 , OLTP_UpdateDate 
 , UpdateCheckSum 
 , CenterKey
 , KeystoneProductKey
 ) SELECT ZW_Franchise_ID 
 , ProductID 
 , ProductCodeKey 
 , ProductCategoryID 
 , VolumeCategoryID 
 , AVICategoryID 
 , DescriptionKey 
 , PricingStructure 
 , DefaultProductionLocation 
 , ForegroundColorsKey 
 , BackgroundColorKey 
 , Font 
 , PriceBasedOnKey 
 , DefaultHeight 
 , DefaultWidth 
 , InputUnits 
 , PricingUnits 
 , ThicknessKey 
 , MinNumberSides 
 , MaxNumberSides 
 , DefaultSides 
 , SecondSidePremium 
 , SetupCharge 
 , MinUnitPrice 
 , MinLineItemPrice 
 , BaseUnitCharge 
 , Taxable 
 , AllInstallation 
 , StandardDeliveryTime 
 , ProductionRate 
 , RoundingType 
 , FGColorListID 
 , RestrictFGColorToList 
 , BGColorListID 
 , RestrictBGColorToList 
 , FontListID 
 , RestrictFontToList 
 , RoundSizeToTable 
 , ExtrapolateTable 
 , FixedPerPieceCharge 
 , SecondSideSetup 
 , SecondSidePerPieceCharge 
 , ProductImageID 
 , PriceSheetID 
 , BaseUnitCost 
 , DetailDescriptionKey 
 , SymmetricTable 
 , TotalSizeDiscounts 
 , InterpolateTable 
 , MaterialTypeNameKey 
 , ChargeForScrap 
 , ScrapChargeRate 
 , MaterialHeight 
 , MaterialWidth 
 , MaterialDepth 
 , PanelMaterial 
 , PanelGap 
 , Material2Sided 
 , HiddenByDefault 
 , ProductActive 
 , CostToPriceMargin 
 , PriceFormulaKey 
 , CostFormulaKey 
 , OEEntryFormatID 
 , SetupFormulaKey 
 , TilePieces 
 , RotatePieces 
 , AvoidPaneling 
 , ChargeForExtraPanels 
 , PanelChargeRate 
 , PanelChargeAmount 
 , DefaultProdNotesKey 
 , xSortMarker 
 , LimitToTable 
 , FlagsKey 
 , RoyaltyGroupID 
 , OLTP_InsertDate 
 , OLTP_UpdateDate 
 , UpdateCheckSum 
 , CenterKey
 , KeystoneProductKey
 FROM [Staging].[dbo].[ProductFactUpdate] WHERE ProductKey = 0 

UPDATE Product.ProductFact SET ProductID = ProductKey WHERE ProductID IS NULL AND KeystoneProductKey IS NOT NULL

TRUNCATE TABLE Staging.dbo.ProductFactUpdate 

GO
