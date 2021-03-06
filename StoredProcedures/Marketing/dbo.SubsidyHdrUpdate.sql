/****** Object:  StoredProcedure [dbo].[SubsidyHdrUpdate]    Script Date: 5/15/2018 12:10:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.SubsidyHdrUpdate
(
	@SubHId int = NULL,
	@SubHType tinyint = NULL,
	@SubHTypeFlag bit = NULL,
	@SubHDesc varchar(50) = NULL,
	@SubHDescFlag bit = NULL,
	@SubHMrktCountry smallint = NULL,
	@SubHMrktCountryFlag bit = NULL,
	@SubHDisable char(1) = NULL,
	@SubHDisableFlag bit = NULL,
	@CoOpOnly bit = NULL,
	@CoOpOnlyFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@SubHTypeFlag Is Not NULL)
BEGIN
	IF (@SubHType Is Not NULL)
		SET @SQL = @SQL + 'SubHType=' + convert(varchar,@SubHType) + ', ';
	ELSE
		SET @SQL = @SQL + 'SubHType=NULL, ';
END
IF (@SubHDescFlag Is Not NULL)
BEGIN
	IF (@SubHDesc Is Not NULL)
		SET @SQL = @SQL + 'SubHDesc=''' + @SubHDesc + ''', ';
	ELSE
		SET @SQL = @SQL + 'SubHDesc=NULL, ';
END
IF (@SubHMrktCountryFlag Is Not NULL)
BEGIN
	IF (@SubHMrktCountry Is Not NULL)
		SET @SQL = @SQL + 'SubHMrktCountry=' + convert(varchar,@SubHMrktCountry) + ', ';
	ELSE
		SET @SQL = @SQL + 'SubHMrktCountry=NULL, ';
END
IF (@SubHDisableFlag Is Not NULL)
BEGIN
	IF (@SubHDisable Is Not NULL)
		SET @SQL = @SQL + 'SubHDisable=''' + @SubHDisable + ''', ';
	ELSE
		SET @SQL = @SQL + 'SubHDisable=NULL, ';
END
IF (@CoOpOnlyFlag Is Not NULL)
BEGIN
	IF (@CoOpOnly Is Not NULL)
		SET @SQL = @SQL + 'CoOpOnly=' + convert(varchar,@CoOpOnly) + ', ';
	ELSE
		SET @SQL = @SQL + 'CoOpOnly=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE SubsidyHdr SET ' + Left(@SQL, Len(@SQL)-1) + ' Where SubHId = ' + convert(varchar,@SubHId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
