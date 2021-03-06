/****** Object:  StoredProcedure [dbo].[PaymentGet]    Script Date: 5/15/2018 12:10:22 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.PaymentGet 
(
	@Filter  varchar(4000) = null,
	@OrderBy varchar(4000) = null
)
AS 
DECLARE @SQL varchar(4000);
SET @SQL =  '
SELECT OrderPayment.OrdHId, OrderPayment.OrdPmId, OrderPayment.OrdPmType, OrderPayment.OrdPmDate, OrderPayment.OrdPmChkNumber, 
               OrderPayment.OrdPmCCNumber, OrderPayment.OrdPmCCExpDate, OrderPayment.OrdPmName, OrderPayment.OrdPmAmount, 
               OrderPayment.OrdPmBillAddr1, OrderPayment.OrdPmBillAddr2, OrderPayment.OrdPmBillCity, OrderPayment.OrdPmState, 
               OrderPayment.OrdPmBillPostalCode, OrderPayment.OrdPmBillCountry, OrderPayment.OrdPmBatchNo, OrderPayment.OrdPmBatchNum, 
               OrderPayment.OrdPmAuthCode, OrderPayment.OrdPmAuthReason, OrderPayment.OrdPmCCStatus, OrderHdr.OrdHType, OrderHdr.OrdHVendorId, 
               OrderHdr.OrdHDate, OrderHdr.OrdHStatus,  OrdHSubStatus,  OrderHdr.OrdHFulfillmentDate
FROM  OrderPayment INNER JOIN
               OrderHdr ON OrderPayment.OrdHId = OrderHdr.OrdHId';
	IF (@Filter Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Where ' + @Filter;
	END
	IF (@OrderBy Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Order By  ' + @OrderBy;
	END
;
EXEC(@SQL);


GO
