/****** Object:  StoredProcedure [dbo].[usp_SSIS_Update_EstimateDetailFact]    Script Date: 5/15/2018 12:09:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
Create PROCEDURE [dbo].[usp_SSIS_Update_EstimateDetailFact]
 AS 
 UPDATE F SET 
 F.ZW_Franchise_ID = U.ZW_Franchise_ID 
 , F.OrderDetailID = U.OrderDetailID 
 , F.OrderID = U.OrderID 
-- , F.OrderHeaderKey = U.OrderHeaderKey 
 , F.LineItemNumber = U.LineItemNumber 
 , F.ProductID = U.ProductID 
-- , F.ProductKey = U.ProductKey 
 , F.ProductCodeKey = U.ProductCodeKey 
 , F.Quantity = U.Quantity 
 , F.Sides = U.Sides 
 , F.Height = U.Height 
 , F.Width = U.Width 
 , F.ForegroundColorKey = U.ForegroundColorKey 
 , F.BackgroundColorKey = U.BackgroundColorKey 
 , F.FontKey = U.FontKey 
 , F.BasePrice = U.BasePrice 
 , F.BasePriceOverriden = U.BasePriceOverriden 
 , F.BasePriceCalculated = U.BasePriceCalculated 
 , F.AVTotal = U.AVTotal 
 , F.InstallAmount = U.InstallAmount 
 , F.DiscountAmount = U.DiscountAmount 
 , F.DiscountPercentage = U.DiscountPercentage 
 , F.ItemTotal = U.ItemTotal 
 , F.UnitPriceOverridden = U.UnitPriceOverridden 
 , F.OverRidden = U.OverRidden 
 , F.ItemTotalCalculated = U.ItemTotalCalculated 
 , F.Taxable = U.Taxable 
 , F.AllInstallation = U.AllInstallation 
 , F.DescriptionKey = U.DescriptionKey 
 , F.SignTextKey = U.SignTextKey 
 , F.AVAdditionalAmt = U.AVAdditionalAmt 
 , F.AVAdditionalDescriptionKey = U.AVAdditionalDescriptionKey 
 , F.AVOverridden = U.AVOverridden 
 , F.AVCalculated = U.AVCalculated 
 , F.ProductionLocation = U.ProductionLocation 
 , F.ShopTime = U.ShopTime 
 , F.FieldTime = U.FieldTime 
 , F.FieldCrewSize = U.FieldCrewSize 
 , F.MaterialCost = U.MaterialCost 
 , F.HeightAboveGround = U.HeightAboveGround 
 , F.ProductionCat3Sales = U.ProductionCat3Sales 
 , F.OtherInstallConsideration = U.OtherInstallConsideration 
 , F.SpecialEquipment1 = U.SpecialEquipment1 
 , F.SpecialEquipment2 = U.SpecialEquipment2 
 , F.SpecialEquipment3 = U.SpecialEquipment3 
 , F.SpecialEquipmentOther = U.SpecialEquipmentOther 
 , F.SpecialEquipmentOtherAmou = U.SpecialEquipmentOtherAmou 
 , F.EstimatedInstallCharge = U.EstimatedInstallCharge 
 , F.AccountCode = U.AccountCode 
 , F.Hidden = U.Hidden 
 , F.PMsAnswered = U.PMsAnswered 
 , F.ParentItemNumber = U.ParentItemNumber 
 , F.StateSalesTax = U.StateSalesTax 
 , F.StateSalesTaxRate = U.StateSalesTaxRate 
 , F.ChildLevel = U.ChildLevel 
 , F.BaseCost = U.BaseCost 
 , F.ProductionNotesKey = U.ProductionNotesKey 
 , F.HasChildren = U.HasChildren 
 , F.BaseSonsPrice = U.BaseSonsPrice 
 , F.BaseMeAndSonsPrice = U.BaseMeAndSonsPrice 
 , F.InstallSonsPrice = U.InstallSonsPrice 
 , F.InstallMeAndSonsPrice = U.InstallMeAndSonsPrice 
 , F.DiscountSonsPrice = U.DiscountSonsPrice 
 , F.DiscountMeAndSonsPrice = U.DiscountMeAndSonsPrice 
 , F.ItemTotalSonsPrice = U.ItemTotalSonsPrice 
 , F.ItemTotalMeAndSonsPrice = U.ItemTotalMeAndSonsPrice 
 , F.RoyaltyGroupID = U.RoyaltyGroupID 
 , F.OLTP_InsertDate = U.OLTP_InsertDate 
 , F.OLTP_UpdateDate = U.OLTP_UpdateDate 
 , F.UpdateCheckSum = U.UpdateCheckSum 
-- , F.CenterKey = U.CenterKey
FROM [Staging].[dbo].[EstimateDetailFactUpdate] U 
     JOIN Estimate.[EstimateDetailFact] F ON U.EstimateDetailKey = F.EstimateDetailKey 
 WHERE U.EstimateDetailKey > 0 


INSERT INTO  Estimate.[EstimateDetailFact] 
    ( ZW_Franchise_ID 
 , OrderDetailID 
 , OrderID 
 , LineItemNumber 
 , ProductID 
 , ProductCodeKey 
 , Quantity 
 , Sides 
 , Height 
 , Width 
 , ForegroundColorKey 
 , BackgroundColorKey 
 , FontKey 
 , BasePrice 
 , BasePriceOverriden 
 , BasePriceCalculated 
 , AVTotal 
 , InstallAmount 
 , DiscountAmount 
 , DiscountPercentage 
 , ItemTotal 
 , UnitPriceOverridden 
 , OverRidden 
 , ItemTotalCalculated 
 , Taxable 
 , AllInstallation 
 , DescriptionKey 
 , SignTextKey 
 , AVAdditionalAmt 
 , AVAdditionalDescriptionKey 
 , AVOverridden 
 , AVCalculated 
 , ProductionLocation 
 , ShopTime 
 , FieldTime 
 , FieldCrewSize 
 , MaterialCost 
 , HeightAboveGround 
 , ProductionCat3Sales 
 , OtherInstallConsideration 
 , SpecialEquipment1 
 , SpecialEquipment2 
 , SpecialEquipment3 
 , SpecialEquipmentOther 
 , SpecialEquipmentOtherAmou 
 , EstimatedInstallCharge 
 , AccountCode 
 , Hidden 
 , PMsAnswered 
 , ParentItemNumber 
 , StateSalesTax 
 , StateSalesTaxRate 
 , ChildLevel 
 , BaseCost 
 , ProductionNotesKey 
 , HasChildren 
 , BaseSonsPrice 
 , BaseMeAndSonsPrice 
 , InstallSonsPrice 
 , InstallMeAndSonsPrice 
 , DiscountSonsPrice 
 , DiscountMeAndSonsPrice 
 , ItemTotalSonsPrice 
 , ItemTotalMeAndSonsPrice 
 , RoyaltyGroupID 
 , OLTP_InsertDate 
 , OLTP_UpdateDate 
 , UpdateCheckSum
 ) SELECT ZW_Franchise_ID 
 , OrderDetailID 
 , OrderID 
-- , OrderHeaderKey 
 , LineItemNumber 
 , ProductID 
 , ProductCodeKey 
 , Quantity 
 , Sides 
 , Height 
 , Width 
 , ForegroundColorKey 
 , BackgroundColorKey 
 , FontKey 
 , BasePrice 
 , BasePriceOverriden 
 , BasePriceCalculated 
 , AVTotal 
 , InstallAmount 
 , DiscountAmount 
 , DiscountPercentage 
 , ItemTotal 
 , UnitPriceOverridden 
 , OverRidden 
 , ItemTotalCalculated 
 , Taxable 
 , AllInstallation 
 , DescriptionKey 
 , SignTextKey 
 , AVAdditionalAmt 
 , AVAdditionalDescriptionKey 
 , AVOverridden 
 , AVCalculated 
 , ProductionLocation 
 , ShopTime 
 , FieldTime 
 , FieldCrewSize 
 , MaterialCost 
 , HeightAboveGround 
 , ProductionCat3Sales 
 , OtherInstallConsideration 
 , SpecialEquipment1 
 , SpecialEquipment2 
 , SpecialEquipment3 
 , SpecialEquipmentOther 
 , SpecialEquipmentOtherAmou 
 , EstimatedInstallCharge 
 , AccountCode 
 , Hidden 
 , PMsAnswered 
 , ParentItemNumber 
 , StateSalesTax 
 , StateSalesTaxRate 
 , ChildLevel 
 , BaseCost 
 , ProductionNotesKey 
 , HasChildren 
 , BaseSonsPrice 
 , BaseMeAndSonsPrice 
 , InstallSonsPrice 
 , InstallMeAndSonsPrice 
 , DiscountSonsPrice 
 , DiscountMeAndSonsPrice 
 , ItemTotalSonsPrice 
 , ItemTotalMeAndSonsPrice 
 , RoyaltyGroupID 
 , OLTP_InsertDate 
 , OLTP_UpdateDate 
 , UpdateCheckSum 
 FROM [Staging].[dbo].[EstimateDetailFactUpdate] WHERE EstimateDetailKey = 0 

TRUNCATE TABLE Staging.dbo.OrderDetailFactUpdate 

GO
