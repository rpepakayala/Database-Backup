/****** Object:  StoredProcedure [dbo].[ProofSetLayersDelete]    Script Date: 5/15/2018 12:10:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.ProofSetLayersDelete
(
	@PrfLId int
)
AS
	DELETE FROM ProofSetLayers WHERE PrfLId=@PrfLId;
RETURN @@Rowcount;


GO
