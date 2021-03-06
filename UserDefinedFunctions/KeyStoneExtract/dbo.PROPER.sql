/****** Object:  UserDefinedFunction [dbo].[PROPER]    Script Date: 5/15/2018 12:14:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


 -- Author:  Igor Nikiforov,  Montreal,  EMail: udfunctions@gmail.com   
 -- PROPER( ) User-Defined Function
 -- Returns from a character expression a string capitalized as appropriate for proper names.
 -- PROPER(@cExpression)
 -- Return Values nvarchar(4000)
 -- Parameters
 -- @cExpression nvarchar(4000) Specifies the character expression from which PROPER( ) returns a capitalized character string. 
 -- Example
 -- declare @gcExpr1 nvarchar(4000), @gcExpr2 nvarchar(4000)
 -- select @gcExpr1 = 'Visual Basic.NET', @gcExpr2 = 'VISUAL BASIC.NET'
 -- select dbo.PROPER(@gcExpr1)  -- Displays 'Visual Basic.net'
 -- select dbo.PROPER(@gcExpr2)  -- Displays 'Visual Basic.net'
 -- Remarks
 -- PROPER similar to the Oracle function PL/SQL  INITCAP 
 -- UDF the name and functionality of which correspond  to the  Visual FoxPro function  
CREATE FUNCTION [dbo].[PROPER]
    (
      @expression NVARCHAR(4000)
    )
RETURNS NVARCHAR(4000)
AS 
    BEGIN
        DECLARE
            @i SMALLINT ,
            @properexpression NVARCHAR(4000) ,
            @lenexpression SMALLINT ,
            @flag BIT ,
            @symbol NCHAR(1)
        SELECT
            @flag = 1 ,
            @i = 1 ,
            @properexpression = '' ,
            @lenexpression = DATALENGTH(@expression)
            / ( CASE SQL_VARIANT_PROPERTY(@expression, 'BaseType')
                  WHEN 'nvarchar' THEN 2
                  ELSE 1
                END ) 

        WHILE @i <= @lenexpression 
            BEGIN
                SELECT
                    @symbol = LOWER(SUBSTRING(@expression, @i, 1))
                IF @symbol IN ( NCHAR(32), NCHAR(9), NCHAR(10), NCHAR(11),
                                NCHAR(12), NCHAR(13), NCHAR(160) )
                    AND ASCII(@symbol) <> 0 
                    SELECT
                        @flag = 1
                ELSE 
                    IF @flag = 1 
                        SELECT
                            @symbol = UPPER(@symbol) ,
                            @flag = 0 
                SELECT
                    @properexpression = @properexpression + @symbol ,
                    @i = @i + 1 
            END

        RETURN @properexpression 
    END


GO
