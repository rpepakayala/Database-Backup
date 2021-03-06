/****** Object:  UserDefinedFunction [dbo].[WORDTRAN]    Script Date: 5/15/2018 12:14:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


-- Author:  Igor Nikiforov,  Montreal,  EMail: udfunctions@gmail.com   
-- WORDTRAN() User-Defined Function
-- WORDTRAN (@cSearched, @cWordSought , [@cWordReplacement] [, @cDelimiters] [, @nStartOccurrence] [, @nNombreOccurrences] [, @nFlags])
-- Searches a character string for occurrences of a first word, and then replaces each occurrence with a second word.
-- Return Values nvarchar(4000)
-- Parameters
-- @cSearched Specifies the character string that is searched.
-- @cWordSought Specifies the word that is searched for in @cSearched.
-- @cWordReplacement Specifies the word that replaces every occurrence of @cWordSought  in @cSearched.
-- If you omit @cWordReplacement, every occurrence of @cWordSought is replaced with the empty string. 
-- @cDelimiters Optional. Specifies one or more optional characters used to separate words in cString. The default delimiters are space, tab, carriage return, and line feed.
-- The maximum length of lcDelimiters is 256.
-- Note that WORDTRAN() uses each of the characters in @cDelimiters as individual delimiters, not the entire string as a single delimiter.
-- @nStartOccurrence Specifies which occurrence of @cWordSought is the first to be replaced. For example, if @nStartOccurrence is 4, replacement begins with the fourth occurrence of @cWordSought in @cSearched and the first three occurrences of @cWordSought remain unchanged.
-- The occurrence where replacement begins defaults to the first occurrence of @cWordSought if you omit @nStartOccurrence. 
-- @nNombreOccurrences Specifies the number of occurrences of @cWordSought to replace.
-- If you omit @nNombreOccurrences, all occurrences of @cWordSought, starting with the occurrence specified with @nStartOccurrence, are replaced. 
-- @nFlags Specifies the case-sensitivity of a search according to the following values:
-- -----------------------------------------------------------------------------------------
-- @nFlags Description 
--  0 (default) Search is case-sensitive, replace is with exact @cWordReplacement word.
--  1 Search is case-insensitive, replace is with exact @cWordReplacement word. 
--  2 Search is case-sensitive; replace is with the case of @cWordReplacement changed to match the case of the word found. The case of @cWordReplacement will only be changed if the word found is all uppercase, lowercase, or proper case. 
--  3 Search is case-insensitive; replace is with the case of @cWordReplacement changed to match the case of the word found. The case of @cWordReplacement will only be changed if the word found is all uppercase, lowercase, or proper case. 
-- -----------------------------------------------------------------------------------------
--  Remarks
--  You can specify where the replacement begins and how many replacements are made.
--  WORDTRAN( ) returns the resulting character string. 
--  Specify default for optional parameters you want to skip over if you just need to specify the @nFlags setting.
-- Examples
-- select dbo.WORDTRAN('ABC DEF', 'ABC', 'XYZ', default, default, default, default)       -- Displays  XYZ DEF
-- select dbo.WORDTRAN('ABC DEF', 'ABC', '123', default, -1, -1, default)                 -- Displays  123 DEF
-- select dbo.WORDTRAN('ABC DEF ABC GHJabcQWE', 'ABC', Space(1), default, default, 1, 0)  -- Displays    DEF ABC GHJabcQWE
-- select dbo.WORDTRAN('ABC DEF ABC GHJabcQWE', 'ABC', Space(1), default, default, 1, 0)  -- Displays    DEF ABC GHJabcQWE
-- select dbo.WORDTRAN('ABC DEF ABC GHJabcQWE', 'ABC', 'XYZ', Space(1), 2, 1, 1)          -- Displays  ABC DEF XYZ GHJabcQWE
-- select dbo.WORDTRAN('ABC DEF ABC GHJabcQWE', 'ABC', 'XYZ', Space(1), 2, 3, 1)          -- Displays  ABC DEF XYZ GHJabcQWE
-- select dbo.WORDTRAN('ABC DEF ABC GHJabcQWE', 'ABC', 'XYZ', Space(1), 2, 1, 2)          -- Displays  ABC DEF XYZ GHJabcQWE
-- select dbo.WORDTRAN('ABC DEF ABC GHJabcQWE', 'ABC', 'XYZ', Space(1), 2, 3, 2)          -- Displays  ABC DEF XYZ GHJabcQWE
-- select dbo.WORDTRAN('ABC DEF ABC GHJabcQWE', 'ABC', 'xyZ', Space(1), 2, 1, 2)          -- Displays  ABC DEF XYZ GHJabcQWE
-- select dbo.WORDTRAN('ABC DEF ABC GHJabcQWE', 'ABC', 'xYz', Space(1), 2, 3, 2)          -- Displays  ABC DEF XYZ GHJabcQWE
-- select dbo.WORDTRAN('ABC DEF Abc CGHJAbcQWE', 'Aab', 'xyZ', Space(1), 2, 1, 2 )        -- Displays  ABC DEF Abc CGHJAbcQWE
-- select dbo.WORDTRAN('abc DEF abc GHJabcQWE', 'abc', 'xYz', Space(1), 3, 2, 0)          -- Displays  abc DEF abc GHJabcQWE
-- select dbo.WORDTRAN('ABC DEF Abc CGHJAbcQWE', 'Aab', 'xyZ', Space(1), 2, 1, 3)         -- Displays  ABC DEF Abc CGHJAbcQWE
-- select dbo.WORDTRAN('ABC DEF Abc GHJabcQWE', 'abc', 'xYz', Space(1), 1, 3, 3)          -- Displays  XYZ DEF Xyz GHJabcQWE
-- Sometime the search for substring from a string will return the incorrect result,
-- it is necessary to search for the word in the string.
-- declare @lcAdmissibleCodes varchar(100), @lcCodeforReplacing varchar(100), @lcNewCode varchar(100)
-- select @lcAdmissibleCodes = 'W,WN,IR,IU,I', @lcCodeforReplacing = 'I', @lcNewCode = 'A'
-- select dbo.STRTRAN(@lcAdmissibleCodes, @lcCodeforReplacing, @lcNewCode, default, default, default)    -- Displays  W,WN,AR,AU,A
-- select dbo.WORDTRAN(@lcAdmissibleCodes, @lcCodeforReplacing, @lcNewCode, ','+Space(1), default, default, default ) --  Displays  W,WN,IR,IU,A
-- select @lcCodeforReplacing = 'IR,'
-- select dbo.WORDTRAN(@lcAdmissibleCodes, @lcCodeforReplacing, @lcNewCode, default, default, default, default)    --  Displays  W,WN,IR,IU,I
-- select dbo.WORDTRAN(@lcAdmissibleCodes, @lcCodeforReplacing, @lcNewCode, ','+Space(1), default, default, default )  --  Displays  W,WN,IR,IU,I
-- See Also STRTRAN(), GETATWORD(), GETRATWORD(), GETOCCURSWORD(), GETNUMWORD(), GETWORDNUM(), GETWORDCOUNT(), GETALLWORDS(), GETALLWORDS2() 
CREATE FUNCTION [dbo].[WORDTRAN]
    (
      @cSearched NVARCHAR(4000) ,
      @cWordSought NVARCHAR(4000) ,
      @cWordReplacement NVARCHAR(4000) = N'' ,
      @cDelimiters NVARCHAR(256) ,
      @nStartOccurrence SMALLINT = -1 ,
      @nNumberOfOccurrences SMALLINT = -1 ,
      @nFlags TINYINT = 0
    )
RETURNS NVARCHAR(4000)
AS 
    BEGIN 
        IF NOT @nFlags IN ( 0, 2, 1, 3 ) 
            RETURN  'Error, seventh parameter must be 0, 1, 2, 3 ! '


        DECLARE
            @cStrWordReplaced NVARCHAR(4000) ,
            @cNewWordReplacement NVARCHAR(4000) ,
            @LenWordReplacement SMALLINT ,
            @EndPrevWord SMALLINT

        DECLARE
            @k SMALLINT ,
            @nEndString SMALLINT ,
            @nLenWord SMALLINT ,
            @BegOfWord SMALLINT ,
            @lnOccurrence SMALLINT ,
            @exit BIT ,
            @comparison BIT 

        SELECT
            @EndPrevWord = 1 ,
            @BegOfWord = 1 ,
            @lnOccurrence = 0 ,
            @exit = 0 ,
            @cSearched = ISNULL(@cSearched, '') ,
            @k = 0 ,
            @cDelimiters = ISNULL(@cDelimiters,
                                  NCHAR(32) + NCHAR(9) + NCHAR(10) + NCHAR(13)) , -- if no break string is specified, the function uses spaces, tabs, carriage return and line feed to delimit words.
            @nEndString = 1 + DATALENGTH(@cSearched)
            / ( CASE SQL_VARIANT_PROPERTY(@cSearched, 'BaseType')
                  WHEN 'nvarchar' THEN 2
                  ELSE 1
                END ) , -- for unicode,
            @nLenWord = DATALENGTH(@cWordSought)
            / ( CASE SQL_VARIANT_PROPERTY(@cWordSought, 'BaseType')
                  WHEN 'nvarchar' THEN 2
                  ELSE 1
                END ) , -- for unicode
            @LenWordReplacement = DATALENGTH(@cWordReplacement)
            / ( CASE SQL_VARIANT_PROPERTY(@cWordReplacement, 'BaseType')
                  WHEN 'nvarchar' THEN 2
                  ELSE 1
                END )

        SELECT
            @cNewWordReplacement = @cWordReplacement ,
            @cStrWordReplaced = N''

        IF @nStartOccurrence = -1 
            SELECT
                @nStartOccurrence = 1

        IF @nFlags = 2
            AND @LenWordReplacement > 0 
            SELECT
                @cNewWordReplacement = CASE dbo.FWHATISCASE(@cWordSought)
                                         WHEN 'U'
                                         THEN UPPER(@cWordReplacement)
                                         WHEN 'L'
                                         THEN LOWER(@cWordReplacement)
                                         WHEN 'P'
                                         THEN UPPER(LEFT(@cWordReplacement, 1))
                                              + LOWER(SUBSTRING(@cWordReplacement,
                                                              2,
                                                              @LenWordReplacement
                                                              - 1))
                                         ELSE @cWordReplacement
                                       END

        WHILE 1 > 0 
            BEGIN
                IF ( @k > @BegOfWord )  -- BegOfWord begin of word
                    BEGIN  
                        IF ( @nLenWord = ( @k - @BegOfWord ) ) -- length of word
                            BEGIN
                                IF @nFlags IN ( 1, 3 )  --  Case insensitive search
                                    SELECT
                                        @comparison = CHARINDEX(LOWER(SUBSTRING(@cSearched,
                                                              @BegOfWord,
                                                              @nLenWord)) COLLATE Latin1_General_BIN,
                                                              LOWER(@cWordSought) COLLATE Latin1_General_BIN)
                                ELSE --  Case-sensitive search
                                    SELECT
                                        @comparison = CHARINDEX(SUBSTRING(@cSearched,
                                                              @BegOfWord,
                                                              @nLenWord) COLLATE Latin1_General_BIN,
                                                              @cWordSought COLLATE Latin1_General_BIN)
                                IF @comparison = 1 
                                    BEGIN  
                                        SELECT
                                            @lnOccurrence = @lnOccurrence + 1
                                        IF @lnOccurrence >= @nStartOccurrence
                                            AND ( @nNumberOfOccurrences = -1
                                                  OR @lnOccurrence < @nStartOccurrence
                                                  + @nNumberOfOccurrences
                                                ) 
                                            BEGIN  
                                                IF @nFlags = 3
                                                    AND @LenWordReplacement > 0 
                                                    SELECT
                                                        @cNewWordReplacement = CASE dbo.FWHATISCASE(SUBSTRING(@cSearched,
                                                              @BegOfWord,
                                                              @nLenWord))
                                                              WHEN 'U'
                                                              THEN UPPER(@cWordReplacement)
                                                              WHEN 'L'
                                                              THEN LOWER(@cWordReplacement)
                                                              WHEN 'P'
                                                              THEN UPPER(LEFT(@cWordReplacement,
                                                              1))
                                                              + LOWER(SUBSTRING(@cWordReplacement,
                                                              2,
                                                              @LenWordReplacement
                                                              - 1))
                                                              ELSE @cWordReplacement
                                                              END
                                                SELECT
                                                    @cStrWordReplaced = @cStrWordReplaced
                                                    + SUBSTRING(@cSearched,
                                                              @EndPrevWord,
                                                              @BegOfWord
                                                              - @EndPrevWord)
                                                    + @cNewWordReplacement
                                                SELECT
                                                    @EndPrevWord = @k  -- end of previous word
                                            END
                                    END
                            END 
                    END 
                IF @exit = 1 
                    BEGIN 
                        IF @EndPrevWord > 1 
                            SELECT
                                @cSearched = @cStrWordReplaced
                                + SUBSTRING(@cSearched, @EndPrevWord,
                                            @nEndString - @EndPrevWord)
                        BREAK
                    END
                SELECT
                    @k = @k + 1 -- Skip over the first break character.
                WHILE CHARINDEX(SUBSTRING(@cSearched, @k, 1)  COLLATE Latin1_General_BIN,
                                @cDelimiters COLLATE Latin1_General_BIN) > 0
                    AND @nEndString > @k  -- skip  break characters, if any
                    SELECT
                        @k = @k + 1 
                SELECT
                    @BegOfWord = @k 
                SELECT
                    @k = @k + 1 -- Skip over the first character in the word. We know it can not be a break character.
                WHILE CHARINDEX(SUBSTRING(@cSearched, @k, 1)  COLLATE Latin1_General_BIN,
                                @cDelimiters COLLATE Latin1_General_BIN) = 0
                    AND @nEndString > @k  -- skip  the character in the word
                    SELECT
                        @k = @k + 1 
                IF @k >= @nEndString 
                    SELECT
                        @exit = 1
            END 
        RETURN  @cSearched
    END

GO
