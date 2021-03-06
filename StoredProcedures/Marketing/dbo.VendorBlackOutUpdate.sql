/****** Object:  StoredProcedure [dbo].[VendorBlackOutUpdate]    Script Date: 5/15/2018 12:10:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.VendorBlackOutUpdate
(
	@VendorId int = NULL,
	@VboMonth tinyint = NULL,
	@VboDay tinyint = NULL,
	@VboDisabled char(1) = NULL,
	@VboDisabledFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@VboDisabledFlag Is Not NULL)
BEGIN
	IF (@VboDisabled Is Not NULL)
		SET @SQL = @SQL + 'VboDisabled=''' + @VboDisabled + ''', ';
	ELSE
		SET @SQL = @SQL + 'VboDisabled=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE VendorBlackOut SET ' + Left(@SQL, Len(@SQL)-1) + ' Where VendorId = ' + convert(varchar,@VendorId) + ' AND VboMonth = ' + convert(varchar,@VboMonth) + ' AND VboDay = ' + convert(varchar,@VboDay) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
