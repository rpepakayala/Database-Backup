/****** Object:  StoredProcedure [dbo].[CategoryUpdate]    Script Date: 5/15/2018 12:10:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.CategoryUpdate
(
	@CatId int = NULL,
	@CatType tinyint = NULL,
	@CatTypeFlag bit = NULL,
	@CatName varchar(50) = NULL,
	@CatNameFlag bit = NULL,
	@CatDescription varchar(250) = NULL,
	@CatDescriptionFlag bit = NULL,
	@CatImage varchar(50) = NULL,
	@CatImageFlag bit = NULL,
	@CatDisabled char(1) = NULL,
	@CatDisabledFlag bit = NULL
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
IF (@CatNameFlag Is Not NULL)
BEGIN
	IF (@CatName Is Not NULL)
		SET @SQL = @SQL + 'CatName=''' + @CatName + ''', ';
	ELSE
		SET @SQL = @SQL + 'CatName=NULL, ';
END
IF (@CatDescriptionFlag Is Not NULL)
BEGIN
	IF (@CatDescription Is Not NULL)
		SET @SQL = @SQL + 'CatDescription=''' + @CatDescription + ''', ';
	ELSE
		SET @SQL = @SQL + 'CatDescription=NULL, ';
END
IF (@CatImageFlag Is Not NULL)
BEGIN
	IF (@CatImage Is Not NULL)
		SET @SQL = @SQL + 'CatImage=''' + @CatImage + ''', ';
	ELSE
		SET @SQL = @SQL + 'CatImage=NULL, ';
END
IF (@CatDisabledFlag Is Not NULL)
BEGIN
	IF (@CatDisabled Is Not NULL)
		SET @SQL = @SQL + 'CatDisabled=''' + @CatDisabled + ''', ';
	ELSE
		SET @SQL = @SQL + 'CatDisabled=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE Category SET ' + Left(@SQL, Len(@SQL)-1) + ' Where CatId = ' + convert(varchar,@CatId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
