/****** Object:  StoredProcedure [dbo].[CategoryAdd]    Script Date: 5/15/2018 12:10:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.CategoryAdd
(
	@CatId int = NULL,
	@CatType tinyint = NULL,
	@CatName varchar(50) = NULL,
	@CatDescription varchar(250) = NULL,
	@CatImage varchar(50) = NULL,
	@CatDisabled char(1) = NULL
)
AS
INSERT INTO Category (CatId, CatType, CatName, CatDescription, CatImage, CatDisabled)
 VALUES (@CatId, @CatType, @CatName, @CatDescription, @CatImage, @CatDisabled);


GO
