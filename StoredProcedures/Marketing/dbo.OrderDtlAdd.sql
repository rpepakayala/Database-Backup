/****** Object:  StoredProcedure [dbo].[OrderDtlAdd]    Script Date: 5/15/2018 12:10:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OrderDtlAdd
(
	@OrdHId int = NULL,
	@OrdDId int = NULL,
	@OrdDPrdId int = NULL,
	@OrdDPrdCatType tinyint = NULL,
	@OrdDPrdGId int = NULL,
	@OrdDPrdGDMailDate smalldatetime = NULL,
	@OrdDActShipDate smalldatetime = NULL,
	@OrdDSignUpDeadline smalldatetime = NULL,
	@OrdDShipTracking varchar(50) = NULL,
	@OrdDRMPHId int = NULL,
	@OrdDCatlId int = NULL,
	@OrdDtlCatId int = NULL,
	@OrdDQty int = NULL,
	@OrdDPrice float = NULL,
	@OrdDOnSale char(1) = NULL,
	@OrdDFoldingSelection char(1) = NULL,
	@OrdDImprintSelection char(1) = NULL,
	@OrdDHandOutSelection char(1) = NULL,
	@OrdDMailOnDemandPostageType tinyint = NULL,
	@OrdDMailOnDemandPostageFee float = NULL,
	@OrdDMailOnDemandPostageAmount float = NULL,
	@OrdDListPurchaseAmount float = NULL,
	@OrdDPSId int = NULL,
	@OrdDPSQtyApproved bit = NULL,
	@OrdDMPHId int = NULL,
	@OrdDAmount float = NULL,
	@OrdDVendorInvoice varchar(255) = NULL,
	@OrdDSubsidyReimbursementSent smalldatetime = NULL,
	@OrdDSubsidyReimbursementApproved smalldatetime = NULL
)
AS
INSERT INTO OrderDtl (OrdHId, OrdDId, OrdDPrdId, OrdDPrdCatType, OrdDPrdGId, OrdDPrdGDMailDate, OrdDActShipDate, OrdDSignUpDeadline, OrdDShipTracking, OrdDRMPHId, OrdDCatlId, OrdDtlCatId, OrdDQty, OrdDPrice, OrdDOnSale, OrdDFoldingSelection, OrdDImprintSelection, OrdDHandOutSelection, OrdDMailOnDemandPostageType, OrdDMailOnDemandPostageFee, OrdDMailOnDemandPostageAmount, OrdDListPurchaseAmount, OrdDPSId, OrdDPSQtyApproved, OrdDMPHId, OrdDAmount, OrdDVendorInvoice, OrdDSubsidyReimbursementSent, OrdDSubsidyReimbursementApproved)
 VALUES (@OrdHId, @OrdDId, @OrdDPrdId, @OrdDPrdCatType, @OrdDPrdGId, @OrdDPrdGDMailDate, @OrdDActShipDate, @OrdDSignUpDeadline, @OrdDShipTracking, @OrdDRMPHId, @OrdDCatlId, @OrdDtlCatId, @OrdDQty, @OrdDPrice, @OrdDOnSale, @OrdDFoldingSelection, @OrdDImprintSelection, @OrdDHandOutSelection, @OrdDMailOnDemandPostageType, @OrdDMailOnDemandPostageFee, @OrdDMailOnDemandPostageAmount, @OrdDListPurchaseAmount, @OrdDPSId, @OrdDPSQtyApproved, @OrdDMPHId, @OrdDAmount, @OrdDVendorInvoice, @OrdDSubsidyReimbursementSent, @OrdDSubsidyReimbursementApproved);


GO
