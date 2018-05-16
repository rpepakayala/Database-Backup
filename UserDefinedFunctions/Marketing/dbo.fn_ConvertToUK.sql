/****** Object:  UserDefinedFunction [dbo].[fn_ConvertToUK]    Script Date: 5/15/2018 12:14:53 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE  FUNCTION fn_ConvertToUK
(
	@CountryName varchar(50)
)
RETURNS varchar(50)
AS
BEGIN
	--DECLARE @Name varchar(50)
	
	IF @CountryName = 'Wales' OR @CountryName = 'England' OR @CountryName = 'Ireland' OR @CountryName = 'Scotland'
		BEGIN
			SELECT @CountryName = 'United Kingdom'
		END

	RETURN @CountryName
END










GO
