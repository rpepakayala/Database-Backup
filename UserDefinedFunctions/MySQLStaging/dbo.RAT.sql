/****** Object:  UserDefinedFunction [dbo].[RAT]    Script Date: 5/15/2018 12:15:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- Author:  Igor Nikiforov,  Montreal,  EMail: udfunctions@gmail.com 
-- RAT( ) User-Defined Function
-- Returns the numeric position of the last (rightmost) occurrence of a character string within another character string.
-- (including  overlaps)
-- RAT(@cSearchExpression, @cExpressionSearched [, @nOccurrence])
-- Return Values smallint 
-- Parameters
-- @cSearchExpression nvarchar(4000) Specifies the character expression that RAT( ) looks for in @cExpressionSearched. 
-- @cExpressionSearched nvarchar(4000) Specifies the character expression that RAT() searches. 
-- @nOccurrence smallint Specifies which occurrence, starting from the right and moving left, of @cSearchExpression RAT() searches for in @cExpressionSearched. By default, RAT() searches for the last occurrence of @cSearchExpression (@nOccurrence = 1). If @nOccurrence is 2, RAT() searches for the next to last occurrence, and so on. 
-- Remarks
-- RAT(), the reverse of the AT() function, searches the character expression in @cExpressionSearched starting from the right and moving left, looking for the last occurrence of the string specified in @cSearchExpression.
-- RAT() returns an integer indicating the position of the first character in @cSearchExpression in @cExpressionSearched. RAT() returns 0 if @cSearchExpression is not found in @cExpressionSearched, or if @nOccurrence is greater than the number of times @cSearchExpression occurs in @cExpressionSearched.
-- The search performed by RAT() is case-sensitive.
-- Example
-- declare @gcString nvarchar(4000), @gcFindString nvarchar(4000)
-- select @gcString = 'abracadabra', @gcFindString = 'a' 
-- select dbo.RAT(@gcFindString , @gcString, default)  -- Displays 11
-- select dbo.RAT(@gcFindString , @gcString , 3)       -- Displays 6
-- select @gcString = 'goood men', @gcFindString = 'oo'
-- select dbo.RAT(@gcFindString, @gcString, 1)  -- Displays 3
-- select dbo.RAT(@gcFindString, @gcString, 2)  -- Displays 2, including  overlaps
-- See Also AT()  User-Defined Function 
-- UDF the name and functionality of which correspond  to the  Visual FoxPro function     
CREATE FUNCTION RAT
    (
      @cSearchExpression NVARCHAR(4000) ,
      @cExpressionSearched NVARCHAR(4000) ,
      @nOccurrence SMALLINT = 1 
    )
RETURNS SMALLINT
AS 
    BEGIN
        IF @nOccurrence > 0 
            BEGIN
                DECLARE
                    @i SMALLINT ,
                    @length SMALLINT ,
                    @StartingPosition SMALLINT
                SELECT
                    @length = DATALENGTH(@cExpressionSearched)
                    / ( CASE SQL_VARIANT_PROPERTY(@cExpressionSearched,
                                                  'BaseType')
                          WHEN 'nvarchar' THEN 2
                          ELSE 1
                        END ) -- for unicode
                SELECT
                    @cSearchExpression = REVERSE(@cSearchExpression) ,
                    @cExpressionSearched = REVERSE(@cExpressionSearched)
                SELECT
                    @i = 0 ,
                    @StartingPosition = -1 
                WHILE @StartingPosition <> 0
                    AND @nOccurrence > @i 
                    SELECT
                        @i = @i + 1 ,
                        @StartingPosition = CHARINDEX(@cSearchExpression  COLLATE Latin1_General_BIN,
                                                      @cExpressionSearched  COLLATE Latin1_General_BIN,
                                                      @StartingPosition + 1)
                IF @StartingPosition <> 0 
                    SELECT
                        @StartingPosition = 2 - @StartingPosition + @length
                        - DATALENGTH(@cSearchExpression)
                        / ( CASE SQL_VARIANT_PROPERTY(@cSearchExpression,
                                                      'BaseType')
                              WHEN 'nvarchar' THEN 2
                              ELSE 1
                            END ) -- for unicode
            END
        ELSE 
            SET @StartingPosition = NULL
         
        RETURN @StartingPosition
    END

GO
