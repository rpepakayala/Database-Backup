/****** Object:  StoredProcedure [dbo].[PossibleDtlProofSetView]    Script Date: 5/15/2018 12:10:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.PossibleDtlProofSetView
(
	@OrdDId int,
	@OrdHId int
)
AS
SELECT OrdPSId, OrdPSName
FROM OrderDtlProofSet
WHERE (PrfSId =
(SELECT Material.MatProofSetId
FROM OrderDtl INNER JOIN
Material ON OrderDtl.OrdDPrdId = Material.MatId
WHERE OrderDtl.OrdDId = @OrdDId) AND (OrdHId = @OrdHId)) AND (OrdHId = @OrdHId)


GO
