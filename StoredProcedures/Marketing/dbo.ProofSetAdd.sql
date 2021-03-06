/****** Object:  StoredProcedure [dbo].[ProofSetAdd]    Script Date: 5/15/2018 12:10:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.ProofSetAdd
(
	@PrfSId int = NULL,
	@PrfSName varchar(50) = NULL,
	@PrfSFirstClassPostage float = NULL,
	@PrfSMailingHandOut char(1) = NULL,
	@PrfSFolding char(1) = NULL,
	@PrfSHandOut char(1) = NULL,
	@PrfSMultiStore char(1) = NULL,
	@PrfSMap char(1) = NULL,
	@PrfSImprintFee float = NULL,
	@PrfSImprintQty smallint = NULL,
	@PrfSWidth int = NULL,
	@PrfSHeight int = NULL
)
AS
INSERT INTO ProofSet (PrfSId, PrfSName, PrfSFirstClassPostage, PrfSMailingHandOut, PrfSFolding, PrfSHandOut, PrfSMultiStore, PrfSMap, PrfSImprintFee, PrfSImprintQty, PrfSWidth, PrfSHeight)
 VALUES (@PrfSId, @PrfSName, @PrfSFirstClassPostage, @PrfSMailingHandOut, @PrfSFolding, @PrfSHandOut, @PrfSMultiStore, @PrfSMap, @PrfSImprintFee, @PrfSImprintQty, @PrfSWidth, @PrfSHeight);


GO
