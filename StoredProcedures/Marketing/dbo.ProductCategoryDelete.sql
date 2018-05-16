/****** Object:  StoredProcedure [dbo].[ProductCategoryDelete]    Script Date: 5/15/2018 12:10:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.ProductCategoryDelete
(
	@CatId int,
	@PrdId int
)
AS
	DELETE FROM ProductCategory WHERE CatId=@CatId AND PrdId=@PrdId;
RETURN @@Rowcount;


GO
