/****** Object:  StoredProcedure [dbo].[OrderDtlMailingProfileHdrUpdate]    Script Date: 5/15/2018 12:10:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OrderDtlMailingProfileHdrUpdate
(
	@MalPId int = NULL,
	@MalPIdFlag bit = NULL,
	@OrdDMPHId int = NULL,
	@OrdHId int = NULL,
	@OrdHIdFlag bit = NULL,
	@OrdDMPHTelemIncluded char(1) = NULL,
	@OrdDMPHTelemIncludedFlag bit = NULL,
	@OrdDMPHUploadDBDate smalldatetime = NULL,
	@OrdDMPHUploadDBDateFlag bit = NULL,
	@OrdDMPHPurchaseList char(1) = NULL,
	@OrdDMPHPurchaseListFlag bit = NULL,
	@OrdDMPHPurchaseListFee float = NULL,
	@OrdDMPHPurchaseListFeeFlag bit = NULL,
	@OrdDMPHPurchaseListFeeQty int = NULL,
	@OrdDMPHPurchaseListFeeQtyFlag bit = NULL,
	@OrdDMPHPurchaseListAmt float = NULL,
	@OrdDMPHPurchaseListAmtFlag bit = NULL,
	@OrdDMPHOveragePrc float = NULL,
	@OrdDMPHOveragePrcFlag bit = NULL,
	@OrdDMPHProvideDB char(1) = NULL,
	@OrdDMPHProvideDBFlag bit = NULL,
	@OrdDMPHProvideDBFee float = NULL,
	@OrdDMPHProvideDBFeeFlag bit = NULL,
	@OrdDMPHProvideDBFeeQty int = NULL,
	@OrdDMPHProvideDBFeeQtyFlag bit = NULL,
	@OrdDMPHProvideDBAmt float = NULL,
	@OrdDMPHProvideDBAmtFlag bit = NULL,
	@OrdDMPHDBName varchar(50) = NULL,
	@OrdDMPHDBNameFlag bit = NULL,
	@OrdDMPHDBQty int = NULL,
	@OrdDMPHDBQtyFlag bit = NULL,
	@OrdDMPHListMatrix varchar(50) = NULL,
	@OrdDMPHListMatrixFlag bit = NULL,
	@OrdDMPHListRequestQty int = NULL,
	@OrdDMPHListRequestQtyFlag bit = NULL,
	@OrdDMPHListStatus tinyint = NULL,
	@OrdDMPHListStatusFlag bit = NULL,
	@OrdDMPHApproved smalldatetime = NULL,
	@OrdDMPHApprovedFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@MalPIdFlag Is Not NULL)
BEGIN
	IF (@MalPId Is Not NULL)
		SET @SQL = @SQL + 'MalPId=' + convert(varchar,@MalPId) + ', ';
	ELSE
		SET @SQL = @SQL + 'MalPId=NULL, ';
END
IF (@OrdHIdFlag Is Not NULL)
BEGIN
	IF (@OrdHId Is Not NULL)
		SET @SQL = @SQL + 'OrdHId=' + convert(varchar,@OrdHId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHId=NULL, ';
END
IF (@OrdDMPHTelemIncludedFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHTelemIncluded Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHTelemIncluded=''' + @OrdDMPHTelemIncluded + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHTelemIncluded=NULL, ';
END
IF (@OrdDMPHUploadDBDateFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHUploadDBDate Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHUploadDBDate=''' + convert(varchar,@OrdDMPHUploadDBDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHUploadDBDate=NULL, ';
END
IF (@OrdDMPHPurchaseListFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHPurchaseList Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHPurchaseList=''' + @OrdDMPHPurchaseList + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHPurchaseList=NULL, ';
END
IF (@OrdDMPHPurchaseListFeeFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHPurchaseListFee Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHPurchaseListFee=' + convert(varchar,@OrdDMPHPurchaseListFee) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHPurchaseListFee=NULL, ';
END
IF (@OrdDMPHPurchaseListFeeQtyFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHPurchaseListFeeQty Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHPurchaseListFeeQty=' + convert(varchar,@OrdDMPHPurchaseListFeeQty) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHPurchaseListFeeQty=NULL, ';
END
IF (@OrdDMPHPurchaseListAmtFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHPurchaseListAmt Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHPurchaseListAmt=' + convert(varchar,@OrdDMPHPurchaseListAmt) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHPurchaseListAmt=NULL, ';
END
IF (@OrdDMPHOveragePrcFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHOveragePrc Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHOveragePrc=' + convert(varchar,@OrdDMPHOveragePrc) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHOveragePrc=NULL, ';
END
IF (@OrdDMPHProvideDBFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHProvideDB Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHProvideDB=''' + @OrdDMPHProvideDB + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHProvideDB=NULL, ';
END
IF (@OrdDMPHProvideDBFeeFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHProvideDBFee Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHProvideDBFee=' + convert(varchar,@OrdDMPHProvideDBFee) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHProvideDBFee=NULL, ';
END
IF (@OrdDMPHProvideDBFeeQtyFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHProvideDBFeeQty Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHProvideDBFeeQty=' + convert(varchar,@OrdDMPHProvideDBFeeQty) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHProvideDBFeeQty=NULL, ';
END
IF (@OrdDMPHProvideDBAmtFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHProvideDBAmt Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHProvideDBAmt=' + convert(varchar,@OrdDMPHProvideDBAmt) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHProvideDBAmt=NULL, ';
END
IF (@OrdDMPHDBNameFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHDBName Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHDBName=''' + @OrdDMPHDBName + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHDBName=NULL, ';
END
IF (@OrdDMPHDBQtyFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHDBQty Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHDBQty=' + convert(varchar,@OrdDMPHDBQty) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHDBQty=NULL, ';
END
IF (@OrdDMPHListMatrixFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHListMatrix Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHListMatrix=''' + @OrdDMPHListMatrix + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHListMatrix=NULL, ';
END
IF (@OrdDMPHListRequestQtyFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHListRequestQty Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHListRequestQty=' + convert(varchar,@OrdDMPHListRequestQty) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHListRequestQty=NULL, ';
END
IF (@OrdDMPHListStatusFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHListStatus Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHListStatus=' + convert(varchar,@OrdDMPHListStatus) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHListStatus=NULL, ';
END
IF (@OrdDMPHApprovedFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHApproved Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHApproved=''' + convert(varchar,@OrdDMPHApproved) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHApproved=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE OrderDtlMailingProfileHdr SET ' + Left(@SQL, Len(@SQL)-1) + ' Where OrdDMPHId = ' + convert(varchar,@OrdDMPHId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
