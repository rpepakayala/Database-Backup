/****** Object:  UserDefinedFunction [dbo].[AT2]    Script Date: 5/15/2018 12:14:59 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- Author:  Igor Nikiforov,  Montreal,  EMail: udfunctions@gmail.com   
-- AT2() User-Defined Function 
-- Returns the beginning numeric position of the first occurrence of a character expression within another character expression, counting from the leftmost character.
-- (excluding  overlaps)
-- AT2(@cSearchExpression, @cExpressionSearched [, @nOccurrence]) Return Values smallint 
-- Parameters
-- @cSearchExpression nvarchar(4000) Specifies the character expression that AT2( ) searches for in @cExpressionSearched. 
-- @cExpressionSearched nvarchar(4000) Specifies the character expression @cSearchExpression searches for. 
-- @nOccurrence smallint Specifies which occurrence (first, second, third, and so on) of @cSearchExpression is searched for in @cExpressionSearched. By default, AT2() searches for the first occurrence of @cSearchExpression (@nOccurrence = 1). Including @nOccurrence lets you search for additional occurrences of @cSearchExpression in @cExpressionSearched. AT2( ) returns 0 if @nOccurrence is greater than the number of times @cSearchExpression occurs in @cExpressionSearched. 
-- Remarks
-- AT2() searches the second character expression for the first occurrence of the first character expression. It then returns an integer indicating the position of the first character in the character expression found. If the character expression is not found, AT2() returns 0. The search performed by AT2() is case-sensitive.
-- AT2 is nearly similar to a function Oracle PL/SQL INSTR
-- Example
-- declare @gcString nvarchar(4000), @gcFindString nvarchar(4000)
-- select @gcString = 'Now is the time for all good men', @gcFindString = 'is the'
-- select dbo.AT2(@gcFindString, @gcString, default)  -- Displays 5
-- set @gcFindString = 'IS'
-- select dbo.AT2(@gcFindString, @gcString, default)  -- Displays 0, case-sensitive 
-- select @gcString = 'goood men', @gcFindString = 'oo'
-- select dbo.AT2(@gcFindString, @gcString, 1)  -- Displays 2
-- select dbo.AT2(@gcFindString, @gcString, 2)  -- Displays 0, excluding  overlaps
-- See Also AT(), ATC(), ATC2()  User-Defined Function 
CREATE FUNCTION AT2
    (
      @cSearchExpression NVARCHAR(4000) ,
      @cExpressionSearched NVARCHAR(4000) ,
      @nOccurrence SMALLINT = 1 
    )
RETURNS SMALLINT
AS 
    BEGIN
        DECLARE @LencSearchExpression SMALLINT
        SELECT
            @LencSearchExpression = DATALENGTH(@cSearchExpression)
            / ( CASE SQL_VARIANT_PROPERTY(@cSearchExpression, 'BaseType')
                  WHEN 'nvarchar' THEN 2
                  ELSE 1
                END ) -- for unicode

        IF @nOccurrence > 0 
            BEGIN
                DECLARE
                    @i SMALLINT ,
                    @StartingPosition SMALLINT
                SELECT
                    @i = 0 ,
                    @StartingPosition = -1 - @LencSearchExpression
                WHILE @StartingPosition <> 0
                    AND @nOccurrence > @i 
                    SELECT
                        @i = @i + 1 ,
                        @StartingPosition = CHARINDEX(@cSearchExpression COLLATE Latin1_General_BIN,
                                                      @cExpressionSearched COLLATE Latin1_General_BIN,
                                                      @StartingPosition
                                                      + @LencSearchExpression)
            END
        ELSE 
            SET @StartingPosition = NULL
        RETURN @StartingPosition
    END

GO
