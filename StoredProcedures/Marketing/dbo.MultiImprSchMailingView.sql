/****** Object:  StoredProcedure [dbo].[MultiImprSchMailingView]    Script Date: 5/15/2018 12:10:18 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.MultiImprSchMailingView
(
	@Filter  varchar(100) = null,
	@DateFilter varchar(100) = null,
	@OrderBy varchar(4000) = null
)
AS
	DECLARE @SQL varchar(4000);
	SET @SQL =  'SELECT MaterialGroupsHdr.* from CategoryCatalog ';
	SET @SQL =  @SQL + 'JOIN ProductCategory ON CategoryCatalog.CatId = ProductCategory.CatId ';
	SET @SQL =  @SQL + 'JOIN MaterialGroupsHdr on ProductCategory.PrdId = MaterialGroupsHdr.MatGHId ';
	SET @SQL =  @SQL + 'JOIN MaterialGroupsDtl on ProductCategory.PrdId = MaterialGroupsDtl.MatGPrdId '
	SET @SQL = @SQL + ' Where CategoryCatalog.CatlId =' + @Filter + ' AND Year (MaterialGroupsDtl.MatGDMailDate) = ' + @DateFilter;
	IF (@OrderBy Is Not NULL)
	BEGIN
		SET @SQL = @SQL + ' Order By  ' + @OrderBy;
	END
;
EXEC(@SQL);


GO
