/****** Object:  StoredProcedure [dbo].[MaterialLotDelete]    Script Date: 5/15/2018 12:10:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.MaterialLotDelete
(
	@MatId int,
	@MatLotId int
)
AS
	DELETE FROM MaterialLot WHERE MatId=@MatId AND MatLotId=@MatLotId;
RETURN @@Rowcount;


GO
