/****** Object:  StoredProcedure [dbo].[CategoryCatalogViewGet]    Script Date: 5/15/2018 12:10:09 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.CategoryCatalogViewGet
(
	@Filter  varchar(4000) = null,
	@OrderBy varchar(4000) = null
)
AS
	DECLARE @SQL varchar(4000);
	SET @SQL =  'SELECT Category.* FROM  CategoryCatalog INNER JOIN Category ON Category.CatID = CategoryCatalog.CatID';
	IF (@Filter Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Where ' + @Filter;
	END
	IF (@OrderBy Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Order By  ' + @OrderBy;
	END
;
EXEC(@SQL);


GO
