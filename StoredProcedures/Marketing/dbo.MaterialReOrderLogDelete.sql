/****** Object:  StoredProcedure [dbo].[MaterialReOrderLogDelete]    Script Date: 5/15/2018 12:10:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.MaterialReOrderLogDelete
(
	@MatRId int
)
AS
	DELETE FROM MaterialReOrderLog WHERE MatRId=@MatRId;
RETURN @@Rowcount;


GO
