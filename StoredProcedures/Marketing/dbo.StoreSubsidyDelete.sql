/****** Object:  StoredProcedure [dbo].[StoreSubsidyDelete]    Script Date: 5/15/2018 12:10:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.StoreSubsidyDelete
(
	@StoreSId int,
	@StoreSubYear smallint,
	@StoreSubHId int
)
AS
	DELETE FROM StoreSubsidy WHERE StoreSId=@StoreSId AND StoreSubYear=@StoreSubYear AND StoreSubHId=@StoreSubHId;
RETURN @@Rowcount;


GO
