/****** Object:  StoredProcedure [dbo].[MaterialGroupsDtlUpdate]    Script Date: 5/15/2018 12:10:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.MaterialGroupsDtlUpdate
(
	@MatGHId int = NULL,
	@MatGPrdId int = NULL,
	@MatGDMailDate smalldatetime = NULL,
	@MatGDSignUpDate smalldatetime = NULL,
	@MatGDSignUpDateFlag bit = NULL,
	@MatGDImage varchar(50) = NULL,
	@MatGDImageFlag bit = NULL,
	@MatGDDisplayType tinyint = NULL,
	@MatGDDisplayTypeFlag bit = NULL,
	@MatGDMalPId int = NULL,
	@MatGDMalPIdFlag bit = NULL,
	@MatGDSignUpDeadline smallint = NULL,
	@MatGDSignUpDeadlineFlag bit = NULL,
	@MatGDUploadDBDeadline smallint = NULL,
	@MatGDUploadDBDeadlineFlag bit = NULL,
	@MatGDCreditCardValidation smallint = NULL,
	@MatGDCreditCardValidationFlag bit = NULL,
	@MatGDPlanSignUpDeadline smallint = NULL,
	@MatGDPlanSignUpDeadlineFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@MatGDSignUpDateFlag Is Not NULL)
BEGIN
	IF (@MatGDSignUpDate Is Not NULL)
		SET @SQL = @SQL + 'MatGDSignUpDate=''' + convert(varchar,@MatGDSignUpDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatGDSignUpDate=NULL, ';
END
IF (@MatGDImageFlag Is Not NULL)
BEGIN
	IF (@MatGDImage Is Not NULL)
		SET @SQL = @SQL + 'MatGDImage=''' + @MatGDImage + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatGDImage=NULL, ';
END
IF (@MatGDDisplayTypeFlag Is Not NULL)
BEGIN
	IF (@MatGDDisplayType Is Not NULL)
		SET @SQL = @SQL + 'MatGDDisplayType=' + convert(varchar,@MatGDDisplayType) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGDDisplayType=NULL, ';
END
IF (@MatGDMalPIdFlag Is Not NULL)
BEGIN
	IF (@MatGDMalPId Is Not NULL)
		SET @SQL = @SQL + 'MatGDMalPId=' + convert(varchar,@MatGDMalPId) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGDMalPId=NULL, ';
END
IF (@MatGDSignUpDeadlineFlag Is Not NULL)
BEGIN
	IF (@MatGDSignUpDeadline Is Not NULL)
		SET @SQL = @SQL + 'MatGDSignUpDeadline=' + convert(varchar,@MatGDSignUpDeadline) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGDSignUpDeadline=NULL, ';
END
IF (@MatGDUploadDBDeadlineFlag Is Not NULL)
BEGIN
	IF (@MatGDUploadDBDeadline Is Not NULL)
		SET @SQL = @SQL + 'MatGDUploadDBDeadline=' + convert(varchar,@MatGDUploadDBDeadline) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGDUploadDBDeadline=NULL, ';
END
IF (@MatGDCreditCardValidationFlag Is Not NULL)
BEGIN
	IF (@MatGDCreditCardValidation Is Not NULL)
		SET @SQL = @SQL + 'MatGDCreditCardValidation=' + convert(varchar,@MatGDCreditCardValidation) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGDCreditCardValidation=NULL, ';
END
IF (@MatGDPlanSignUpDeadlineFlag Is Not NULL)
BEGIN
	IF (@MatGDPlanSignUpDeadline Is Not NULL)
		SET @SQL = @SQL + 'MatGDPlanSignUpDeadline=' + convert(varchar,@MatGDPlanSignUpDeadline) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGDPlanSignUpDeadline=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE MaterialGroupsDtl SET ' + Left(@SQL, Len(@SQL)-1) + ' Where MatGHId = ' + convert(varchar,@MatGHId) + ' AND MatGPrdId = ' + convert(varchar,@MatGPrdId) + ' AND MatGDMailDate = ''' + convert(varchar,@MatGDMailDate) + '''' 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
