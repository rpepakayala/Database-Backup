/****** Object:  StoredProcedure [dbo].[OrderPaymentUpdate]    Script Date: 5/15/2018 12:10:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OrderPaymentUpdate
(
	@OrdHId int = NULL,
	@OrdPmId int = NULL,
	@OrdPmType tinyint = NULL,
	@OrdPmTypeFlag bit = NULL,
	@OrdPmDate smalldatetime = NULL,
	@OrdPmDateFlag bit = NULL,
	@OrdPmChkNumber int = NULL,
	@OrdPmChkNumberFlag bit = NULL,
	@OrdPmCCFSName varchar(50) = NULL,
	@OrdPmCCFSNameFlag bit = NULL,
	@OrdPmCCType varchar(50) = NULL,
	@OrdPmCCTypeFlag bit = NULL,
	@OrdPmCCNumber varchar(50) = NULL,
	@OrdPmCCNumberFlag bit = NULL,
	@OrdPmCCExpDate varchar(6) = NULL,
	@OrdPmCCExpDateFlag bit = NULL,
	@OrdPmName varchar(255) = NULL,
	@OrdPmNameFlag bit = NULL,
	@OrdPmAmount float = NULL,
	@OrdPmAmountFlag bit = NULL,
	@OrdPmBillAddr1 varchar(255) = NULL,
	@OrdPmBillAddr1Flag bit = NULL,
	@OrdPmBillAddr2 varchar(255) = NULL,
	@OrdPmBillAddr2Flag bit = NULL,
	@OrdPmBillCity varchar(50) = NULL,
	@OrdPmBillCityFlag bit = NULL,
	@OrdPmBillState varchar(50) = NULL,
	@OrdPmBillStateFlag bit = NULL,
	@OrdPmBillPostalCode varchar(50) = NULL,
	@OrdPmBillPostalCodeFlag bit = NULL,
	@OrdPmBillCountry varchar(50) = NULL,
	@OrdPmBillCountryFlag bit = NULL,
	@OrdPmBatchNo char(10) = NULL,
	@OrdPmBatchNoFlag bit = NULL,
	@OrdPmBatchNum int = NULL,
	@OrdPmBatchNumFlag bit = NULL,
	@OrdPmAuthCode varchar(50) = NULL,
	@OrdPmAuthCodeFlag bit = NULL,
	@OrdPmAuthReason varchar(255) = NULL,
	@OrdPmAuthReasonFlag bit = NULL,
	@OrdPmCCStatus tinyint = NULL,
	@OrdPmCCStatusFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@OrdPmTypeFlag Is Not NULL)
BEGIN
	IF (@OrdPmType Is Not NULL)
		SET @SQL = @SQL + 'OrdPmType=' + convert(varchar,@OrdPmType) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmType=NULL, ';
END
IF (@OrdPmDateFlag Is Not NULL)
BEGIN
	IF (@OrdPmDate Is Not NULL)
		SET @SQL = @SQL + 'OrdPmDate=''' + convert(varchar,@OrdPmDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmDate=NULL, ';
END
IF (@OrdPmChkNumberFlag Is Not NULL)
BEGIN
	IF (@OrdPmChkNumber Is Not NULL)
		SET @SQL = @SQL + 'OrdPmChkNumber=' + convert(varchar,@OrdPmChkNumber) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmChkNumber=NULL, ';
END
IF (@OrdPmCCFSNameFlag Is Not NULL)
BEGIN
	IF (@OrdPmCCFSName Is Not NULL)
		SET @SQL = @SQL + 'OrdPmCCFSName=''' + @OrdPmCCFSName + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmCCFSName=NULL, ';
END
IF (@OrdPmCCTypeFlag Is Not NULL)
BEGIN
	IF (@OrdPmCCType Is Not NULL)
		SET @SQL = @SQL + 'OrdPmCCType=''' + @OrdPmCCType + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmCCType=NULL, ';
END
IF (@OrdPmCCNumberFlag Is Not NULL)
BEGIN
	IF (@OrdPmCCNumber Is Not NULL)
		SET @SQL = @SQL + 'OrdPmCCNumber=''' + @OrdPmCCNumber + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmCCNumber=NULL, ';
END
IF (@OrdPmCCExpDateFlag Is Not NULL)
BEGIN
	IF (@OrdPmCCExpDate Is Not NULL)
		SET @SQL = @SQL + 'OrdPmCCExpDate=''' + @OrdPmCCExpDate + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmCCExpDate=NULL, ';
END
IF (@OrdPmNameFlag Is Not NULL)
BEGIN
	IF (@OrdPmName Is Not NULL)
		SET @SQL = @SQL + 'OrdPmName=''' + @OrdPmName + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmName=NULL, ';
END
IF (@OrdPmAmountFlag Is Not NULL)
BEGIN
	IF (@OrdPmAmount Is Not NULL)
		SET @SQL = @SQL + 'OrdPmAmount=' + convert(varchar,@OrdPmAmount) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmAmount=NULL, ';
END
IF (@OrdPmBillAddr1Flag Is Not NULL)
BEGIN
	IF (@OrdPmBillAddr1 Is Not NULL)
		SET @SQL = @SQL + 'OrdPmBillAddr1=''' + @OrdPmBillAddr1 + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmBillAddr1=NULL, ';
END
IF (@OrdPmBillAddr2Flag Is Not NULL)
BEGIN
	IF (@OrdPmBillAddr2 Is Not NULL)
		SET @SQL = @SQL + 'OrdPmBillAddr2=''' + @OrdPmBillAddr2 + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmBillAddr2=NULL, ';
END
IF (@OrdPmBillCityFlag Is Not NULL)
BEGIN
	IF (@OrdPmBillCity Is Not NULL)
		SET @SQL = @SQL + 'OrdPmBillCity=''' + @OrdPmBillCity + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmBillCity=NULL, ';
END
IF (@OrdPmBillStateFlag Is Not NULL)
BEGIN
	IF (@OrdPmBillState Is Not NULL)
		SET @SQL = @SQL + 'OrdPmBillState=''' + @OrdPmBillState + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmBillState=NULL, ';
END
IF (@OrdPmBillPostalCodeFlag Is Not NULL)
BEGIN
	IF (@OrdPmBillPostalCode Is Not NULL)
		SET @SQL = @SQL + 'OrdPmBillPostalCode=''' + @OrdPmBillPostalCode + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmBillPostalCode=NULL, ';
END
IF (@OrdPmBillCountryFlag Is Not NULL)
BEGIN
	IF (@OrdPmBillCountry Is Not NULL)
		SET @SQL = @SQL + 'OrdPmBillCountry=''' + @OrdPmBillCountry + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmBillCountry=NULL, ';
END
IF (@OrdPmBatchNoFlag Is Not NULL)
BEGIN
	IF (@OrdPmBatchNo Is Not NULL)
		SET @SQL = @SQL + 'OrdPmBatchNo=''' + @OrdPmBatchNo + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmBatchNo=NULL, ';
END
IF (@OrdPmBatchNumFlag Is Not NULL)
BEGIN
	IF (@OrdPmBatchNum Is Not NULL)
		SET @SQL = @SQL + 'OrdPmBatchNum=' + convert(varchar,@OrdPmBatchNum) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmBatchNum=NULL, ';
END
IF (@OrdPmAuthCodeFlag Is Not NULL)
BEGIN
	IF (@OrdPmAuthCode Is Not NULL)
		SET @SQL = @SQL + 'OrdPmAuthCode=''' + @OrdPmAuthCode + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmAuthCode=NULL, ';
END
IF (@OrdPmAuthReasonFlag Is Not NULL)
BEGIN
	IF (@OrdPmAuthReason Is Not NULL)
		SET @SQL = @SQL + 'OrdPmAuthReason=''' + @OrdPmAuthReason + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmAuthReason=NULL, ';
END
IF (@OrdPmCCStatusFlag Is Not NULL)
BEGIN
	IF (@OrdPmCCStatus Is Not NULL)
		SET @SQL = @SQL + 'OrdPmCCStatus=' + convert(varchar,@OrdPmCCStatus) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdPmCCStatus=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE OrderPayment SET ' + Left(@SQL, Len(@SQL)-1) + ' Where OrdHId = ' + convert(varchar,@OrdHId) + ' AND OrdPmId = ' + convert(varchar,@OrdPmId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
