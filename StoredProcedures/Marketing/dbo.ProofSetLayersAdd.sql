/****** Object:  StoredProcedure [dbo].[ProofSetLayersAdd]    Script Date: 5/15/2018 12:10:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.ProofSetLayersAdd
(
	@PrfSId int = NULL,
	@PrfLId int = NULL,
	@PrfLType tinyint = NULL,
	@PrfLLock char(1) = NULL,
	@PrfLCoordX1 int = NULL,
	@PrfLCoordY1 int = NULL,
	@PrfLCoordX2 int = NULL,
	@PrfLCoordY2 int = NULL,
	@PrfLRotation int = NULL
)
AS
INSERT INTO ProofSetLayers (PrfSId, PrfLId, PrfLType, PrfLLock, PrfLCoordX1, PrfLCoordY1, PrfLCoordX2, PrfLCoordY2, PrfLRotation)
 VALUES (@PrfSId, @PrfLId, @PrfLType, @PrfLLock, @PrfLCoordX1, @PrfLCoordY1, @PrfLCoordX2, @PrfLCoordY2, @PrfLRotation);


GO
