/****** Object:  StoredProcedure [dbo].[SICTemplateUpdate]    Script Date: 5/15/2018 12:10:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.SICTemplateUpdate
(
	@StoreId int = NULL,
	@StoreIdFlag bit = NULL,
	@Id int = NULL,
	@Name varchar(50) = NULL,
	@NameFlag bit = NULL,
	@SicCodes text = NULL,
	@SicCodesFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@StoreIdFlag Is Not NULL)
BEGIN
	IF (@StoreId Is Not NULL)
		SET @SQL = @SQL + 'StoreId=' + convert(varchar,@StoreId) + ', ';
	ELSE
		SET @SQL = @SQL + 'StoreId=NULL, ';
END
IF (@NameFlag Is Not NULL)
BEGIN
	IF (@Name Is Not NULL)
		SET @SQL = @SQL + 'Name=''' + @Name + ''', ';
	ELSE
		SET @SQL = @SQL + 'Name=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE SICTemplate SET ' + Left(@SQL, Len(@SQL)-1) + ' Where Id = ' + convert(varchar,@Id) 
	EXEC(@SQL)
END
IF (@SicCodesFlag Is Not NULL)
BEGIN
	DECLARE 	@ptrval0 binary(16)
	SELECT		@ptrval0 = TEXTPTR(SicCodes)
	FROM		SICTemplate
	WHERE		Id = @Id
	WRITETEXT	SICTemplate.SicCodes @ptrval0 @SicCodes
END


GO
