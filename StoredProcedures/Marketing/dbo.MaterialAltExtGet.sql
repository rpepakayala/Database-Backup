/****** Object:  StoredProcedure [dbo].[MaterialAltExtGet]    Script Date: 5/15/2018 12:10:14 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.MaterialAltExtGet
(
	@Filter  varchar(4000) = null,
	@OrderBy varchar(4000) = null
)
AS
	DECLARE @SQL varchar(4000);
	SET @SQL =  'SELECT MaterialAlt.MatId, Material.MatDesc, MaterialAlt.MatAltId, Material_1.MatVendorSku AS MatAltSku, Material_1.MatDesc AS MatAltDesc, Material_1.MatName AS MatAltName, MaterialAlt.MatAltOrder
			FROM  MaterialAlt INNER JOIN
			Material ON MaterialAlt.MatId = Material.MatId INNER JOIN
		                Material Material_1 ON MaterialAlt.MatAltId = Material_1.MatId';
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
