/****** Object:  StoredProcedure [dbo].[MaterialGroupsQtyUpdate]    Script Date: 5/15/2018 12:10:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.MaterialGroupsQtyUpdate
(
	@MatGHid int = NULL,
	@MatGHidFlag bit = NULL,
	@MatGPrdId int = NULL,
	@MatGPrdIdFlag bit = NULL,
	@MatGDDate smalldatetime = NULL,
	@MatGDDateFlag bit = NULL,
	@MatGQId int = NULL,
	@MatGQtyBreak smallint = NULL,
	@MatGQtyBreakFlag bit = NULL,
	@MatGPriceBreak float = NULL,
	@MatGPriceBreakFlag bit = NULL,
	@MatGDBPriceBreak float = NULL,
	@MatGDBPriceBreakFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@MatGHidFlag Is Not NULL)
BEGIN
	IF (@MatGHid Is Not NULL)
		SET @SQL = @SQL + 'MatGHid=' + convert(varchar,@MatGHid) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGHid=NULL, ';
END
IF (@MatGPrdIdFlag Is Not NULL)
BEGIN
	IF (@MatGPrdId Is Not NULL)
		SET @SQL = @SQL + 'MatGPrdId=' + convert(varchar,@MatGPrdId) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGPrdId=NULL, ';
END
IF (@MatGDDateFlag Is Not NULL)
BEGIN
	IF (@MatGDDate Is Not NULL)
		SET @SQL = @SQL + 'MatGDDate=''' + convert(varchar,@MatGDDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatGDDate=NULL, ';
END
IF (@MatGQtyBreakFlag Is Not NULL)
BEGIN
	IF (@MatGQtyBreak Is Not NULL)
		SET @SQL = @SQL + 'MatGQtyBreak=' + convert(varchar,@MatGQtyBreak) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGQtyBreak=NULL, ';
END
IF (@MatGPriceBreakFlag Is Not NULL)
BEGIN
	IF (@MatGPriceBreak Is Not NULL)
		SET @SQL = @SQL + 'MatGPriceBreak=' + convert(varchar,@MatGPriceBreak) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGPriceBreak=NULL, ';
END
IF (@MatGDBPriceBreakFlag Is Not NULL)
BEGIN
	IF (@MatGDBPriceBreak Is Not NULL)
		SET @SQL = @SQL + 'MatGDBPriceBreak=' + convert(varchar,@MatGDBPriceBreak) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGDBPriceBreak=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE MaterialGroupsQty SET ' + Left(@SQL, Len(@SQL)-1) + ' Where MatGQId = ' + convert(varchar,@MatGQId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
