/****** Object:  StoredProcedure [dbo].[usp_SSIS_Update_CloseOutFact]    Script Date: 5/15/2018 12:09:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[usp_SSIS_Update_CloseOutFact]
AS 
    UPDATE
        F
    SET 
        [AVISales]=U.[AVISales]
      ,[InstallSales]=U.[InstallSales]
      ,[ProductionCat1Sales]=U.[ProductionCat1Sales]
      ,[ProductionCat2Sales]=U.[ProductionCat2Sales]
      ,[ProductionCat3Sales]=U.[ProductionCat3Sales]
      ,[SalesSubtotal]=U.[SalesSubtotal]
      ,[TaxExemptAmount]=U.[TaxExemptAmount]
      ,[CountySalesTax]=U.[CountySalesTax]
      ,[StateSalesTax]=U.[StateSalesTax]
      ,[TaxTotal]=U.[TaxTotal]
      ,[DiscountAmount]=U.[DiscountAmount]
      ,[ShippingCharge]=U.[ShippingCharge]
      ,[InterestAmount]=U.[InterestAmount]
      ,[SalesTotal]=U.[SalesTotal]
      ,[WriteOffAmount]=U.[WriteOffAmount]
      ,[OrderPayments]=U.[OrderPayments]
      ,[OtherPayments]=U.[OtherPayments]
      ,[CloseOutPersonID]=U.[CloseOutPersonID]
      ,[OLTP_Insertdate]=U.[OLTP_Insertdate]
      ,[OLTP_Updatedate]=U.[OLTP_Updatedate]
	  ,UpdateCheckSum=U.UpdateCheckSum
FROM
    Staging.dbo.[CloseOutFact] AS U WITH ( NOLOCK )
    JOIN [Orders].[CloseOutFact] F WITH ( NOLOCK ) ON  U.zw_franchise_id = F.ZW_Franchise_ID
		AND U.CloseOutDate = F.CloseOutDate AND U.CloseOutType = F.CloseOutType
WHERE U.UpdateCheckSum <> F.UpdateCheckSum 
 
 

    TRUNCATE TABLE Staging.dbo.[CloseOutFact]

GO
