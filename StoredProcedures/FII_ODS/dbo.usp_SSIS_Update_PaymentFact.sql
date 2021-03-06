/****** Object:  StoredProcedure [dbo].[usp_SSIS_Update_PaymentFact]    Script Date: 5/15/2018 12:09:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_Update_PaymentFact]
 AS UPDATE F SET 
 F.ZW_Franchise_ID = U.ZW_Franchise_ID 
 , F.PaymentID = U.PaymentID 
 , F.CustomerID = U.CustomerID 
 , F.CustomerKey = U.CustomerKey 
 , F.OrderID = U.OrderID 
 , F.OrderKey = U.OrderKey 
 , F.PaymentAmount = U.PaymentAmount 
 , F.EnteredByID = U.EnteredByID 
 , F.EnteredByKey = U.EnteredByKey 
 , F.PaymentDate = U.PaymentDate 
 , F.PaymentMethodKey = U.PaymentMethodKey 
 , F.PaymentMethodType = U.PaymentMethodType 
 , F.TrackingNumberKey = U.TrackingNumberKey 
 , F.Voided = U.Voided 
 , F.VoidDate = U.VoidDate 
 , F.VoidAmount = U.VoidAmount 
 , F.ReasonKey = U.ReasonKey 
 , F.PaymentOnOrder = U.PaymentOnOrder 
 , F.Refund = U.Refund 
 , F.TakenForStoreID = U.TakenForStoreID 
 , F.TakenForOrderID = U.TakenForOrderID 
 , F.TakenForCustomerInfoKey = U.TakenForCustomerInfoKey 
 , F.OLTP_InsertDate = U.OLTP_InsertDate 
 , F.OLTP_UpdateDate = U.OLTP_UpdateDate 
 , F.UpdateCheckSum = U.UpdateCheckSum 
FROM [Staging].[dbo].[PaymentFactUpdate] U 
     JOIN [Orders].[PaymentFact] F ON U.PaymentFactKey = F.PaymentFactKey 
 WHERE U.PaymentFactKey > 0 
 
INSERT INTO  [Orders].[PaymentFact] 
    ( ZW_Franchise_ID 
 , PaymentID 
 , CustomerID 
 , CustomerKey 
 , OrderID 
 , OrderKey 
 , PaymentAmount 
 , EnteredByID 
 , EnteredByKey 
 , PaymentDate 
 , PaymentMethodKey 
 , PaymentMethodType 
 , TrackingNumberKey 
 , Voided 
 , VoidDate 
 , VoidAmount 
 , ReasonKey 
 , PaymentOnOrder 
 , Refund 
 , TakenForStoreID 
 , TakenForOrderID 
 , TakenForCustomerInfoKey 
 , OLTP_InsertDate 
 , OLTP_UpdateDate 
 , UpdateCheckSum 
 ) SELECT ZW_Franchise_ID 
 , PaymentID 
 , CustomerID 
 , CustomerKey 
 , OrderID 
 , OrderKey 
 , PaymentAmount 
 , EnteredByID 
 , EnteredByKey 
 , PaymentDate 
 , PaymentMethodKey 
 , PaymentMethodType 
 , TrackingNumberKey 
 , Voided 
 , VoidDate 
 , VoidAmount 
 , ReasonKey 
 , PaymentOnOrder 
 , Refund 
 , TakenForStoreID 
 , TakenForOrderID 
 , TakenForCustomerInfoKey 
 , OLTP_InsertDate 
 , OLTP_UpdateDate 
 , UpdateCheckSum 
 FROM [Staging].[dbo].[PaymentFactUpdate] WHERE PaymentFactKey = 0 
TRUNCATE TABLE Staging.dbo.PaymentFactUpdate 

GO
