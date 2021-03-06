/****** Object:  StoredProcedure [dbo].[OrderDtlMailingProfileHdrAdd]    Script Date: 5/15/2018 12:10:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OrderDtlMailingProfileHdrAdd
(
	@MalPId int = NULL,
	@OrdDMPHId int = NULL,
	@OrdHId int = NULL,
	@OrdDMPHTelemIncluded char(1) = NULL,
	@OrdDMPHUploadDBDate smalldatetime = NULL,
	@OrdDMPHPurchaseList char(1) = NULL,
	@OrdDMPHPurchaseListFee float = NULL,
	@OrdDMPHPurchaseListFeeQty int = NULL,
	@OrdDMPHPurchaseListAmt float = NULL,
	@OrdDMPHOveragePrc float = NULL,
	@OrdDMPHProvideDB char(1) = NULL,
	@OrdDMPHProvideDBFee float = NULL,
	@OrdDMPHProvideDBFeeQty int = NULL,
	@OrdDMPHProvideDBAmt float = NULL,
	@OrdDMPHDBName varchar(50) = NULL,
	@OrdDMPHDBQty int = NULL,
	@OrdDMPHListMatrix varchar(50) = NULL,
	@OrdDMPHListRequestQty int = NULL,
	@OrdDMPHListStatus tinyint = NULL,
	@OrdDMPHApproved smalldatetime = NULL
)
AS
INSERT INTO OrderDtlMailingProfileHdr (MalPId, OrdDMPHId, OrdHId, OrdDMPHTelemIncluded, OrdDMPHUploadDBDate, OrdDMPHPurchaseList, OrdDMPHPurchaseListFee, OrdDMPHPurchaseListFeeQty, OrdDMPHPurchaseListAmt, OrdDMPHOveragePrc, OrdDMPHProvideDB, OrdDMPHProvideDBFee, OrdDMPHProvideDBFeeQty, OrdDMPHProvideDBAmt, OrdDMPHDBName, OrdDMPHDBQty, OrdDMPHListMatrix, OrdDMPHListRequestQty, OrdDMPHListStatus, OrdDMPHApproved)
 VALUES (@MalPId, @OrdDMPHId, @OrdHId, @OrdDMPHTelemIncluded, @OrdDMPHUploadDBDate, @OrdDMPHPurchaseList, @OrdDMPHPurchaseListFee, @OrdDMPHPurchaseListFeeQty, @OrdDMPHPurchaseListAmt, @OrdDMPHOveragePrc, @OrdDMPHProvideDB, @OrdDMPHProvideDBFee, @OrdDMPHProvideDBFeeQty, @OrdDMPHProvideDBAmt, @OrdDMPHDBName, @OrdDMPHDBQty, @OrdDMPHListMatrix, @OrdDMPHListRequestQty, @OrdDMPHListStatus, @OrdDMPHApproved);


GO
