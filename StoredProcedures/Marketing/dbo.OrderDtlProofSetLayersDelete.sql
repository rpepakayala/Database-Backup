/****** Object:  StoredProcedure [dbo].[OrderDtlProofSetLayersDelete]    Script Date: 5/15/2018 12:10:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OrderDtlProofSetLayersDelete
(
	@OrdPSId int,
	@OrdPSLId int
)
AS
	DELETE FROM OrderDtlProofSetLayers WHERE OrdPSId=@OrdPSId AND OrdPSLId=@OrdPSLId;
RETURN @@Rowcount;


GO
