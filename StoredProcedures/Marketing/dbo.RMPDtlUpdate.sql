/****** Object:  StoredProcedure [dbo].[RMPDtlUpdate]    Script Date: 5/15/2018 12:10:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.RMPDtlUpdate
(
	@RMPHId int = NULL,
	@RMPDId int = NULL,
	@MatGHId int = NULL,
	@MatGHIdFlag bit = NULL,
	@MatGHType tinyint = NULL,
	@MatGHTypeFlag bit = NULL,
	@MatGPrdId int = NULL,
	@MatGPrdIdFlag bit = NULL,
	@MatGDMailDate smalldatetime = NULL,
	@MatGDMailDateFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@MatGHIdFlag Is Not NULL)
BEGIN
	IF (@MatGHId Is Not NULL)
		SET @SQL = @SQL + 'MatGHId=' + convert(varchar,@MatGHId) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGHId=NULL, ';
END
IF (@MatGHTypeFlag Is Not NULL)
BEGIN
	IF (@MatGHType Is Not NULL)
		SET @SQL = @SQL + 'MatGHType=' + convert(varchar,@MatGHType) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGHType=NULL, ';
END
IF (@MatGPrdIdFlag Is Not NULL)
BEGIN
	IF (@MatGPrdId Is Not NULL)
		SET @SQL = @SQL + 'MatGPrdId=' + convert(varchar,@MatGPrdId) + ', ';
	ELSE
		SET @SQL = @SQL + 'MatGPrdId=NULL, ';
END
IF (@MatGDMailDateFlag Is Not NULL)
BEGIN
	IF (@MatGDMailDate Is Not NULL)
		SET @SQL = @SQL + 'MatGDMailDate=''' + convert(varchar,@MatGDMailDate) + ''', ';
	ELSE
		SET @SQL = @SQL + 'MatGDMailDate=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE RMPDtl SET ' + Left(@SQL, Len(@SQL)-1) + ' Where RMPHId = ' + convert(varchar,@RMPHId) + ' AND RMPDId = ' + convert(varchar,@RMPDId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
