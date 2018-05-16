/****** Object:  UserDefinedFunction [dbo].[fn_SubsidyDesc]    Script Date: 5/15/2018 12:14:53 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE FUNCTION fn_SubsidyDesc(@SubsidyDesc varchar(50))  
RETURNS varchar(50) AS  

BEGIN 

DECLARE @LocalDesc varchar(50)

SELECT @LocalDesc = @SubsidyDesc

--If it is Numeric
IF ISNUMERIC(@LocalDesc) <> 0
	BEGIN
		SELECT @LocalDesc = 'Store ' + @SubsidyDesc
	END

RETURN (@LocalDesc)

END


GO
