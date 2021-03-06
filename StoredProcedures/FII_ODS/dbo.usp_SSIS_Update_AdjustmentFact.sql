/****** Object:  StoredProcedure [dbo].[usp_SSIS_Update_AdjustmentFact]    Script Date: 5/15/2018 12:09:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_Update_AdjustmentFact]
 AS UPDATE F SET 
 F.ZW_Franchise_ID = U.ZW_Franchise_ID 
 , F.AdjustmentID = U.AdjustmentID 
 , F.OrderID = U.OrderID 
 , F.CustomerID = U.CustomerID 
 , F.EstimateID = U.EstimateID 
 , F.AdjustmentDate = U.AdjustmentDate 
 , F.AdjustedBy = U.AdjustedBy 
 , F.Amount = U.Amount 
 , F.ReasonKey = U.ReasonKey 
 , F.ReasonCodeKey = U.ReasonCodeKey 
 , F.OrderStatus = U.OrderStatus 
 , F.OLTP_InsertDate = U.OLTP_InsertDate 
 , F.OLTP_UpdateDate = U.OLTP_UpdateDate 
 , F.UpdateCheckSum = U.UpdateCheckSum 
FROM [Staging].[dbo].[AdjustmentFactUpdate] U 
     JOIN [Orders].[AdjustmentFact] F ON U.AdjustmentKey = F.AdjustmentKey 
 WHERE U.AdjustmentKey > 0 
 
INSERT INTO  [Orders].[AdjustmentFact] 
    ( ZW_Franchise_ID 
 , AdjustmentID 
 , OrderID 
 , CustomerID 
 , EstimateID 
 , AdjustmentDate 
 , AdjustedBy 
 , Amount 
 , ReasonKey 
 , ReasonCodeKey 
 , OrderStatus 
 , OLTP_InsertDate 
 , OLTP_UpdateDate 
 , UpdateCheckSum 
 ) SELECT ZW_Franchise_ID 
 , AdjustmentID 
 , OrderID 
 , CustomerID 
 , EstimateID 
 , AdjustmentDate 
 , AdjustedBy 
 , Amount 
 , ReasonKey 
 , ReasonCodeKey 
 , OrderStatus 
 , OLTP_InsertDate 
 , OLTP_UpdateDate 
 , UpdateCheckSum 
 FROM [Staging].[dbo].[AdjustmentFactUpdate] WHERE AdjustmentKey = 0 
TRUNCATE TABLE Staging.dbo.AdjustmentFactUpdate 

GO
