/****** Object:  StoredProcedure [dbo].[CategoryCatalogUpdate]    Script Date: 5/15/2018 12:10:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.CategoryCatalogUpdate
(
	@CatlId int = NULL,
	@CatId int = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE CategoryCatalog SET ' + Left(@SQL, Len(@SQL)-1) + ' Where CatlId = ' + convert(varchar,@CatlId) + ' AND CatId = ' + convert(varchar,@CatId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
