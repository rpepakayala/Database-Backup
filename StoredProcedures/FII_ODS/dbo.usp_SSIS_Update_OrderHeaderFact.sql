/****** Object:  StoredProcedure [dbo].[usp_SSIS_Update_OrderHeaderFact]    Script Date: 5/15/2018 12:09:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_Update_OrderHeaderFact]
 AS UPDATE F SET 
 F.ZW_Franchise_ID = U.ZW_Franchise_ID 
 , F.OrderID = U.OrderID 
 , F.PricingRatio = U.PricingRatio 
 , F.DescriptionKey = U.DescriptionKey 
 , F.NumberItems = U.NumberItems 
 , F.CustomerID = U.CustomerID 
 , F.CustomerKey = U.CustomerKey 
 , F.ContactID = U.ContactID 
-- , F.ContactKey = U.ContactKey 
 , F.OrdererFirstName = U.OrdererFirstName 
 , F.OrdererLastName = U.OrdererLastName 
 , F.OrdererTitle = U.OrdererTitle 
 , F.OrdererPareaCode = U.OrdererPareaCode 
 , F.OrdererPhoneNumber = U.OrdererPhoneNumber 
 , F.OrdererPhoneExtention = U.OrdererPhoneExtention 
 , F.OrdererFareaCode = U.OrdererFareaCode 
 , F.OrdererFaxNumber = U.OrdererFaxNumber 
 , F.OrdererEmailAddress = U.OrdererEmailAddress 
 , F.SalePersonID = U.SalePersonID 
 , F.SalePersonKey = U.SalePersonKey 
 , F.EnteredByID = U.EnteredByID 
 , F.EnteredByKey = U.EnteredByKey 
 , F.StatusKey = U.StatusKey 
 , F.OnHold = U.OnHold 
 , F.EstimateDate = U.EstimateDate 
 , F.OrderDate = U.OrderDate 
 , F.DueDate = U.DueDate 
 , F.BuiltDate = U.BuiltDate 
 , F.VoidDate = U.VoidDate 
 , F.PickedUpDate = U.PickedUpDate 
 , F.WriteoffDate = U.WriteoffDate 
 , F.HoldDate = U.HoldDate 
 , F.LastInterestDate = U.LastInterestDate 
 , F.ClosedDate = U.ClosedDate 
 , F.SignSales = U.SignSales 
 , F.AVISales = U.AVISales 
 , F.InstallSales = U.InstallSales 
 , F.ProductionCat1Sales = U.ProductionCat1Sales 
 , F.ProductionCat2Sales = U.ProductionCat2Sales 
 , F.ProductionCat3Sales = U.ProductionCat3Sales 
 , F.ItemsTotal = U.ItemsTotal 
 , F.SalesSubtotal = U.SalesSubtotal 
 , F.TaxableAmount = U.TaxableAmount 
 , F.TaxExemptAmount = U.TaxExemptAmount 
 , F.TaxExemptAmountCalculated = U.TaxExemptAmountCalculated 
 , F.TaxExemptAmountOverridden = U.TaxExemptAmountOverridden 
 , F.TaxExempt = U.TaxExempt 
 , F.TaxIDNumber = U.TaxIDNumber 
 , F.TaxRegionID = U.TaxRegionID 
 , F.CountySalesTax = U.CountySalesTax 
 , F.CountySalesTaxRate = U.CountySalesTaxRate 
 , F.StateSalesTax = U.StateSalesTax 
 , F.StateSalesTaxRate = U.StateSalesTaxRate 
 , F.TaxTotal = U.TaxTotal 
 , F.PromotionID = U.PromotionID 
 , F.DiscountAmount = U.DiscountAmount 
 , F.DiscountPercent = U.DiscountPercent 
 , F.ShippingCharge = U.ShippingCharge 
 , F.InterestAmount = U.InterestAmount 
 , F.SalesTotal = U.SalesTotal 
 , F.TotalPayments = U.TotalPayments 
 , F.BalanceOutstanding = U.BalanceOutstanding 
 , F.WriteoffAmount = U.WriteoffAmount 
 , F.PurchaseOrderNumberKey = U.PurchaseOrderNumberKey 
 , F.ShippingAddress = U.ShippingAddress 
 , F.DispositionOnCompletion = U.DispositionOnCompletion 
 , F.OrderNotesKey = U.OrderNotesKey 
 , F.InstallNotesKey = U.InstallNotesKey 
 , F.EstimateNumber = U.EstimateNumber 
 , F.ItemsDiscountTotal = U.ItemsDiscountTotal 
 , F.DiscountTotal = U.DiscountTotal 
 , F.DispositionOnCompletionID = U.DispositionOnCompletionID 
 , F.CustomerName = U.CustomerName 
 , F.ShippingTaxable = U.ShippingTaxable 
 , F.RoyaltyRate = U.RoyaltyRate 
 , F.JobBox = U.JobBox 
 , F.ProofDate = U.ProofDate 
 , F.LineItemsOverriden = U.LineItemsOverriden 
 , F.OrderOriginID = U.OrderOriginID 
 , F.IsLocked = U.IsLocked 
 , F.LockedDate = U.LockedDate 
-- , F.LockedUserKey = U.LockedUserKey 
 , F.ModifiedDate = U.ModifiedDate 
 , F.ModifiedUser = U.ModifiedUser 
 , F.InvoiceID = U.InvoiceID 
 , F.OLTP_InsertDate = U.OLTP_InsertDate 
 , F.OLTP_UpdateDate = U.OLTP_UpdateDate 
 , F.UpdateCheckSum = U.UpdateCheckSum 
 , F.CenterKey = U.CenterKey
 , F.ContactKey = U.ContactKey
FROM [Staging].[dbo].[OrderHeaderFactUpdate] U 
     JOIN [Orders].[OrderHeaderFact] F ON U.OrderHeaderKey = F.OrderHeaderKey 
 WHERE U.OrderHeaderKey > 0 
 
INSERT INTO  [Orders].[OrderHeaderFact] 
    ( ZW_Franchise_ID 
 , OrderID 
 , PricingRatio 
 , DescriptionKey 
 , NumberItems 
 , CustomerID 
 , CustomerKey 
 , ContactID 
-- , ContactKey 
 , OrdererFirstName 
 , OrdererLastName 
 , OrdererTitle 
 , OrdererPareaCode 
 , OrdererPhoneNumber 
 , OrdererPhoneExtention 
 , OrdererFareaCode 
 , OrdererFaxNumber 
 , OrdererEmailAddress 
 , SalePersonID 
 , SalePersonKey 
 , EnteredByID 
 , EnteredByKey 
 , StatusKey 
 , OnHold 
 , EstimateDate 
 , OrderDate 
 , DueDate 
 , BuiltDate 
 , VoidDate 
 , PickedUpDate 
 , WriteoffDate 
 , HoldDate 
 , LastInterestDate 
 , ClosedDate 
 , SignSales 
 , AVISales 
 , InstallSales 
 , ProductionCat1Sales 
 , ProductionCat2Sales 
 , ProductionCat3Sales 
 , ItemsTotal 
 , SalesSubtotal 
 , TaxableAmount 
 , TaxExemptAmount 
 , TaxExemptAmountCalculated 
 , TaxExemptAmountOverridden 
 , TaxExempt 
 , TaxIDNumber 
 , TaxRegionID 
 , CountySalesTax 
 , CountySalesTaxRate 
 , StateSalesTax 
 , StateSalesTaxRate 
 , TaxTotal 
 , PromotionID 
 , DiscountAmount 
 , DiscountPercent 
 , ShippingCharge 
 , InterestAmount 
 , SalesTotal 
 , TotalPayments 
 , BalanceOutstanding 
 , WriteoffAmount 
 , PurchaseOrderNumberKey 
 , ShippingAddress 
 , DispositionOnCompletion 
 , OrderNotesKey 
 , InstallNotesKey 
 , EstimateNumber 
 , ItemsDiscountTotal 
 , DiscountTotal 
 , DispositionOnCompletionID 
 , CustomerName 
 , ShippingTaxable 
 , RoyaltyRate 
 , JobBox 
 , ProofDate 
 , LineItemsOverriden 
 , OrderOriginID 
 , IsLocked 
 , LockedDate 
-- , LockedUserKey 
 , ModifiedDate 
 , ModifiedUser 
 , InvoiceID 
 , OLTP_InsertDate 
 , OLTP_UpdateDate 
 , UpdateCheckSum 
 , CenterKey
 , ContactKey
 ) SELECT ZW_Franchise_ID 
 , OrderID 
 , PricingRatio 
 , DescriptionKey 
 , NumberItems 
 , CustomerID 
 , CustomerKey 
 , ContactID 
-- , ContactKey 
 , OrdererFirstName 
 , OrdererLastName 
 , OrdererTitle 
 , OrdererPareaCode 
 , OrdererPhoneNumber 
 , OrdererPhoneExtention 
 , OrdererFareaCode 
 , OrdererFaxNumber 
 , OrdererEmailAddress 
 , SalePersonID 
 , SalePersonKey 
 , EnteredByID 
 , EnteredByKey 
 , StatusKey 
 , OnHold 
 , EstimateDate 
 , OrderDate 
 , DueDate 
 , BuiltDate 
 , VoidDate 
 , PickedUpDate 
 , WriteoffDate 
 , HoldDate 
 , LastInterestDate 
 , ClosedDate 
 , SignSales 
 , AVISales 
 , InstallSales 
 , ProductionCat1Sales 
 , ProductionCat2Sales 
 , ProductionCat3Sales 
 , ItemsTotal 
 , SalesSubtotal 
 , TaxableAmount 
 , TaxExemptAmount 
 , TaxExemptAmountCalculated 
 , TaxExemptAmountOverridden 
 , TaxExempt 
 , TaxIDNumber 
 , TaxRegionID 
 , CountySalesTax 
 , CountySalesTaxRate 
 , StateSalesTax 
 , StateSalesTaxRate 
 , TaxTotal 
 , PromotionID 
 , DiscountAmount 
 , DiscountPercent 
 , ShippingCharge 
 , InterestAmount 
 , SalesTotal 
 , TotalPayments 
 , BalanceOutstanding 
 , WriteoffAmount 
 , PurchaseOrderNumberKey 
 , ShippingAddress 
 , DispositionOnCompletion 
 , OrderNotesKey 
 , InstallNotesKey 
 , EstimateNumber 
 , ItemsDiscountTotal 
 , DiscountTotal 
 , DispositionOnCompletionID 
 , CustomerName 
 , ShippingTaxable 
 , RoyaltyRate 
 , JobBox 
 , ProofDate 
 , LineItemsOverriden 
 , OrderOriginID 
 , IsLocked 
 , LockedDate 
-- , LockedUserKey 
 , ModifiedDate 
 , ModifiedUser 
 , InvoiceID 
 , OLTP_InsertDate 
 , OLTP_UpdateDate 
 , UpdateCheckSum 
 , CenterKey
 , ContactKey
 FROM [Staging].[dbo].[OrderHeaderFactUpdate] WHERE OrderHeaderKey = 0 
TRUNCATE TABLE Staging.dbo.OrderHeaderFactUpdate 

GO
