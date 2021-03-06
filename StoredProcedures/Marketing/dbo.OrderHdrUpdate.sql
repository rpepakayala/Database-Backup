/****** Object:  StoredProcedure [dbo].[OrderHdrUpdate]    Script Date: 5/15/2018 12:10:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OrderHdrUpdate
(
	@OrdHId int = NULL,
	@OrdHType tinyint = NULL,
	@OrdHTypeFlag bit = NULL,
	@OrdHOrigOrderId int = NULL,
	@OrdHOrigOrderIdFlag bit = NULL,
	@OrdHVendorId int = NULL,
	@OrdHVendorIdFlag bit = NULL,
	@OrdHPrdType tinyint = NULL,
	@OrdHPrdTypeFlag bit = NULL,
	@OrdHStoreNum int = NULL,
	@OrdHStoreNumFlag bit = NULL,
	@OrdHStoreId int = NULL,
	@OrdHStoreIdFlag bit = NULL,
	@OrdHDesc varchar(255) = NULL,
	@OrdHDescFlag bit = NULL,
	@OrdHDate smalldatetime = NULL,
	@OrdHDateFlag bit = NULL,
	@OrdHSignUpDeadline smalldatetime = NULL,
	@OrdHSignUpDeadlineFlag bit = NULL,
	@OrdHAmount float = NULL,
	@OrdHAmountFlag bit = NULL,
	@OrdHHandlingFee float = NULL,
	@OrdHHandlingFeeFlag bit = NULL,
	@OrdHMailOnDemandFee float = NULL,
	@OrdHMailOnDemandFeeFlag bit = NULL,
	@OrdHMailOnDemandQty int = NULL,
	@OrdHMailOnDemandQtyFlag bit = NULL,
	@OrdHMailOnDemandAmount float = NULL,
	@OrdHMailOnDemandAmountFlag bit = NULL,
	@OrdHStatus tinyint = NULL,
	@OrdHStatusFlag bit = NULL,
	@OrdHSubStatus tinyint = NULL,
	@OrdHSubStatusFlag bit = NULL,
	@OrdHFulfillmentDate smalldatetime = NULL,
	@OrdHFulfillmentDateFlag bit = NULL,
	@OrdHCCValidationDate smalldatetime = NULL,
	@OrdHCCValidationDateFlag bit = NULL,
	@OrdHShipAddr1 varchar(255) = NULL,
	@OrdHShipAddr1Flag bit = NULL,
	@OrdHShipAddr2 varchar(255) = NULL,
	@OrdHShipAddr2Flag bit = NULL,
	@OrdHShipCity varchar(50) = NULL,
	@OrdHShipCityFlag bit = NULL,
	@OrdHShipState varchar(50) = NULL,
	@OrdHShipStateFlag bit = NULL,
	@OrdHShipPostalCode varchar(50) = NULL,
	@OrdHShipPostalCodeFlag bit = NULL,
	@OrdHShipCountry varchar(50) = NULL,
	@OrdHShipCountryFlag bit = NULL,
	@OrdHShipSpecialInst varchar(4000) = NULL,
	@OrdHShipSpecialInstFlag bit = NULL,
	@OrdHShipMethod tinyint = NULL,
	@OrdHShipMethodFlag bit = NULL,
	@OrdHShipEstCost float = NULL,
	@OrdHShipEstCostFlag bit = NULL,
	@OrdhTrackingNumber varchar(50) = NULL,
	@OrdhTrackingNumberFlag bit = NULL,
	@OrdHOrdered smalldatetime = NULL,
	@OrdHOrderedFlag bit = NULL,
	@OrdHStateChanged smalldatetime = NULL,
	@OrdHStateChangedFlag bit = NULL,
	@OrdHFulfillmentEmailSent varchar(1) = NULL,
	@OrdHFulfillmentEmailSentFlag bit = NULL,
	@OrdHMailingType tinyint = NULL,
	@OrdHMailingTypeFlag bit = NULL,
	@OrdHFoldingAmount float = NULL,
	@OrdHFoldingAmountFlag bit = NULL,
	@OrdHImprintAmount float = NULL,
	@OrdHImprintAmountFlag bit = NULL,
	@OrdHUserId int = NULL,
	@OrdHUserIdFlag bit = NULL,
	@OrdHFCGList bit = NULL,
	@OrdHFCGListFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@OrdHTypeFlag Is Not NULL)
BEGIN
	IF (@OrdHType Is Not NULL)
		SET @SQL = @SQL + 'OrdHType=' + convert(varchar,@OrdHType) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHType=NULL, ';
END
IF (@OrdHOrigOrderIdFlag Is Not NULL)
BEGIN
	IF (@OrdHOrigOrderId Is Not NULL)
		SET @SQL = @SQL + 'OrdHOrigOrderId=' + convert(varchar,@OrdHOrigOrderId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHOrigOrderId=NULL, ';
END
IF (@OrdHVendorIdFlag Is Not NULL)
BEGIN
	IF (@OrdHVendorId Is Not NULL)
		SET @SQL = @SQL + 'OrdHVendorId=' + convert(varchar,@OrdHVendorId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHVendorId=NULL, ';
END
IF (@OrdHPrdTypeFlag Is Not NULL)
BEGIN
	IF (@OrdHPrdType Is Not NULL)
		SET @SQL = @SQL + 'OrdHPrdType=' + convert(varchar,@OrdHPrdType) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHPrdType=NULL, ';
END
IF (@OrdHStoreNumFlag Is Not NULL)
BEGIN
	IF (@OrdHStoreNum Is Not NULL)
		SET @SQL = @SQL + 'OrdHStoreNum=' + convert(varchar,@OrdHStoreNum) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHStoreNum=NULL, ';
END
IF (@OrdHStoreIdFlag Is Not NULL)
BEGIN
	IF (@OrdHStoreId Is Not NULL)
		SET @SQL = @SQL + 'OrdHStoreId=' + convert(varchar,@OrdHStoreId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHStoreId=NULL, ';
END
IF (@OrdHDescFlag Is Not NULL)
BEGIN
	IF (@OrdHDesc Is Not NULL)
		SET @SQL = @SQL + 'OrdHDesc=''' + @OrdHDesc + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHDesc=NULL, ';
END
IF (@OrdHDateFlag Is Not NULL)
BEGIN
	IF (@OrdHDate Is Not NULL)
		SET @SQL = @SQL + 'OrdHDate=''' + convert(varchar,@OrdHDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHDate=NULL, ';
END
IF (@OrdHSignUpDeadlineFlag Is Not NULL)
BEGIN
	IF (@OrdHSignUpDeadline Is Not NULL)
		SET @SQL = @SQL + 'OrdHSignUpDeadline=''' + convert(varchar,@OrdHSignUpDeadline) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHSignUpDeadline=NULL, ';
END
IF (@OrdHAmountFlag Is Not NULL)
BEGIN
	IF (@OrdHAmount Is Not NULL)
		SET @SQL = @SQL + 'OrdHAmount=' + convert(varchar,@OrdHAmount) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHAmount=NULL, ';
END
IF (@OrdHHandlingFeeFlag Is Not NULL)
BEGIN
	IF (@OrdHHandlingFee Is Not NULL)
		SET @SQL = @SQL + 'OrdHHandlingFee=' + convert(varchar,@OrdHHandlingFee) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHHandlingFee=NULL, ';
END
IF (@OrdHMailOnDemandFeeFlag Is Not NULL)
BEGIN
	IF (@OrdHMailOnDemandFee Is Not NULL)
		SET @SQL = @SQL + 'OrdHMailOnDemandFee=' + convert(varchar,@OrdHMailOnDemandFee) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHMailOnDemandFee=NULL, ';
END
IF (@OrdHMailOnDemandQtyFlag Is Not NULL)
BEGIN
	IF (@OrdHMailOnDemandQty Is Not NULL)
		SET @SQL = @SQL + 'OrdHMailOnDemandQty=' + convert(varchar,@OrdHMailOnDemandQty) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHMailOnDemandQty=NULL, ';
END
IF (@OrdHMailOnDemandAmountFlag Is Not NULL)
BEGIN
	IF (@OrdHMailOnDemandAmount Is Not NULL)
		SET @SQL = @SQL + 'OrdHMailOnDemandAmount=' + convert(varchar,@OrdHMailOnDemandAmount) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHMailOnDemandAmount=NULL, ';
END
IF (@OrdHStatusFlag Is Not NULL)
BEGIN
	IF (@OrdHStatus Is Not NULL)
		SET @SQL = @SQL + 'OrdHStatus=' + convert(varchar,@OrdHStatus) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHStatus=NULL, ';
END
IF (@OrdHSubStatusFlag Is Not NULL)
BEGIN
	IF (@OrdHSubStatus Is Not NULL)
		SET @SQL = @SQL + 'OrdHSubStatus=' + convert(varchar,@OrdHSubStatus) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHSubStatus=NULL, ';
END
IF (@OrdHFulfillmentDateFlag Is Not NULL)
BEGIN
	IF (@OrdHFulfillmentDate Is Not NULL)
		SET @SQL = @SQL + 'OrdHFulfillmentDate=''' + convert(varchar,@OrdHFulfillmentDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHFulfillmentDate=NULL, ';
END
IF (@OrdHCCValidationDateFlag Is Not NULL)
BEGIN
	IF (@OrdHCCValidationDate Is Not NULL)
		SET @SQL = @SQL + 'OrdHCCValidationDate=''' + convert(varchar,@OrdHCCValidationDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHCCValidationDate=NULL, ';
END
IF (@OrdHShipAddr1Flag Is Not NULL)
BEGIN
	IF (@OrdHShipAddr1 Is Not NULL)
		SET @SQL = @SQL + 'OrdHShipAddr1=''' + @OrdHShipAddr1 + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHShipAddr1=NULL, ';
END
IF (@OrdHShipAddr2Flag Is Not NULL)
BEGIN
	IF (@OrdHShipAddr2 Is Not NULL)
		SET @SQL = @SQL + 'OrdHShipAddr2=''' + @OrdHShipAddr2 + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHShipAddr2=NULL, ';
END
IF (@OrdHShipCityFlag Is Not NULL)
BEGIN
	IF (@OrdHShipCity Is Not NULL)
		SET @SQL = @SQL + 'OrdHShipCity=''' + @OrdHShipCity + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHShipCity=NULL, ';
END
IF (@OrdHShipStateFlag Is Not NULL)
BEGIN
	IF (@OrdHShipState Is Not NULL)
		SET @SQL = @SQL + 'OrdHShipState=''' + @OrdHShipState + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHShipState=NULL, ';
END
IF (@OrdHShipPostalCodeFlag Is Not NULL)
BEGIN
	IF (@OrdHShipPostalCode Is Not NULL)
		SET @SQL = @SQL + 'OrdHShipPostalCode=''' + @OrdHShipPostalCode + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHShipPostalCode=NULL, ';
END
IF (@OrdHShipCountryFlag Is Not NULL)
BEGIN
	IF (@OrdHShipCountry Is Not NULL)
		SET @SQL = @SQL + 'OrdHShipCountry=''' + @OrdHShipCountry + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHShipCountry=NULL, ';
END
IF (@OrdHShipSpecialInstFlag Is Not NULL)
BEGIN
	IF (@OrdHShipSpecialInst Is Not NULL)
		SET @SQL = @SQL + 'OrdHShipSpecialInst=''' + @OrdHShipSpecialInst + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHShipSpecialInst=NULL, ';
END
IF (@OrdHShipMethodFlag Is Not NULL)
BEGIN
	IF (@OrdHShipMethod Is Not NULL)
		SET @SQL = @SQL + 'OrdHShipMethod=' + convert(varchar,@OrdHShipMethod) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHShipMethod=NULL, ';
END
IF (@OrdHShipEstCostFlag Is Not NULL)
BEGIN
	IF (@OrdHShipEstCost Is Not NULL)
		SET @SQL = @SQL + 'OrdHShipEstCost=' + convert(varchar,@OrdHShipEstCost) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHShipEstCost=NULL, ';
END
IF (@OrdhTrackingNumberFlag Is Not NULL)
BEGIN
	IF (@OrdhTrackingNumber Is Not NULL)
		SET @SQL = @SQL + 'OrdhTrackingNumber=''' + @OrdhTrackingNumber + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdhTrackingNumber=NULL, ';
END
IF (@OrdHOrderedFlag Is Not NULL)
BEGIN
	IF (@OrdHOrdered Is Not NULL)
		SET @SQL = @SQL + 'OrdHOrdered=''' + convert(varchar,@OrdHOrdered) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHOrdered=NULL, ';
END
IF (@OrdHStateChangedFlag Is Not NULL)
BEGIN
	IF (@OrdHStateChanged Is Not NULL)
		SET @SQL = @SQL + 'OrdHStateChanged=''' + convert(varchar,@OrdHStateChanged) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHStateChanged=NULL, ';
END
IF (@OrdHFulfillmentEmailSentFlag Is Not NULL)
BEGIN
	IF (@OrdHFulfillmentEmailSent Is Not NULL)
		SET @SQL = @SQL + 'OrdHFulfillmentEmailSent=''' + @OrdHFulfillmentEmailSent + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdHFulfillmentEmailSent=NULL, ';
END
IF (@OrdHMailingTypeFlag Is Not NULL)
BEGIN
	IF (@OrdHMailingType Is Not NULL)
		SET @SQL = @SQL + 'OrdHMailingType=' + convert(varchar,@OrdHMailingType) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHMailingType=NULL, ';
END
IF (@OrdHFoldingAmountFlag Is Not NULL)
BEGIN
	IF (@OrdHFoldingAmount Is Not NULL)
		SET @SQL = @SQL + 'OrdHFoldingAmount=' + convert(varchar,@OrdHFoldingAmount) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHFoldingAmount=NULL, ';
END
IF (@OrdHImprintAmountFlag Is Not NULL)
BEGIN
	IF (@OrdHImprintAmount Is Not NULL)
		SET @SQL = @SQL + 'OrdHImprintAmount=' + convert(varchar,@OrdHImprintAmount) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHImprintAmount=NULL, ';
END
IF (@OrdHUserIdFlag Is Not NULL)
BEGIN
	IF (@OrdHUserId Is Not NULL)
		SET @SQL = @SQL + 'OrdHUserId=' + convert(varchar,@OrdHUserId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHUserId=NULL, ';
END
IF (@OrdHFCGListFlag Is Not NULL)
BEGIN
	IF (@OrdHFCGList Is Not NULL)
		SET @SQL = @SQL + 'OrdHFCGList=' + convert(varchar,@OrdHFCGList) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHFCGList=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE OrderHdr SET ' + Left(@SQL, Len(@SQL)-1) + ' Where OrdHId = ' + convert(varchar,@OrdHId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
