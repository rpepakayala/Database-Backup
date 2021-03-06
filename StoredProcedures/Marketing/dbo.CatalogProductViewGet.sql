/****** Object:  StoredProcedure [dbo].[CatalogProductViewGet]    Script Date: 5/15/2018 12:10:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.CatalogProductViewGet
(
	@CatIds  varchar(1000),
	@CatType int,
	@OrderBy varchar(4000) = null
)
AS
	DECLARE @SQL varchar(4000);
	IF (@CatType = 3)
	BEGIN
	SET @SQL =  'SELECT CatId, PrdId, CatType, RMPHName FROM ProductCategory';
	SET @SQL = @SQL + ' INNER JOIN RMPHdr ON RMPHId = PrdId';
	END
	IF (@CatType = 4)
	BEGIN
	SET @SQL =  'SELECT CatId, PrdId, CatType, MatName FROM ProductCategory';
	SET @SQL = @SQL + ' INNER JOIN Material ON MatId = PrdId';
	END
	SET @SQL = @SQL + ' WHERE CatId IN ' + @CatIds;
	IF (@CatType = 3)
	BEGIN
	SET @SQL = @SQL + ' AND RMPHDisabled=''N''';
	END
	IF (@OrderBy Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Order By  ' + @OrderBy;
	END
;
EXEC(@SQL);


GO
