/****** Object:  UserDefinedFunction [dbo].[PADC]    Script Date: 5/15/2018 12:15:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

 -- Author:  Igor Nikiforov,  Montreal,  EMail: udfunctions@gmail.com 
 -- PADL(), PADR(), PADC() User-Defined Functions
 -- Returns a string from an expression, padded with spaces or characters to a specified length on the left or right sides, or both.
 -- PADL(@eExpression, @nResultSize [, @cPadCharacter]) -Or-
 -- PADR(@eExpression, @nResultSize [, @cPadCharacter]) -Or-
 -- PADC(@eExpression, @nResultSize [, @cPadCharacter])
 -- Return Values nvarchar(4000)
 -- Parameters
 -- @eExpression nvarchar(4000) Specifies the expression to be padded.
 -- @nResultSize  smallint Specifies the total number of characters in the expression after it is padded. 
 -- @cPadCharacter nvarchar(4000) Specifies the value to use for padding. This value is repeated as necessary to pad the expression to the specified number of characters. 
 -- If you omit @cPadCharacter, spaces (ASCII character 32) are used for padding. 
 -- Remarks
 -- PADL() inserts padding on the left, PADR() inserts padding on the right, and PADC() inserts padding on both sides.
 -- Example
 -- declare @gcString  nvarchar(4000)
 -- select @gcString  = 'TITLE' 
 -- select dbo.PADL(@gcString, 40, default)
 -- select dbo.PADL(@gcString, 40, '=!=')
 -- select dbo.PADR(@gcString, 40, '=+=')
 -- select dbo.PADC(@gcString, 40, '=~')  
 -- UDF the name and functionality of which correspond  to the  Visual FoxPro function   
CREATE FUNCTION PADC
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
                DECLARE
                    @nLeftLen SMALLINT ,
                    @nRightLen SMALLINT
                SET @nLeftLen = ( @nLen - @length ) / 2            -- Quantity of characters, added at the left
                SET @nRightLen = @nLen - @length - @nLeftLen  -- Quantity of characters, added on the right
                SET @cString = LEFT(REPLICATE(@cPadCharacter,
                                              CEILING(@nLeftLen
                                                      / @lengthPadCharacter)
                                              + 2), @nLeftLen) + @cString
                    + LEFT(REPLICATE(@cPadCharacter,
                                     CEILING(@nRightLen / @lengthPadCharacter)
                                     + 2), @nRightLen)
            END

        RETURN (@cString)
    END

GO
