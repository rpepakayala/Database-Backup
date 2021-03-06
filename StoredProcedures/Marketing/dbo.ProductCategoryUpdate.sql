/****** Object:  StoredProcedure [dbo].[ProductCategoryUpdate]    Script Date: 5/15/2018 12:10:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.ProductCategoryUpdate
(
	@CatId int = NULL,
	@PrdId int = NULL,
	@CatType tinyint = NULL,
	@CatTypeFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@CatTypeFlag Is Not NULL)
BEGIN
	IF (@CatType Is Not NULL)
		SET @SQL = @SQL + 'CatType=' + convert(varchar,@CatType) + ', ';
	ELSE
		SET @SQL = @SQL + 'CatType=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE ProductCategory SET ' + Left(@SQL, Len(@SQL)-1) + ' Where CatId = ' + convert(varchar,@CatId) + ' AND PrdId = ' + convert(varchar,@PrdId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
