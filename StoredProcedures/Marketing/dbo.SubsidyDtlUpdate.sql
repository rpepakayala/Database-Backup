/****** Object:  StoredProcedure [dbo].[SubsidyDtlUpdate]    Script Date: 5/15/2018 12:10:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.SubsidyDtlUpdate
(
	@SubDId int = NULL,
	@SubHId int = NULL,
	@SubHIdFlag bit = NULL,
	@SubDCalanderYear smallint = NULL,
	@SubDCalanderYearFlag bit = NULL,
	@SubDDesc varchar(50) = NULL,
	@SubDDescFlag bit = NULL,
	@SubDUptoAmount real = NULL,
	@SubDUptoAmountFlag bit = NULL,
	@SubDAmount real = NULL,
	@SubDAmountFlag bit = NULL,
	@SubDRule1 smallint = NULL,
	@SubDRule1Flag bit = NULL,
	@SubDStoreField varchar(50) = NULL,
	@SubDStoreFieldFlag bit = NULL,
	@SubDStoreValue varchar(2000) = NULL,
	@SubDStoreValueFlag bit = NULL,
	@SubDDisable char(1) = NULL,
	@SubDDisableFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@SubHIdFlag Is Not NULL)
BEGIN
	IF (@SubHId Is Not NULL)
		SET @SQL = @SQL + 'SubHId=' + convert(varchar,@SubHId) + ', ';
	ELSE
		SET @SQL = @SQL + 'SubHId=NULL, ';
END
IF (@SubDCalanderYearFlag Is Not NULL)
BEGIN
	IF (@SubDCalanderYear Is Not NULL)
		SET @SQL = @SQL + 'SubDCalanderYear=' + convert(varchar,@SubDCalanderYear) + ', ';
	ELSE
		SET @SQL = @SQL + 'SubDCalanderYear=NULL, ';
END
IF (@SubDDescFlag Is Not NULL)
BEGIN
	IF (@SubDDesc Is Not NULL)
		SET @SQL = @SQL + 'SubDDesc=''' + @SubDDesc + ''', ';
	ELSE
		SET @SQL = @SQL + 'SubDDesc=NULL, ';
END
IF (@SubDUptoAmountFlag Is Not NULL)
BEGIN
	IF (@SubDUptoAmount Is Not NULL)
		SET @SQL = @SQL + 'SubDUptoAmount=' + convert(varchar,@SubDUptoAmount) + ', ';
	ELSE
		SET @SQL = @SQL + 'SubDUptoAmount=NULL, ';
END
IF (@SubDAmountFlag Is Not NULL)
BEGIN
	IF (@SubDAmount Is Not NULL)
		SET @SQL = @SQL + 'SubDAmount=' + convert(varchar,@SubDAmount) + ', ';
	ELSE
		SET @SQL = @SQL + 'SubDAmount=NULL, ';
END
IF (@SubDRule1Flag Is Not NULL)
BEGIN
	IF (@SubDRule1 Is Not NULL)
		SET @SQL = @SQL + 'SubDRule1=' + convert(varchar,@SubDRule1) + ', ';
	ELSE
		SET @SQL = @SQL + 'SubDRule1=NULL, ';
END
IF (@SubDStoreFieldFlag Is Not NULL)
BEGIN
	IF (@SubDStoreField Is Not NULL)
		SET @SQL = @SQL + 'SubDStoreField=''' + @SubDStoreField + ''', ';
	ELSE
		SET @SQL = @SQL + 'SubDStoreField=NULL, ';
END
IF (@SubDStoreValueFlag Is Not NULL)
BEGIN
	IF (@SubDStoreValue Is Not NULL)
		SET @SQL = @SQL + 'SubDStoreValue=''' + @SubDStoreValue + ''', ';
	ELSE
		SET @SQL = @SQL + 'SubDStoreValue=NULL, ';
END
IF (@SubDDisableFlag Is Not NULL)
BEGIN
	IF (@SubDDisable Is Not NULL)
		SET @SQL = @SQL + 'SubDDisable=''' + @SubDDisable + ''', ';
	ELSE
		SET @SQL = @SQL + 'SubDDisable=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE SubsidyDtl SET ' + Left(@SQL, Len(@SQL)-1) + ' Where SubDId = ' + convert(varchar,@SubDId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
