/****** Object:  StoredProcedure [dbo].[MailOnDemandView]    Script Date: 5/15/2018 12:10:14 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE dbo.MailOnDemandView
(
	@CatlId int,
	@strCatIds varchar(1000) = NULL
)
AS
	DECLARE @SQL varchar(4000);
	SET @SQL =  'SELECT * FROM Material
			WHERE MatId IN (
				SELECT pc.PrdID as MatID FROM ProductCategory pc
				INNER JOIN Category c ON (c.CatId = pc.CatID)
				INNER JOIN CategoryCatalog cc ON (cc.CatId = c.CatId AND cc.CatlId = ' + CONVERT(varchar,@CatlId) + ') 
				) ';
	IF (@strCatIds Is Not NULL)
	BEGIN
		SET @SQL =  'SELECT * FROM Material
				WHERE MatId IN (
					SELECT pc.PrdID as MatID FROM ProductCategory pc
					INNER JOIN Category c ON (c.CatId = pc.CatID)
					INNER JOIN CategoryCatalog cc ON (cc.CatId = c.CatId AND cc.CatlId = ' + CONVERT(varchar,@CatlId) + ')
		                	WHERE pc.CatId IN ' + @strCatIds + '
					) ';
	END
	
	SET @SQL = @SQL + ' AND MatAvailMailOnDemand = ''Y'' AND MatDisabled <> "Y" AND GETDATE() >= MatAvailFrom AND GETDATE() <= MatAvailThru ORDER BY MatName';
	EXEC(@SQL);


GO
