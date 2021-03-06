/****** Object:  StoredProcedure [dbo].[VendorUpdate]    Script Date: 5/15/2018 12:10:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.VendorUpdate
(
	@VndId int = NULL,
	@VndDesc varchar(50) = NULL,
	@VndDescFlag bit = NULL,
	@VndSignUpDeadline smallint = NULL,
	@VndSignUpDeadlineFlag bit = NULL,
	@VndUploadDBDeadline smallint = NULL,
	@VndUploadDBDeadlineFlag bit = NULL,
	@VndPickAndPackShipDays smallint = NULL,
	@VndPickAndPackShipDaysFlag bit = NULL,
	@VndPickAndPackQtyNotAvail smallint = NULL,
	@VndPickAndPackQtyNotAvailFlag bit = NULL,
	@VndPickAndPackQtyNotOrd smallint = NULL,
	@VndPickAndPackQtyNotOrdFlag bit = NULL,
	@VndImprintShipDays smallint = NULL,
	@VndImprintShipDaysFlag bit = NULL,
	@VndInventoryProcessing char(1) = NULL,
	@VndInventoryProcessingFlag bit = NULL,
	@VndInventoryRequestStartTime char(5) = NULL,
	@VndInventoryRequestStartTimeFlag bit = NULL,
	@VndCreditCardProcessing char(1) = NULL,
	@VndCreditCardProcessingFlag bit = NULL,
	@VndCreditCardStartTime char(5) = NULL,
	@VndCreditCardStartTimeFlag bit = NULL,
	@VndOrderProcessing char(1) = NULL,
	@VndOrderProcessingFlag bit = NULL,
	@VndOrderStartTime char(1) = NULL,
	@VndOrderStartTimeFlag bit = NULL,
	@VndDatabaseRequiredOveragePrc float = NULL,
	@VndDatabaseRequiredOveragePrcFlag bit = NULL,
	@VndPDFFilePath varchar(225) = NULL,
	@VndPDFFilePathFlag bit = NULL,
	@VndDBUploadPath varchar(255) = NULL,
	@VndDBUploadPathFlag bit = NULL,
	@VndMinImprintCount int = NULL,
	@VndMinImprintCountFlag bit = NULL,
	@MarketingCountry int = NULL,
	@MarketingCountryFlag bit = NULL,
	@VndEmail varchar(255) = NULL,
	@VndEmailFlag bit = NULL,
	@VndPlacedToAcceptedDeadline smallint = NULL,
	@VndPlacedToAcceptedDeadlineFlag bit = NULL,
	@VndListLeadDays smallint = NULL,
	@VndListLeadDaysFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@VndDescFlag Is Not NULL)
BEGIN
	IF (@VndDesc Is Not NULL)
		SET @SQL = @SQL + 'VndDesc=''' + @VndDesc + ''', ';
	ELSE
		SET @SQL = @SQL + 'VndDesc=NULL, ';
END
IF (@VndSignUpDeadlineFlag Is Not NULL)
BEGIN
	IF (@VndSignUpDeadline Is Not NULL)
		SET @SQL = @SQL + 'VndSignUpDeadline=' + convert(varchar,@VndSignUpDeadline) + ', ';
	ELSE
		SET @SQL = @SQL + 'VndSignUpDeadline=NULL, ';
END
IF (@VndUploadDBDeadlineFlag Is Not NULL)
BEGIN
	IF (@VndUploadDBDeadline Is Not NULL)
		SET @SQL = @SQL + 'VndUploadDBDeadline=' + convert(varchar,@VndUploadDBDeadline) + ', ';
	ELSE
		SET @SQL = @SQL + 'VndUploadDBDeadline=NULL, ';
END
IF (@VndPickAndPackShipDaysFlag Is Not NULL)
BEGIN
	IF (@VndPickAndPackShipDays Is Not NULL)
		SET @SQL = @SQL + 'VndPickAndPackShipDays=' + convert(varchar,@VndPickAndPackShipDays) + ', ';
	ELSE
		SET @SQL = @SQL + 'VndPickAndPackShipDays=NULL, ';
END
IF (@VndPickAndPackQtyNotAvailFlag Is Not NULL)
BEGIN
	IF (@VndPickAndPackQtyNotAvail Is Not NULL)
		SET @SQL = @SQL + 'VndPickAndPackQtyNotAvail=' + convert(varchar,@VndPickAndPackQtyNotAvail) + ', ';
	ELSE
		SET @SQL = @SQL + 'VndPickAndPackQtyNotAvail=NULL, ';
END
IF (@VndPickAndPackQtyNotOrdFlag Is Not NULL)
BEGIN
	IF (@VndPickAndPackQtyNotOrd Is Not NULL)
		SET @SQL = @SQL + 'VndPickAndPackQtyNotOrd=' + convert(varchar,@VndPickAndPackQtyNotOrd) + ', ';
	ELSE
		SET @SQL = @SQL + 'VndPickAndPackQtyNotOrd=NULL, ';
END
IF (@VndImprintShipDaysFlag Is Not NULL)
BEGIN
	IF (@VndImprintShipDays Is Not NULL)
		SET @SQL = @SQL + 'VndImprintShipDays=' + convert(varchar,@VndImprintShipDays) + ', ';
	ELSE
		SET @SQL = @SQL + 'VndImprintShipDays=NULL, ';
END
IF (@VndInventoryProcessingFlag Is Not NULL)
BEGIN
	IF (@VndInventoryProcessing Is Not NULL)
		SET @SQL = @SQL + 'VndInventoryProcessing=''' + @VndInventoryProcessing + ''', ';
	ELSE
		SET @SQL = @SQL + 'VndInventoryProcessing=NULL, ';
END
IF (@VndInventoryRequestStartTimeFlag Is Not NULL)
BEGIN
	IF (@VndInventoryRequestStartTime Is Not NULL)
		SET @SQL = @SQL + 'VndInventoryRequestStartTime=''' + @VndInventoryRequestStartTime + ''', ';
	ELSE
		SET @SQL = @SQL + 'VndInventoryRequestStartTime=NULL, ';
END
IF (@VndCreditCardProcessingFlag Is Not NULL)
BEGIN
	IF (@VndCreditCardProcessing Is Not NULL)
		SET @SQL = @SQL + 'VndCreditCardProcessing=''' + @VndCreditCardProcessing + ''', ';
	ELSE
		SET @SQL = @SQL + 'VndCreditCardProcessing=NULL, ';
END
IF (@VndCreditCardStartTimeFlag Is Not NULL)
BEGIN
	IF (@VndCreditCardStartTime Is Not NULL)
		SET @SQL = @SQL + 'VndCreditCardStartTime=''' + @VndCreditCardStartTime + ''', ';
	ELSE
		SET @SQL = @SQL + 'VndCreditCardStartTime=NULL, ';
END
IF (@VndOrderProcessingFlag Is Not NULL)
BEGIN
	IF (@VndOrderProcessing Is Not NULL)
		SET @SQL = @SQL + 'VndOrderProcessing=''' + @VndOrderProcessing + ''', ';
	ELSE
		SET @SQL = @SQL + 'VndOrderProcessing=NULL, ';
END
IF (@VndOrderStartTimeFlag Is Not NULL)
BEGIN
	IF (@VndOrderStartTime Is Not NULL)
		SET @SQL = @SQL + 'VndOrderStartTime=''' + @VndOrderStartTime + ''', ';
	ELSE
		SET @SQL = @SQL + 'VndOrderStartTime=NULL, ';
END
IF (@VndDatabaseRequiredOveragePrcFlag Is Not NULL)
BEGIN
	IF (@VndDatabaseRequiredOveragePrc Is Not NULL)
		SET @SQL = @SQL + 'VndDatabaseRequiredOveragePrc=' + convert(varchar,@VndDatabaseRequiredOveragePrc) + ', ';
	ELSE
		SET @SQL = @SQL + 'VndDatabaseRequiredOveragePrc=NULL, ';
END
IF (@VndPDFFilePathFlag Is Not NULL)
BEGIN
	IF (@VndPDFFilePath Is Not NULL)
		SET @SQL = @SQL + 'VndPDFFilePath=''' + @VndPDFFilePath + ''', ';
	ELSE
		SET @SQL = @SQL + 'VndPDFFilePath=NULL, ';
END
IF (@VndDBUploadPathFlag Is Not NULL)
BEGIN
	IF (@VndDBUploadPath Is Not NULL)
		SET @SQL = @SQL + 'VndDBUploadPath=''' + @VndDBUploadPath + ''', ';
	ELSE
		SET @SQL = @SQL + 'VndDBUploadPath=NULL, ';
END
IF (@VndMinImprintCountFlag Is Not NULL)
BEGIN
	IF (@VndMinImprintCount Is Not NULL)
		SET @SQL = @SQL + 'VndMinImprintCount=' + convert(varchar,@VndMinImprintCount) + ', ';
	ELSE
		SET @SQL = @SQL + 'VndMinImprintCount=NULL, ';
END
IF (@MarketingCountryFlag Is Not NULL)
BEGIN
	IF (@MarketingCountry Is Not NULL)
		SET @SQL = @SQL + 'MarketingCountry=' + convert(varchar,@MarketingCountry) + ', ';
	ELSE
		SET @SQL = @SQL + 'MarketingCountry=NULL, ';
END
IF (@VndEmailFlag Is Not NULL)
BEGIN
	IF (@VndEmail Is Not NULL)
		SET @SQL = @SQL + 'VndEmail=''' + @VndEmail + ''', ';
	ELSE
		SET @SQL = @SQL + 'VndEmail=NULL, ';
END
IF (@VndPlacedToAcceptedDeadlineFlag Is Not NULL)
BEGIN
	IF (@VndPlacedToAcceptedDeadline Is Not NULL)
		SET @SQL = @SQL + 'VndPlacedToAcceptedDeadline=' + convert(varchar,@VndPlacedToAcceptedDeadline) + ', ';
	ELSE
		SET @SQL = @SQL + 'VndPlacedToAcceptedDeadline=NULL, ';
END
IF (@VndListLeadDaysFlag Is Not NULL)
BEGIN
	IF (@VndListLeadDays Is Not NULL)
		SET @SQL = @SQL + 'VndListLeadDays=' + convert(varchar,@VndListLeadDays) + ', ';
	ELSE
		SET @SQL = @SQL + 'VndListLeadDays=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE Vendor SET ' + Left(@SQL, Len(@SQL)-1) + ' Where VndId = ' + convert(varchar,@VndId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
