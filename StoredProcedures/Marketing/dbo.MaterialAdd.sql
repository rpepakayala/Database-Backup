/****** Object:  StoredProcedure [dbo].[MaterialAdd]    Script Date: 5/15/2018 12:10:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


CREATE PROCEDURE dbo.MaterialAdd
(
	@MatId int = NULL,
	@MatName varchar(50) = NULL,
	@MatDesc varchar(255) = NULL,
	@MatVendorId int = NULL,
	@MatVendorSku varchar(50) = NULL,
	@MatStatus smallint = NULL,
	@MatDisabled char(1) = NULL,
	@MatHidden char(1) = NULL,
	@MatAvailFrom smalldatetime = NULL,
	@MatAvailThru smalldatetime = NULL,
	@MatRePrintable char(1) = NULL,
	@MatReOrderSignUpDate smalldatetime = NULL,
	@MatMinOrderQty int = NULL,
	@MatOrderInc int = NULL,
	@MatMinQtyLevel int = NULL,
	@MatMaxQtyLevel int = NULL,
	@MatDeadlineDays smallint = NULL,
	@MatImageFile varchar(50) = NULL,
	@MatImage varchar(50) = NULL,
	@MatProofImageFile varchar(50) = NULL,
	@MatProofImage varchar(50) = NULL,
	@MatPresentationStyle smallint = NULL,
	@MatMinReOrderQty int = NULL,
	@MatTotVQOH int = NULL,
	@MatTotVQtyAllocated int = NULL,
	@MatTotSMatQtyAllocated int = NULL,
	@MatTotSMailQtyAllocated int = NULL,
	@MatTotQtyOnOrder int = NULL,
	@MatAvailFromDate smalldatetime = NULL,
	@MatAvailThruDate smalldatetime = NULL,
	@MatQtyAvailEstShipDays smallint = NULL,
	@MatQtyNotAvailEstShipDays smallint = NULL,
	@MatQtyNotOrdEstShipDays smallint = NULL,
	@MatImprintShipDays smallint = NULL,
	@MatProofSetId int = NULL,
	@MatFolding char(1) = NULL,
	@MatAvailMailOnDemand char(1) = NULL,
	@MatFirstClassPostageFee float = NULL,
	@MatStndPostageFee float = NULL,
	@MatAddBRM char(1) = NULL,
	@MatImprintable char(1) = NULL
)
AS
INSERT INTO Material (MatId, MatName, MatDesc, MatVendorId, MatVendorSku, MatStatus, MatDisabled, MatHidden, MatAvailFrom, MatAvailThru, MatRePrintable, MatReOrderSignUpDate, MatMinOrderQty, MatOrderInc, MatMinQtyLevel, MatMaxQtyLevel, MatDeadlineDays, MatImageFile, MatImage, MatProofImageFile, MatProofImage, MatPresentationStyle, MatMinReOrderQty, MatTotVQOH, MatTotVQtyAllocated, MatTotSMatQtyAllocated, MatTotSMailQtyAllocated, MatTotQtyOnOrder, MatAvailFromDate, MatAvailThruDate, MatQtyAvailEstShipDays, MatQtyNotAvailEstShipDays, MatQtyNotOrdEstShipDays, MatImprintShipDays, MatProofSetId, MatFolding, MatAvailMailOnDemand, MatFirstClassPostageFee, MatStndPostageFee, MatAddBRM, MatImprintable)
 VALUES (@MatId, @MatName, @MatDesc, @MatVendorId, @MatVendorSku, @MatStatus, @MatDisabled, @MatHidden, @MatAvailFrom, @MatAvailThru, @MatRePrintable, @MatReOrderSignUpDate, @MatMinOrderQty, @MatOrderInc, @MatMinQtyLevel, @MatMaxQtyLevel, @MatDeadlineDays, @MatImageFile, @MatImage, @MatProofImageFile, @MatProofImage, @MatPresentationStyle, @MatMinReOrderQty, @MatTotVQOH, @MatTotVQtyAllocated, @MatTotSMatQtyAllocated, @MatTotSMailQtyAllocated, @MatTotQtyOnOrder, @MatAvailFromDate, @MatAvailThruDate, @MatQtyAvailEstShipDays, @MatQtyNotAvailEstShipDays, @MatQtyNotOrdEstShipDays, @MatImprintShipDays, @MatProofSetId, @MatFolding, @MatAvailMailOnDemand, @MatFirstClassPostageFee, @MatStndPostageFee, @MatAddBRM, @MatImprintable);


GO
