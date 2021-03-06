/****** Object:  StoredProcedure [dbo].[ProofSetLayersUpdate]    Script Date: 5/15/2018 12:10:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.ProofSetLayersUpdate
(
	@PrfSId int = NULL,
	@PrfSIdFlag bit = NULL,
	@PrfLId int = NULL,
	@PrfLType tinyint = NULL,
	@PrfLTypeFlag bit = NULL,
	@PrfLLock char(1) = NULL,
	@PrfLLockFlag bit = NULL,
	@PrfLCoordX1 int = NULL,
	@PrfLCoordX1Flag bit = NULL,
	@PrfLCoordY1 int = NULL,
	@PrfLCoordY1Flag bit = NULL,
	@PrfLCoordX2 int = NULL,
	@PrfLCoordX2Flag bit = NULL,
	@PrfLCoordY2 int = NULL,
	@PrfLCoordY2Flag bit = NULL,
	@PrfLRotation int = NULL,
	@PrfLRotationFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@PrfSIdFlag Is Not NULL)
BEGIN
	IF (@PrfSId Is Not NULL)
		SET @SQL = @SQL + 'PrfSId=' + convert(varchar,@PrfSId) + ', ';
	ELSE
		SET @SQL = @SQL + 'PrfSId=NULL, ';
END
IF (@PrfLTypeFlag Is Not NULL)
BEGIN
	IF (@PrfLType Is Not NULL)
		SET @SQL = @SQL + 'PrfLType=' + convert(varchar,@PrfLType) + ', ';
	ELSE
		SET @SQL = @SQL + 'PrfLType=NULL, ';
END
IF (@PrfLLockFlag Is Not NULL)
BEGIN
	IF (@PrfLLock Is Not NULL)
		SET @SQL = @SQL + 'PrfLLock=''' + @PrfLLock + ''', ';
	ELSE
		SET @SQL = @SQL + 'PrfLLock=NULL, ';
END
IF (@PrfLCoordX1Flag Is Not NULL)
BEGIN
	IF (@PrfLCoordX1 Is Not NULL)
		SET @SQL = @SQL + 'PrfLCoordX1=' + convert(varchar,@PrfLCoordX1) + ', ';
	ELSE
		SET @SQL = @SQL + 'PrfLCoordX1=NULL, ';
END
IF (@PrfLCoordY1Flag Is Not NULL)
BEGIN
	IF (@PrfLCoordY1 Is Not NULL)
		SET @SQL = @SQL + 'PrfLCoordY1=' + convert(varchar,@PrfLCoordY1) + ', ';
	ELSE
		SET @SQL = @SQL + 'PrfLCoordY1=NULL, ';
END
IF (@PrfLCoordX2Flag Is Not NULL)
BEGIN
	IF (@PrfLCoordX2 Is Not NULL)
		SET @SQL = @SQL + 'PrfLCoordX2=' + convert(varchar,@PrfLCoordX2) + ', ';
	ELSE
		SET @SQL = @SQL + 'PrfLCoordX2=NULL, ';
END
IF (@PrfLCoordY2Flag Is Not NULL)
BEGIN
	IF (@PrfLCoordY2 Is Not NULL)
		SET @SQL = @SQL + 'PrfLCoordY2=' + convert(varchar,@PrfLCoordY2) + ', ';
	ELSE
		SET @SQL = @SQL + 'PrfLCoordY2=NULL, ';
END
IF (@PrfLRotationFlag Is Not NULL)
BEGIN
	IF (@PrfLRotation Is Not NULL)
		SET @SQL = @SQL + 'PrfLRotation=' + convert(varchar,@PrfLRotation) + ', ';
	ELSE
		SET @SQL = @SQL + 'PrfLRotation=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE ProofSetLayers SET ' + Left(@SQL, Len(@SQL)-1) + ' Where PrfLId = ' + convert(varchar,@PrfLId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
