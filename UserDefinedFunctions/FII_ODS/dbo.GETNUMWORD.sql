/****** Object:  UserDefinedFunction [dbo].[GETNUMWORD]    Script Date: 5/15/2018 12:14:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

 -- Author:  Igor Nikiforov,  Montreal,  EMail: udfunctions@gmail.com 
 -- GETNUMWORD() User-Defined Function Returns the index position of a word in a string.
 -- GETNUMWORD(@cString, @cWord[, @cDelimiters] [, @nOccurrence] [, @nFlags])
 -- Return Value smallint 
 -- Returns the index position of a word in a string.
 -- If @cString don't contain the word cWord, GETNUMWORD( ) returns 0.
 -- This function may be very useful to know if a word exists in a string or not.
 -- Parameters
 -- @cString nvarchar(4000) - Specifies the string to be evaluated
 -- @cWord nvarchar(4000) - Specifies the word to search for in cString.
 -- @cDelimiters nvarchar(256) - Optional. Specifies one or more optional characters used to separate words in cString.
 -- The default delimiters are space, tab, carriage return, and line feed.
 -- Note that GETNUMWORD( ) uses each of the characters in cDelimiters as individual delimiters, not the entire string as a single delimiter.
 -- @nOccurrence Specifies which occurrence, first, second, third, and so on, of cWord to search for in cString.
 -- By default, GETNUMWORD( ) searches for the first occurrence of cWord (nOccurrence = 1).
 -- @nFlags  Specifies Case-sensitive search criteria to apply to this function. Valid values are 0 (the default) and 1.
 -- 0 Case-sensitive search
 -- 1 Case insensitive search
 --  select dbo.GETNUMWORD('O Canada! Our home and native land!', 'Canada!', default, 1, 0)  --  Displays 2
 -- Sometime the search for substring from a string will return the incorrect result,
 -- it is necessary to search for the word in the string.
 -- declare @lcAdmissibleCodes nvarchar(4000), @lcCodeforChecking  nvarchar(4000)
 -- set @lcAdmissibleCodes = 'W,WN,IR,IU'
 -- set @lcCodeforChecking = 'I'
 -- select charindex(@lcCodeforChecking, @lcAdmissibleCodes)     -- Displays 6
 -- select dbo.GETNUMWORD(@lcAdmissibleCodes, @lcCodeforChecking, ',' + Space(1), default, default) -- Displays  0
 -- set @lcCodeforChecking = 'IR,'
 -- select charindex(@lcCodeforChecking, @lcAdmissibleCodes)      -- Displays 6
 -- select dbo.GETNUMWORD(@lcAdmissibleCodes, @lcCodeforChecking, ',' + Space(1), default, default) -- Displays  0
 -- set @lcAdmissibleCodes = 'W,WN,IR,IU,WN,DS'
 -- set @lcCodeforChecking = 'WN'
 -- select dbo.GETNUMWORD(@lcAdmissibleCodes, @lcCodeforChecking, ',' + Space(1), 2, default) -- Displays  5
 -- See Also GETWORDNUM(), GETWORDCOUNT(), GETALLWORDS(), GETNUMWORD(), GETOCCURSWORD(),  GETATWORD(), GETRATWORD()  User-Defined Functions  
CREATE FUNCTION [dbo].[GETNUMWORD]
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
            @wordcount SMALLINT ,
            @BegOfWord SMALLINT ,
            @lnOccurrence SMALLINT ,
            @exit BIT ,
            @comparison BIT 

        SELECT
            @BegOfWord = 1 ,
            @lnOccurrence = 0 ,
            @exit = 0 ,
            @cString = ISNULL(@cString, '') ,
            @k = 0 ,
            @wordcount = 0 ,
            @cDelimiters = ISNULL(@cDelimiters,
                                  NCHAR(32) + NCHAR(9) + NCHAR(10) + NCHAR(13)) , -- if no break string is specified, the function uses spaces, tabs, carriage return and line feed to delimit words.
            @nEndString = 1 + DATALENGTH(@cString)
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
                IF ( @k > @BegOfWord )  -- BegOfWord begin of previous word
                    BEGIN  
                        SELECT
                            @wordcount = @wordcount + 1
                        IF ( @nLenWord = ( @k - @BegOfWord ) ) -- length of previous word
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
                                            RETURN @wordcount
                                    END
                            END 
                    END 
                IF @exit = 1 
                    BREAK
                SELECT
                    @k = @k + 1 -- Skip over the first break character.
                WHILE CHARINDEX(SUBSTRING(@cString, @k, 1)  COLLATE Latin1_General_BIN,
                                @cDelimiters COLLATE Latin1_General_BIN) > 0
                    AND @nEndString > @k  -- skip  break characters, if any
                    SELECT
                        @k = @k + 1 
                SELECT
                    @BegOfWord = @k 
                SELECT
                    @k = @k + 1 -- Skip over the first character in the word. We know it can not be a break character.
                WHILE CHARINDEX(SUBSTRING(@cString, @k, 1)  COLLATE Latin1_General_BIN,
                                @cDelimiters COLLATE Latin1_General_BIN) = 0
                    AND @nEndString > @k  -- skip  the character in the word
                    SELECT
                        @k = @k + 1 
                IF @k >= @nEndString 
                    SELECT
                        @exit = 1
            END 

        RETURN 0
    END

GO
