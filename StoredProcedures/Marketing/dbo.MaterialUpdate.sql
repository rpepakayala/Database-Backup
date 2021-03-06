/****** Object:  StoredProcedure [dbo].[MaterialUpdate]    Script Date: 5/15/2018 12:10:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE PROCEDURE dbo.MaterialUpdate
(
	@MatId int = NULL,
	@MatName varchar(50) = NULL,
	@MatNameFlag bit = NULL,
	@MatDesc varchar(255) = NULL,
	@MatDescFlag bit = NULL,
	@MatVendorId int = NULL,
	@MatVendorIdFlag bit = NULL,
	@MatVendorSku varchar(50) = NULL,
	@MatVendorSkuFlag bit = NULL,
	@MatStatus smallint = NULL,
	@MatStatusFlag bit = NULL,
	@MatDisabled char(1) = NULL,
	@MatDisabledFlag bit = NULL,
	@MatHidden char(1) = NULL,
	@MatHiddenFlag bit = NULL,
	@MatAvailFrom smalldatetime = NULL,
	@MatAvailFromFlag bit = NULL,
	@MatAvailThru smalldatetime = NULL,
	@MatAvailThruFlag bit = NULL,
	@MatRePrintable char(1) = NULL,
	@MatRePrintableFlag bit = NULL,
	@MatReOrderSignUpDate smalldatetime = NULL,
	@MatReOrderSignUpDateFlag bit = NULL,
	@MatMinOrderQty int = NULL,
	@MatMinOrderQtyFlag bit = NULL,
	@MatOrderInc int = NULL,
	@MatOrderIncFlag bit = NULL,
	@MatMinQtyLevel int = NULL,
	@MatMinQtyLevelFlag bit = NULL,
	@MatMaxQtyLevel int = NULL,
	@MatMaxQtyLevelFlag bit = NULL,
	@MatDeadlineDays smallint = NULL,
	@MatDeadlineDaysFlag bit = NULL,
	@MatImageFile varchar(50) = NULL,
	@MatImageFileFlag bit = NULL,
	@MatImage varchar(50) = NULL,
	@MatImageFlag bit = NULL,
	@MatProofImageFile varchar(50) = NULL,
	@MatProofImageFileFlag bit = NULL,
	@MatProofImage varchar(50) = NULL,
	@MatProofImageFlag bit = NULL,
	@MatPresentationStyle smallint = NULL,
	@MatPresentationStyleFlag bit = NULL,
	@MatMinReOrderQty int = NULL,
	@MatMinReOrderQtyFlag bit = NULL,
	@MatTotVQOH int = NULL,
	@MatTotVQOHFlag bit = NULL,
	@MatTotVQtyAllocated int = NULL,
	@MatTotVQtyAllocatedFlag bit = NULL,
	@MatTotSMatQtyAllocated int = NULL,
	@MatTotSMatQtyAllocatedFlag bit = NULL,
	@MatTotSMailQtyAllocated int = NULL,
	@MatTotSMailQtyAllocatedFlag bit = NULL,
	@MatTotQtyOnOrder int = NULL,
	@MatTotQtyOnOrderFlag bit = NULL,
	@MatAvailFromDate smalldatetime = NULL,
	@MatAvailFromDateFlag bit = NULL,
	@MatAvailThruDate smalldatetime = NULL,
	@MatAvailThruDateFlag bit = NULL,
	@MatQtyAvailEstShipDays smallint = NULL,
	@MatQtyAvailEstShipDaysFlag bit = NULL,
	@MatQtyNotAvailEstShipDays smallint = NULL,
	@MatQtyNotAvailEstShipDaysFlag bit = NULL,
	@MatQtyNotOrdEstShipDays smallint = NULL,
	@MatQtyNotOrdEstShipDaysFlag bit = NULL,
	@MatImprintShipDays smallint = NULL,
	@MatImprintShipDaysFlag bit = NULL,
	@MatProofSetId int = NULL,
	@MatProofSetIdFlag bit = NULL,
	@MatFolding char(1) = NULL,
	@MatFoldingFlag bit = NULL,
	@MatAvailMailOnDemand char(1) = NULL,
	@MatAvailMailOnDemandFlag bit = NULL,
	@MatFirstClassPostageFee float = NULL,
	@MatFirstClassPostageFeeFlag bit = NULL,
	@MatStndPostageFee float = NULL,
	@MatStndPostageFeeFlag bit = NULL,
	@MatAddBRM char(1) = NULL,
	@MatAddBRMFlag bit = NULL,
	@MatImprintable char(1) = NULL,
	@MatImprintableFlag bit = NULL
)
AS

DECLARE @SQL varchar(4000);

SET @SQL = ' ';
IF (@MatNameFlag Is Not NULL)
BEGIN
	IF (@MatName Is Not NULL)
		SET @SQL = @SQL + 'MatName=''' + @MatName + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatName=NULL, ';
END

IF (@MatDescFlag Is Not NULL)
BEGIN
	IF (@MatDesc Is Not NULL)
		SET @SQL = @SQL + 'MatDesc=''' + @MatDesc + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatDesc=NULL, ';
END

IF (@MatVendorIdFlag Is Not NULL)
BEGIN
	IF (@MatVendorId Is Not NULL)
		SET @SQL = @SQL + 'MatVendorId=' + convert(varchar,@MatVendorId) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatVendorId=NULL, ';
END

IF (@MatVendorSkuFlag Is Not NULL)
BEGIN
	IF (@MatVendorSku Is Not NULL)
		SET @SQL = @SQL + 'MatVendorSku=''' + @MatVendorSku + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatVendorSku=NULL, ';
END

IF (@MatStatusFlag Is Not NULL)
BEGIN
	IF (@MatStatus Is Not NULL)
		SET @SQL = @SQL + 'MatStatus=' + convert(varchar,@MatStatus) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatStatus=NULL, ';
END

IF (@MatDisabledFlag Is Not NULL)
BEGIN
	IF (@MatDisabled Is Not NULL)
		SET @SQL = @SQL + 'MatDisabled=''' + @MatDisabled + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatDisabled=NULL, ';
END

IF (@MatHiddenFlag Is Not NULL)
BEGIN
	IF (@MatHidden Is Not NULL)
		SET @SQL = @SQL + 'MatHidden=''' + @MatHidden + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatHidden=NULL, ';
END

IF (@MatAvailFromFlag Is Not NULL)
BEGIN
	IF (@MatAvailFrom Is Not NULL)
		SET @SQL = @SQL + 'MatAvailFrom=''' + convert(varchar,@MatAvailFrom) + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatAvailFrom=NULL, ';
END

IF (@MatAvailThruFlag Is Not NULL)
BEGIN
	IF (@MatAvailThru Is Not NULL)
		SET @SQL = @SQL + 'MatAvailThru=''' + convert(varchar,@MatAvailThru) + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatAvailThru=NULL, ';
END

IF (@MatRePrintableFlag Is Not NULL)
BEGIN
	IF (@MatRePrintable Is Not NULL)
		SET @SQL = @SQL + 'MatRePrintable=''' + @MatRePrintable + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatRePrintable=NULL, ';
END

IF (@MatReOrderSignUpDateFlag Is Not NULL)
BEGIN
	IF (@MatReOrderSignUpDate Is Not NULL)
		SET @SQL = @SQL + 'MatReOrderSignUpDate=''' + convert(varchar,@MatReOrderSignUpDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatReOrderSignUpDate=NULL, ';
END

IF (@MatMinOrderQtyFlag Is Not NULL)
BEGIN
	IF (@MatMinOrderQty Is Not NULL)
		SET @SQL = @SQL + 'MatMinOrderQty=' + convert(varchar,@MatMinOrderQty) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatMinOrderQty=NULL, ';
END

IF (@MatOrderIncFlag Is Not NULL)
BEGIN
	IF (@MatOrderInc Is Not NULL)
		SET @SQL = @SQL + 'MatOrderInc=' + convert(varchar,@MatOrderInc) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatOrderInc=NULL, ';
END

IF (@MatMinQtyLevelFlag Is Not NULL)
BEGIN
	IF (@MatMinQtyLevel Is Not NULL)
		SET @SQL = @SQL + 'MatMinQtyLevel=' + convert(varchar,@MatMinQtyLevel) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatMinQtyLevel=NULL, ';
END

IF (@MatMaxQtyLevelFlag Is Not NULL)
BEGIN
	IF (@MatMaxQtyLevel Is Not NULL)
		SET @SQL = @SQL + 'MatMaxQtyLevel=' + convert(varchar,@MatMaxQtyLevel) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatMaxQtyLevel=NULL, ';
END

IF (@MatDeadlineDaysFlag Is Not NULL)
BEGIN
	IF (@MatDeadlineDays Is Not NULL)
		SET @SQL = @SQL + 'MatDeadlineDays=' + convert(varchar,@MatDeadlineDays) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatDeadlineDays=NULL, ';
END

IF (@MatImageFileFlag Is Not NULL)
BEGIN
	IF (@MatImageFile Is Not NULL)
		SET @SQL = @SQL + 'MatImageFile=''' + @MatImageFile + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatImageFile=NULL, ';
END

IF (@MatImageFlag Is Not NULL)
BEGIN
	IF (@MatImage Is Not NULL)
		SET @SQL = @SQL + 'MatImage=''' + @MatImage + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatImage=NULL, ';
END

IF (@MatProofImageFileFlag Is Not NULL)
BEGIN
	IF (@MatProofImageFile Is Not NULL)
		SET @SQL = @SQL + 'MatProofImageFile=''' + @MatProofImageFile + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatProofImageFile=NULL, ';
END

IF (@MatProofImageFlag Is Not NULL)
BEGIN
	IF (@MatProofImage Is Not NULL)
		SET @SQL = @SQL + 'MatProofImage=''' + @MatProofImage + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatProofImage=NULL, ';
END

IF (@MatPresentationStyleFlag Is Not NULL)
BEGIN
	IF (@MatPresentationStyle Is Not NULL)
		SET @SQL = @SQL + 'MatPresentationStyle=' + convert(varchar,@MatPresentationStyle) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatPresentationStyle=NULL, ';
END

IF (@MatMinReOrderQtyFlag Is Not NULL)
BEGIN
	IF (@MatMinReOrderQty Is Not NULL)
		SET @SQL = @SQL + 'MatMinReOrderQty=' + convert(varchar,@MatMinReOrderQty) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatMinReOrderQty=NULL, ';
END

IF (@MatTotVQOHFlag Is Not NULL)
BEGIN
	IF (@MatTotVQOH Is Not NULL)
		SET @SQL = @SQL + 'MatTotVQOH=' + convert(varchar,@MatTotVQOH) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatTotVQOH=NULL, ';
END

IF (@MatTotVQtyAllocatedFlag Is Not NULL)
BEGIN
	IF (@MatTotVQtyAllocated Is Not NULL)
		SET @SQL = @SQL + 'MatTotVQtyAllocated=' + convert(varchar,@MatTotVQtyAllocated) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatTotVQtyAllocated=NULL, ';
END

IF (@MatTotSMatQtyAllocatedFlag Is Not NULL)
BEGIN
	IF (@MatTotSMatQtyAllocated Is Not NULL)
		SET @SQL = @SQL + 'MatTotSMatQtyAllocated=' + convert(varchar,@MatTotSMatQtyAllocated) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatTotSMatQtyAllocated=NULL, ';
END

IF (@MatTotSMailQtyAllocatedFlag Is Not NULL)
BEGIN
	IF (@MatTotSMailQtyAllocated Is Not NULL)
		SET @SQL = @SQL + 'MatTotSMailQtyAllocated=' + convert(varchar,@MatTotSMailQtyAllocated) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatTotSMailQtyAllocated=NULL, ';
END

IF (@MatTotQtyOnOrderFlag Is Not NULL)
BEGIN
	IF (@MatTotQtyOnOrder Is Not NULL)
		SET @SQL = @SQL + 'MatTotQtyOnOrder=' + convert(varchar,@MatTotQtyOnOrder) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatTotQtyOnOrder=NULL, ';
END

IF (@MatAvailFromDateFlag Is Not NULL)
BEGIN
	IF (@MatAvailFromDate Is Not NULL)
		SET @SQL = @SQL + 'MatAvailFromDate=''' + convert(varchar,@MatAvailFromDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatAvailFromDate=NULL, ';
END

IF (@MatAvailThruDateFlag Is Not NULL)
BEGIN
	IF (@MatAvailThruDate Is Not NULL)
		SET @SQL = @SQL + 'MatAvailThruDate=''' + convert(varchar,@MatAvailThruDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatAvailThruDate=NULL, ';
END

IF (@MatQtyAvailEstShipDaysFlag Is Not NULL)
BEGIN
	IF (@MatQtyAvailEstShipDays Is Not NULL)
		SET @SQL = @SQL + 'MatQtyAvailEstShipDays=' + convert(varchar,@MatQtyAvailEstShipDays) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatQtyAvailEstShipDays=NULL, ';
END

IF (@MatQtyNotAvailEstShipDaysFlag Is Not NULL)
BEGIN
	IF (@MatQtyNotAvailEstShipDays Is Not NULL)
		SET @SQL = @SQL + 'MatQtyNotAvailEstShipDays=' + convert(varchar,@MatQtyNotAvailEstShipDays) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatQtyNotAvailEstShipDays=NULL, ';
END

IF (@MatQtyNotOrdEstShipDaysFlag Is Not NULL)
BEGIN
	IF (@MatQtyNotOrdEstShipDays Is Not NULL)
		SET @SQL = @SQL + 'MatQtyNotOrdEstShipDays=' + convert(varchar,@MatQtyNotOrdEstShipDays) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatQtyNotOrdEstShipDays=NULL, ';
END

IF (@MatImprintShipDaysFlag Is Not NULL)
BEGIN
	IF (@MatImprintShipDays Is Not NULL)
		SET @SQL = @SQL + 'MatImprintShipDays=' + convert(varchar,@MatImprintShipDays) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatImprintShipDays=NULL, ';
END

IF (@MatProofSetIdFlag Is Not NULL)
BEGIN
	IF (@MatProofSetId Is Not NULL)
		SET @SQL = @SQL + 'MatProofSetId=' + convert(varchar,@MatProofSetId) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatProofSetId=NULL, ';
END

IF (@MatFoldingFlag Is Not NULL)
BEGIN
	IF (@MatFolding Is Not NULL)
		SET @SQL = @SQL + 'MatFolding=''' + @MatFolding + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatFolding=NULL, ';
END

IF (@MatAvailMailOnDemandFlag Is Not NULL)
BEGIN
	IF (@MatAvailMailOnDemand Is Not NULL)
		SET @SQL = @SQL + 'MatAvailMailOnDemand=''' + @MatAvailMailOnDemand + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatAvailMailOnDemand=NULL, ';
END

IF (@MatFirstClassPostageFeeFlag Is Not NULL)
BEGIN
	IF (@MatFirstClassPostageFee Is Not NULL)
		SET @SQL = @SQL + 'MatFirstClassPostageFee=' + convert(varchar,@MatFirstClassPostageFee) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatFirstClassPostageFee=NULL, ';
END

IF (@MatStndPostageFeeFlag Is Not NULL)
BEGIN
	IF (@MatStndPostageFee Is Not NULL)
		SET @SQL = @SQL + 'MatStndPostageFee=' + convert(varchar,@MatStndPostageFee) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatStndPostageFee=NULL, ';
END

IF (@MatAddBRMFlag Is Not NULL)
BEGIN
	IF (@MatAddBRM Is Not NULL)
		SET @SQL = @SQL + 'MatAddBRM=''' + @MatAddBRM + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatAddBRM=NULL, ';
END

IF (@MatImprintableFlag Is Not NULL)
BEGIN
	IF (@MatImprintable Is Not NULL)
		SET @SQL = @SQL + 'MatImprintable=''' + @MatImprintable + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatImprintable=NULL, ';
END

IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE Material SET ' + Left(@SQL, Len(@SQL)-1) + ' Where MatId = ' + convert(varchar,@MatId) 
	EXEC(@SQL)
END

SET QUOTED_IDENTIFIER OFF 


GO
