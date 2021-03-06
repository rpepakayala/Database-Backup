/****** Object:  StoredProcedure [dbo].[OrderDtlUpdate]    Script Date: 5/15/2018 12:10:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OrderDtlUpdate
(
	@OrdHId int = NULL,
	@OrdDId int = NULL,
	@OrdDPrdId int = NULL,
	@OrdDPrdIdFlag bit = NULL,
	@OrdDPrdCatType tinyint = NULL,
	@OrdDPrdCatTypeFlag bit = NULL,
	@OrdDPrdGId int = NULL,
	@OrdDPrdGIdFlag bit = NULL,
	@OrdDPrdGDMailDate smalldatetime = NULL,
	@OrdDPrdGDMailDateFlag bit = NULL,
	@OrdDActShipDate smalldatetime = NULL,
	@OrdDActShipDateFlag bit = NULL,
	@OrdDSignUpDeadline smalldatetime = NULL,
	@OrdDSignUpDeadlineFlag bit = NULL,
	@OrdDShipTracking varchar(50) = NULL,
	@OrdDShipTrackingFlag bit = NULL,
	@OrdDRMPHId int = NULL,
	@OrdDRMPHIdFlag bit = NULL,
	@OrdDCatlId int = NULL,
	@OrdDCatlIdFlag bit = NULL,
	@OrdDtlCatId int = NULL,
	@OrdDtlCatIdFlag bit = NULL,
	@OrdDQty int = NULL,
	@OrdDQtyFlag bit = NULL,
	@OrdDPrice float = NULL,
	@OrdDPriceFlag bit = NULL,
	@OrdDOnSale char(1) = NULL,
	@OrdDOnSaleFlag bit = NULL,
	@OrdDFoldingSelection char(1) = NULL,
	@OrdDFoldingSelectionFlag bit = NULL,
	@OrdDImprintSelection char(1) = NULL,
	@OrdDImprintSelectionFlag bit = NULL,
	@OrdDHandOutSelection char(1) = NULL,
	@OrdDHandOutSelectionFlag bit = NULL,
	@OrdDMailOnDemandPostageType tinyint = NULL,
	@OrdDMailOnDemandPostageTypeFlag bit = NULL,
	@OrdDMailOnDemandPostageFee float = NULL,
	@OrdDMailOnDemandPostageFeeFlag bit = NULL,
	@OrdDMailOnDemandPostageAmount float = NULL,
	@OrdDMailOnDemandPostageAmountFlag bit = NULL,
	@OrdDListPurchaseAmount float = NULL,
	@OrdDListPurchaseAmountFlag bit = NULL,
	@OrdDPSId int = NULL,
	@OrdDPSIdFlag bit = NULL,
	@OrdDPSQtyApproved bit = NULL,
	@OrdDPSQtyApprovedFlag bit = NULL,
	@OrdDMPHId int = NULL,
	@OrdDMPHIdFlag bit = NULL,
	@OrdDAmount float = NULL,
	@OrdDAmountFlag bit = NULL,
	@OrdDVendorInvoice varchar(255) = NULL,
	@OrdDVendorInvoiceFlag bit = NULL,
	@OrdDSubsidyReimbursementSent smalldatetime = NULL,
	@OrdDSubsidyReimbursementSentFlag bit = NULL,
	@OrdDSubsidyReimbursementApproved smalldatetime = NULL,
	@OrdDSubsidyReimbursementApprovedFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@OrdDPrdIdFlag Is Not NULL)
BEGIN
	IF (@OrdDPrdId Is Not NULL)
		SET @SQL = @SQL + 'OrdDPrdId=' + convert(varchar,@OrdDPrdId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDPrdId=NULL, ';
END
IF (@OrdDPrdCatTypeFlag Is Not NULL)
BEGIN
	IF (@OrdDPrdCatType Is Not NULL)
		SET @SQL = @SQL + 'OrdDPrdCatType=' + convert(varchar,@OrdDPrdCatType) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDPrdCatType=NULL, ';
END
IF (@OrdDPrdGIdFlag Is Not NULL)
BEGIN
	IF (@OrdDPrdGId Is Not NULL)
		SET @SQL = @SQL + 'OrdDPrdGId=' + convert(varchar,@OrdDPrdGId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDPrdGId=NULL, ';
END
IF (@OrdDPrdGDMailDateFlag Is Not NULL)
BEGIN
	IF (@OrdDPrdGDMailDate Is Not NULL)
		SET @SQL = @SQL + 'OrdDPrdGDMailDate=''' + convert(varchar,@OrdDPrdGDMailDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDPrdGDMailDate=NULL, ';
END
IF (@OrdDActShipDateFlag Is Not NULL)
BEGIN
	IF (@OrdDActShipDate Is Not NULL)
		SET @SQL = @SQL + 'OrdDActShipDate=''' + convert(varchar,@OrdDActShipDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDActShipDate=NULL, ';
END
IF (@OrdDSignUpDeadlineFlag Is Not NULL)
BEGIN
	IF (@OrdDSignUpDeadline Is Not NULL)
		SET @SQL = @SQL + 'OrdDSignUpDeadline=''' + convert(varchar,@OrdDSignUpDeadline) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDSignUpDeadline=NULL, ';
END
IF (@OrdDShipTrackingFlag Is Not NULL)
BEGIN
	IF (@OrdDShipTracking Is Not NULL)
		SET @SQL = @SQL + 'OrdDShipTracking=''' + @OrdDShipTracking + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDShipTracking=NULL, ';
END
IF (@OrdDRMPHIdFlag Is Not NULL)
BEGIN
	IF (@OrdDRMPHId Is Not NULL)
		SET @SQL = @SQL + 'OrdDRMPHId=' + convert(varchar,@OrdDRMPHId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDRMPHId=NULL, ';
END
IF (@OrdDCatlIdFlag Is Not NULL)
BEGIN
	IF (@OrdDCatlId Is Not NULL)
		SET @SQL = @SQL + 'OrdDCatlId=' + convert(varchar,@OrdDCatlId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDCatlId=NULL, ';
END
IF (@OrdDtlCatIdFlag Is Not NULL)
BEGIN
	IF (@OrdDtlCatId Is Not NULL)
		SET @SQL = @SQL + 'OrdDtlCatId=' + convert(varchar,@OrdDtlCatId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDtlCatId=NULL, ';
END
IF (@OrdDQtyFlag Is Not NULL)
BEGIN
	IF (@OrdDQty Is Not NULL)
		SET @SQL = @SQL + 'OrdDQty=' + convert(varchar,@OrdDQty) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDQty=NULL, ';
END
IF (@OrdDPriceFlag Is Not NULL)
BEGIN
	IF (@OrdDPrice Is Not NULL)
		SET @SQL = @SQL + 'OrdDPrice=' + convert(varchar,@OrdDPrice) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDPrice=NULL, ';
END
IF (@OrdDOnSaleFlag Is Not NULL)
BEGIN
	IF (@OrdDOnSale Is Not NULL)
		SET @SQL = @SQL + 'OrdDOnSale=''' + @OrdDOnSale + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDOnSale=NULL, ';
END
IF (@OrdDFoldingSelectionFlag Is Not NULL)
BEGIN
	IF (@OrdDFoldingSelection Is Not NULL)
		SET @SQL = @SQL + 'OrdDFoldingSelection=''' + @OrdDFoldingSelection + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDFoldingSelection=NULL, ';
END
IF (@OrdDImprintSelectionFlag Is Not NULL)
BEGIN
	IF (@OrdDImprintSelection Is Not NULL)
		SET @SQL = @SQL + 'OrdDImprintSelection=''' + @OrdDImprintSelection + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDImprintSelection=NULL, ';
END
IF (@OrdDHandOutSelectionFlag Is Not NULL)
BEGIN
	IF (@OrdDHandOutSelection Is Not NULL)
		SET @SQL = @SQL + 'OrdDHandOutSelection=''' + @OrdDHandOutSelection + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDHandOutSelection=NULL, ';
END
IF (@OrdDMailOnDemandPostageTypeFlag Is Not NULL)
BEGIN
	IF (@OrdDMailOnDemandPostageType Is Not NULL)
		SET @SQL = @SQL + 'OrdDMailOnDemandPostageType=' + convert(varchar,@OrdDMailOnDemandPostageType) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMailOnDemandPostageType=NULL, ';
END
IF (@OrdDMailOnDemandPostageFeeFlag Is Not NULL)
BEGIN
	IF (@OrdDMailOnDemandPostageFee Is Not NULL)
		SET @SQL = @SQL + 'OrdDMailOnDemandPostageFee=' + convert(varchar,@OrdDMailOnDemandPostageFee) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMailOnDemandPostageFee=NULL, ';
END
IF (@OrdDMailOnDemandPostageAmountFlag Is Not NULL)
BEGIN
	IF (@OrdDMailOnDemandPostageAmount Is Not NULL)
		SET @SQL = @SQL + 'OrdDMailOnDemandPostageAmount=' + convert(varchar,@OrdDMailOnDemandPostageAmount) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMailOnDemandPostageAmount=NULL, ';
END
IF (@OrdDListPurchaseAmountFlag Is Not NULL)
BEGIN
	IF (@OrdDListPurchaseAmount Is Not NULL)
		SET @SQL = @SQL + 'OrdDListPurchaseAmount=' + convert(varchar,@OrdDListPurchaseAmount) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDListPurchaseAmount=NULL, ';
END
IF (@OrdDPSIdFlag Is Not NULL)
BEGIN
	IF (@OrdDPSId Is Not NULL)
		SET @SQL = @SQL + 'OrdDPSId=' + convert(varchar,@OrdDPSId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDPSId=NULL, ';
END
IF (@OrdDPSQtyApprovedFlag Is Not NULL)
BEGIN
	IF (@OrdDPSQtyApproved Is Not NULL)
		SET @SQL = @SQL + 'OrdDPSQtyApproved=' + convert(varchar,@OrdDPSQtyApproved) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDPSQtyApproved=NULL, ';
END
IF (@OrdDMPHIdFlag Is Not NULL)
BEGIN
	IF (@OrdDMPHId Is Not NULL)
		SET @SQL = @SQL + 'OrdDMPHId=' + convert(varchar,@OrdDMPHId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDMPHId=NULL, ';
END
IF (@OrdDAmountFlag Is Not NULL)
BEGIN
	IF (@OrdDAmount Is Not NULL)
		SET @SQL = @SQL + 'OrdDAmount=' + convert(varchar,@OrdDAmount) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdDAmount=NULL, ';
END
IF (@OrdDVendorInvoiceFlag Is Not NULL)
BEGIN
	IF (@OrdDVendorInvoice Is Not NULL)
		SET @SQL = @SQL + 'OrdDVendorInvoice=''' + @OrdDVendorInvoice + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDVendorInvoice=NULL, ';
END
IF (@OrdDSubsidyReimbursementSentFlag Is Not NULL)
BEGIN
	IF (@OrdDSubsidyReimbursementSent Is Not NULL)
		SET @SQL = @SQL + 'OrdDSubsidyReimbursementSent=''' + convert(varchar,@OrdDSubsidyReimbursementSent) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDSubsidyReimbursementSent=NULL, ';
END
IF (@OrdDSubsidyReimbursementApprovedFlag Is Not NULL)
BEGIN
	IF (@OrdDSubsidyReimbursementApproved Is Not NULL)
		SET @SQL = @SQL + 'OrdDSubsidyReimbursementApproved=''' + convert(varchar,@OrdDSubsidyReimbursementApproved) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdDSubsidyReimbursementApproved=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE OrderDtl SET ' + Left(@SQL, Len(@SQL)-1) + ' Where OrdHId = ' + convert(varchar,@OrdHId) + ' AND OrdDId = ' + convert(varchar,@OrdDId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
