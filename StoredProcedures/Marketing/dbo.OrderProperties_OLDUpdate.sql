/****** Object:  StoredProcedure [dbo].[OrderProperties_OLDUpdate]    Script Date: 5/15/2018 12:10:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OrderProperties_OLDUpdate
(
	@OrdHId int = NULL,
	@OrdHIdFlag bit = NULL,
	@OrdPId int = NULL,
	@OrdPEstShipDate smalldatetime = NULL,
	@OrdPEstShipDateFlag bit = NULL,
	@OrdPActShipDate smalldatetime = NULL,
	@OrdPActShipDateFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@OrdHIdFlag Is Not NULL)
BEGIN
	IF (@OrdHId Is Not NULL)
		SET @SQL = @SQL + 'OrdHId=' + convert(varchar,@OrdHId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdHId=NULL, ';
END
IF (@OrdPEstShipDateFlag Is Not NULL)
BEGIN
	IF (@OrdPEstShipDate Is Not NULL)
		SET @SQL = @SQL + 'OrdPEstShipDate=''' + convert(varchar,@OrdPEstShipDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPEstShipDate=NULL, ';
END
IF (@OrdPActShipDateFlag Is Not NULL)
BEGIN
	IF (@OrdPActShipDate Is Not NULL)
		SET @SQL = @SQL + 'OrdPActShipDate=''' + convert(varchar,@OrdPActShipDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdPActShipDate=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE OrderProperties_OLD SET ' + Left(@SQL, Len(@SQL)-1) + ' Where OrdPId = ' + convert(varchar,@OrdPId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
