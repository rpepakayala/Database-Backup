/****** Object:  UserDefinedFunction [dbo].[PADR]    Script Date: 5/15/2018 12:15:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

 -- Author:  Igor Nikiforov,  Montreal,  EMail: udfunctions@gmail.com   
 -- PADL(), PADR(), PADC() User-Defined Functions
 -- Returns a string from an expression, padded with spaces or characters to a specified length on the left or right sides, or both.
 -- PADR similar to the Oracle function PL/SQL RPAD 
CREATE FUNCTION PADR
    (
      @cString NVARCHAR(4000) ,
      @nLen SMALLINT ,
      @cPadCharacter NVARCHAR(4000) = ' ' 
    )
RETURNS NVARCHAR(4000)
AS 
    BEGIN
        DECLARE
            @length SMALLINT ,
            @lengthPadCharacter SMALLINT
        IF @cPadCharacter IS NULL
            OR DATALENGTH(@cPadCharacter) = 0 
            SET @cPadCharacter = SPACE(1) 
        SELECT
            @length = DATALENGTH(@cString)
            / ( CASE SQL_VARIANT_PROPERTY(@cString, 'BaseType')
                  WHEN 'nvarchar' THEN 2
                  ELSE 1
                END ) -- for unicode
        SELECT
            @lengthPadCharacter = DATALENGTH(@cPadCharacter)
            / ( CASE SQL_VARIANT_PROPERTY(@cPadCharacter, 'BaseType')
                  WHEN 'nvarchar' THEN 2
                  ELSE 1
                END ) -- for unicode

        IF @length >= @nLen 
            SET @cString = LEFT(@cString, @nLen)
        ELSE 
            BEGIN
                DECLARE @nRightLen SMALLINT
                SET @nRightLen = @nLen - @length -- Quantity of characters, added on the right
                SET @cString = @cString + LEFT(REPLICATE(@cPadCharacter,
                                                         CEILING(@nRightLen
                                                              / @lengthPadCharacter)
                                                         + 2), @nRightLen)
            END

        RETURN (@cString)
    END

GO
