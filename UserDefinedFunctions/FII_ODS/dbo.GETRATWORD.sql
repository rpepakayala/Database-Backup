/****** Object:  UserDefinedFunction [dbo].[GETRATWORD]    Script Date: 5/15/2018 12:14:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- Author:  Igor Nikiforov,  Montreal,  EMail: udfunctions@gmail.com 
-- GETRATWORD() User-Defined Function Returns the numeric position of the last (rightmost) occurrence of a word within the character string.
-- GETRATWORD(@cString, @cWord[, @cDelimiters] [, @nOccurrence] [, @nFlags])
-- Returns the numeric position of the last (rightmost) occurrence of a word within the character string.
-- GETRATWORD(), the reverse of the GETATWORD() function, searches the word in @cString
-- starting from the right and moving left, looking for the last occurrence of the word specified in @cWord.
-- Return Value smallint 
-- See Also GETATWORD(), GETOCCURSWORD(), GETNUMWORD(), GETWORDNUM(), GETWORDCOUNT(), GETALLWORDS(), GETALLWORDS2(), WORDTRAN()  User-Defined Functions  
CREATE FUNCTION [dbo].[GETRATWORD]
    (
      @cString NVARCHAR(4000) ,
      @cWord NVARCHAR(4000) ,
      @cDelimiters NVARCHAR(256) = NULL ,
      @nOccurrence SMALLINT = 1 ,
      @nFlags BIT = 0 
    )
RETURNS SMALLINT
AS 
    BEGIN
        DECLARE
            @k SMALLINT ,
            @nEndString SMALLINT ,
            @nLenWord SMALLINT ,
            @BegOfWord SMALLINT ,
            @EndOfWord SMALLINT ,
            @lnOccurrence SMALLINT ,
            @exit BIT ,
            @comparison BIT 

        SELECT
            @BegOfWord = 0 ,
            @EndOfWord = 0 ,
            @lnOccurrence = 0 ,
            @exit = 0 ,
            @cString = ISNULL(@cString, '') ,
            @cDelimiters = ISNULL(@cDelimiters,
                                  NCHAR(32) + NCHAR(9) + NCHAR(10) + NCHAR(13)) , -- if no break string is specified, the function uses spaces, tabs, carriage return and line feed to delimit words.
            @k = 1 + DATALENGTH(@cString)
            / ( CASE SQL_VARIANT_PROPERTY(@cString, 'BaseType')
                  WHEN 'nvarchar' THEN 2
                  ELSE 1
                END ) , -- for unicode,
            @nLenWord = DATALENGTH(@cWord)
            / ( CASE SQL_VARIANT_PROPERTY(@cWord, 'BaseType')
                  WHEN 'nvarchar' THEN 2
                  ELSE 1
                END ) -- for unicode


        WHILE 1 > 0 
            BEGIN
                IF ( @EndOfWord > @BegOfWord )  -- BegOfWord begin of previous word
                    BEGIN  
                        IF ( @nLenWord = ( @EndOfWord - @BegOfWord ) ) -- length of previous word
                            BEGIN
                                IF @nFlags > 0  --  Case insensitive search
                                    SELECT
                                        @comparison = CHARINDEX(LOWER(SUBSTRING(@cString,
                                                              @BegOfWord,
                                                              @nLenWord)) COLLATE Latin1_General_BIN,
                                                              LOWER(@cWord) COLLATE Latin1_General_BIN)
                                ELSE --  Case-sensitive search
                                    SELECT
                                        @comparison = CHARINDEX(SUBSTRING(@cString,
                                                              @BegOfWord,
                                                              @nLenWord) COLLATE Latin1_General_BIN,
                                                              @cWord COLLATE Latin1_General_BIN)
                                IF @comparison = 1 
                                    BEGIN  
                                        SELECT
                                            @lnOccurrence = @lnOccurrence + 1
                                        IF @lnOccurrence = @nOccurrence 
                                            RETURN @BegOfWord
                                    END
                            END 
                    END 
                IF @exit = 1 
                    BREAK
                SELECT
                    @k = @k - 1 -- Skip over the last break character. We know it can not be a word character.
                WHILE CHARINDEX(SUBSTRING(@cString, @k, 1)  COLLATE Latin1_General_BIN,
                                @cDelimiters COLLATE Latin1_General_BIN) > 0
                    AND @k > 0  -- skip  break characters, if any
                    SELECT
                        @k = @k - 1 
                SELECT
                    @EndOfWord = @k + 1
                SELECT
                    @k = @k - 1 -- Skip over the last character in the word. We know it can not be a break character.
                WHILE CHARINDEX(SUBSTRING(@cString, @k, 1)  COLLATE Latin1_General_BIN,
                                @cDelimiters COLLATE Latin1_General_BIN) = 0
                    AND @k > 0  -- skip  the character in the word
                    SELECT
                        @k = @k - 1
                SELECT
                    @BegOfWord = @k + 1 
                IF @k <= 0 
                    SELECT
                        @exit = 1
            END 

        RETURN 0
    END

GO
