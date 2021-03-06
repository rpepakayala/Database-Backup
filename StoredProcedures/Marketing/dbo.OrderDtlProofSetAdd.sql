/****** Object:  StoredProcedure [dbo].[OrderDtlProofSetAdd]    Script Date: 5/15/2018 12:10:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OrderDtlProofSetAdd
(
	@PrfSId int = NULL,
	@OrdHId int = NULL,
	@OrdPSId int = NULL,
	@OrdPSName varchar(50) = NULL,
	@OrdPSHandOutOption char(1) = NULL,
	@OrdPSFoldingOption char(1) = NULL,
	@OrdPSFoldingFee float = NULL,
	@OrdPSFoldingQty int = NULL,
	@OrdPSImprintFee float = NULL,
	@OrdPSImprintQty int = NULL,
	@OrdPSImageName varchar(50) = NULL,
	@OrdPSPDFName varchar(50) = NULL,
	@OrdPSApprovedDate datetime = NULL,
	@OrdPSChangeRequest bit = NULL
)
AS
INSERT INTO OrderDtlProofSet (PrfSId, OrdHId, OrdPSId, OrdPSName, OrdPSHandOutOption, OrdPSFoldingOption, OrdPSFoldingFee, OrdPSFoldingQty, OrdPSImprintFee, OrdPSImprintQty, OrdPSImageName, OrdPSPDFName, OrdPSApprovedDate, OrdPSChangeRequest)
 VALUES (@PrfSId, @OrdHId, @OrdPSId, @OrdPSName, @OrdPSHandOutOption, @OrdPSFoldingOption, @OrdPSFoldingFee, @OrdPSFoldingQty, @OrdPSImprintFee, @OrdPSImprintQty, @OrdPSImageName, @OrdPSPDFName, @OrdPSApprovedDate, @OrdPSChangeRequest);


GO
