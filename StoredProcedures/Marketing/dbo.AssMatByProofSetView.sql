/****** Object:  StoredProcedure [dbo].[AssMatByProofSetView]    Script Date: 5/15/2018 12:10:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.AssMatByProofSetView
(
	@OrdPSId int,
	@OrdHId int
)
AS
SELECT O.*, M.MatName
FROM OrderDtl O
Inner Join Material M On O.OrdDPrdId=M.MatId
WHERE (OrdDPSId = @OrdPSId and OrdHId=@OrdHId)


GO
