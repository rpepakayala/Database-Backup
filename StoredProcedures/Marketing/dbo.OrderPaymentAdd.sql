/****** Object:  StoredProcedure [dbo].[OrderPaymentAdd]    Script Date: 5/15/2018 12:10:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OrderPaymentAdd
(
	@OrdHId int = NULL,
	@OrdPmId int = NULL,
	@OrdPmType tinyint = NULL,
	@OrdPmDate smalldatetime = NULL,
	@OrdPmChkNumber int = NULL,
	@OrdPmCCFSName varchar(50) = NULL,
	@OrdPmCCType varchar(50) = NULL,
	@OrdPmCCNumber varchar(50) = NULL,
	@OrdPmCCExpDate varchar(6) = NULL,
	@OrdPmName varchar(255) = NULL,
	@OrdPmAmount float = NULL,
	@OrdPmBillAddr1 varchar(255) = NULL,
	@OrdPmBillAddr2 varchar(255) = NULL,
	@OrdPmBillCity varchar(50) = NULL,
	@OrdPmBillState varchar(50) = NULL,
	@OrdPmBillPostalCode varchar(50) = NULL,
	@OrdPmBillCountry varchar(50) = NULL,
	@OrdPmBatchNo char(10) = NULL,
	@OrdPmBatchNum int = NULL,
	@OrdPmAuthCode varchar(50) = NULL,
	@OrdPmAuthReason varchar(255) = NULL,
	@OrdPmCCStatus tinyint = NULL
)
AS
INSERT INTO OrderPayment (OrdHId, OrdPmId, OrdPmType, OrdPmDate, OrdPmChkNumber, OrdPmCCFSName, OrdPmCCType, OrdPmCCNumber, OrdPmCCExpDate, OrdPmName, OrdPmAmount, OrdPmBillAddr1, OrdPmBillAddr2, OrdPmBillCity, OrdPmBillState, OrdPmBillPostalCode, OrdPmBillCountry, OrdPmBatchNo, OrdPmBatchNum, OrdPmAuthCode, OrdPmAuthReason, OrdPmCCStatus)
 VALUES (@OrdHId, @OrdPmId, @OrdPmType, @OrdPmDate, @OrdPmChkNumber, @OrdPmCCFSName, @OrdPmCCType, @OrdPmCCNumber, @OrdPmCCExpDate, @OrdPmName, @OrdPmAmount, @OrdPmBillAddr1, @OrdPmBillAddr2, @OrdPmBillCity, @OrdPmBillState, @OrdPmBillPostalCode, @OrdPmBillCountry, @OrdPmBatchNo, @OrdPmBatchNum, @OrdPmAuthCode, @OrdPmAuthReason, @OrdPmCCStatus);


GO
