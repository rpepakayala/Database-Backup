/****** Object:  UserDefinedFunction [dbo].[STRFILTER]    Script Date: 5/15/2018 12:15:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- Author:  Igor Nikiforov,  Montreal,  EMail: udfunctions@gmail.com   
-- STRFILTER() User-Defined Function
-- Removes all characters from a string except those specified.
-- STRFILTER(@cExpressionSearched, @cSearchExpression)
-- Return Values nvarchar(4000)
-- Parameters
-- @cExpressionSearched  Specifies the character string to search.
-- @cSearchExpression Specifies the characters to search for and retain in @cExpressionSearched.
-- Remarks
-- STRFILTER( ) removes all the characters from @cExpressionSearched that are not in @cSearchExpression, then returns the characters that remain.
-- Example
-- select dbo.STRFILTER('asdfghh5hh1jk6f3b7mn8m3m0m6','0123456789')   -- Displays 516378306
-- select dbo.STRFILTER('ABCDABCDABCD', 'AB')   -- Displays ABABAB
-- See Also CHRTRAN()  
-- UDF the name and functionality of which correspond  to the Foxtools function ( Foxtools is a Visual FoxPro API library) 
CREATE FUNCTION STRFILTER
    (
      @cExpressionSearched NVARCHAR(4000) ,
      @cSearchExpression NVARCHAR(256)
    )
RETURNS NVARCHAR(4000)
AS 
    BEGIN
        DECLARE
            @len SMALLINT ,
            @i SMALLINT ,
            @StrFiltred NVARCHAR(4000)
        SELECT
            @StrFiltred = N'' ,
            @i = 1 ,
            @len = DATALENGTH(@cExpressionSearched)
            / ( CASE SQL_VARIANT_PROPERTY(@cExpressionSearched, 'BaseType')
                  WHEN 'nvarchar' THEN 2
                  ELSE 1
                END ) -- for unicode

        WHILE @i <= @len 
            BEGIN
                IF CHARINDEX(SUBSTRING(@cExpressionSearched, @i, 1) COLLATE Latin1_General_BIN,
                             @cSearchExpression COLLATE Latin1_General_BIN) > 0 
                    SELECT
                        @StrFiltred = @StrFiltred
                        + SUBSTRING(@cExpressionSearched, @i, 1)
                SELECT
                    @i = @i + 1
            END

        RETURN  @StrFiltred
    END

GO
