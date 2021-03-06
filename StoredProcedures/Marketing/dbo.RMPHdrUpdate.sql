/****** Object:  StoredProcedure [dbo].[RMPHdrUpdate]    Script Date: 5/15/2018 12:10:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.RMPHdrUpdate
(
	@RMPHId int = NULL,
	@RMPHName varchar(50) = NULL,
	@RMPHNameFlag bit = NULL,
	@RMPHDescription varchar(250) = NULL,
	@RMPHDescriptionFlag bit = NULL,
	@RMPHDisabled char(1) = NULL,
	@RMPHDisabledFlag bit = NULL,
	@RMPHHidden char(1) = NULL,
	@RMPHHiddenFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@RMPHNameFlag Is Not NULL)
BEGIN
	IF (@RMPHName Is Not NULL)
		SET @SQL = @SQL + 'RMPHName=''' + @RMPHName + ''', ';
	ELSE
		SET @SQL = @SQL + 'RMPHName=NULL, ';
END
IF (@RMPHDescriptionFlag Is Not NULL)
BEGIN
	IF (@RMPHDescription Is Not NULL)
		SET @SQL = @SQL + 'RMPHDescription=''' + @RMPHDescription + ''', ';
	ELSE
		SET @SQL = @SQL + 'RMPHDescription=NULL, ';
END
IF (@RMPHDisabledFlag Is Not NULL)
BEGIN
	IF (@RMPHDisabled Is Not NULL)
		SET @SQL = @SQL + 'RMPHDisabled=''' + @RMPHDisabled + ''', ';
	ELSE
		SET @SQL = @SQL + 'RMPHDisabled=NULL, ';
END
IF (@RMPHHiddenFlag Is Not NULL)
BEGIN
	IF (@RMPHHidden Is Not NULL)
		SET @SQL = @SQL + 'RMPHHidden=''' + @RMPHHidden + ''', ';
	ELSE
		SET @SQL = @SQL + 'RMPHHidden=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE RMPHdr SET ' + Left(@SQL, Len(@SQL)-1) + ' Where RMPHId = ' + convert(varchar,@RMPHId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
