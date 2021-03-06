/****** Object:  StoredProcedure [dbo].[ShoppingCartAdd]    Script Date: 5/15/2018 12:10:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.ShoppingCartAdd
(
	@ScStoreId int = NULL,
	@ScId int = NULL,
	@ScType tinyint = NULL,
	@ScCatlId int = NULL,
	@ScCatId int = NULL,
	@ScOrderPrdType tinyint = NULL,
	@ScCatType tinyint = NULL,
	@ScPrdGId int = NULL,
	@ScRMPHId int = NULL,
	@ScPrdId int = NULL,
	@ScQty int = NULL,
	@ScMailDate smalldatetime = NULL,
	@ScImprint char(1) = NULL,
	@ScAdded smalldatetime = NULL,
	@ScMailOnDemandPostageType tinyint = NULL,
	@ScMailOnDemandPostageFee float = NULL
)
AS
INSERT INTO ShoppingCart (ScStoreId, ScId, ScType, ScCatlId, ScCatId, ScOrderPrdType, ScCatType, ScPrdGId, ScRMPHId, ScPrdId, ScQty, ScMailDate, ScImprint, ScAdded, ScMailOnDemandPostageType, ScMailOnDemandPostageFee)
 VALUES (@ScStoreId, @ScId, @ScType, @ScCatlId, @ScCatId, @ScOrderPrdType, @ScCatType, @ScPrdGId, @ScRMPHId, @ScPrdId, @ScQty, @ScMailDate, @ScImprint, @ScAdded, @ScMailOnDemandPostageType, @ScMailOnDemandPostageFee);


GO
