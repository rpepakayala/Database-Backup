/****** Object:  UserDefinedFunction [dbo].[GETALLWORDS]    Script Date: 5/15/2018 12:15:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

 -- Author:  Igor Nikiforov,  Montreal,  EMail: udfunctions@gmail.com 
 -- GETALLWORDS() User-Defined Function Inserts the words from a string into the table.
 -- GETALLWORDS(@cString[, @cDelimiters])
 -- Parameters
 -- @cString  nvarchar(4000) - Specifies the string whose words will be inserted into the table @GETALLWORDS. 
 -- @cDelimiters nvarchar(256) - Optional. Specifies one or more optional characters used to separate words in @cString.
 -- The default delimiters are space, tab, carriage return, and line feed. Note that GETALLWORDS( ) uses each of the characters in @cDelimiters as individual delimiters, not the entire string as a single delimiter. 
 -- Return Value table 
 -- Remarks GETALLWORDS() by default assumes that words are delimited by spaces or tabs. If you specify another character as delimiter, this function ignores spaces and tabs and uses only the specified character.
 -- Example
 -- declare @cString nvarchar(4000)
 -- set @cString = 'The default delimiters are space, tab, carriage return, and line feed. If you specify another character as delimiter, this function ignores spaces and tabs and uses only the specified character.'
 -- select * from  dbo.GETALLWORDS(@cString, default)     
 -- select * from dbo.GETALLWORDS(@cString, ' ,.')              
 -- See Also GETWORDNUM(), GETWORDCOUNT(), GETNUMWORD(), GETOCCURSWORD(),  GETATWORD(), GETRATWORD()  User-Defined Functions   
CREATE FUNCTION GETALLWORDS
    (
      @cString NVARCHAR(4000) ,
      @cDelimiters NVARCHAR(256)
    )
RETURNS @GETALLWORDS TABLE
    (
      WORDNUM SMALLINT ,
      WORD NVARCHAR(4000) ,
      STARTOFWORD SMALLINT ,
      LENGTHOFWORD SMALLINT
    )
    BEGIN
        DECLARE
            @k SMALLINT ,
            @wordcount SMALLINT ,
            @nEndString SMALLINT ,
            @BegOfWord SMALLINT ,
            @flag BIT

        SELECT
            @k = 1 ,
            @wordcount = 1 ,
            @BegOfWord = 1 ,
            @flag = 0 ,
            @cString = ISNULL(@cString, '') ,
            @cDelimiters = ISNULL(@cDelimiters,
                                  NCHAR(32) + NCHAR(9) + NCHAR(10) + NCHAR(13)) , -- if no break string is specified, the function uses spaces, tabs, carriage return and line feed to delimit words.
            @nEndString = 1 + DATALENGTH(@cString)
            / ( CASE SQL_VARIANT_PROPERTY(@cString, 'BaseType')
                  WHEN 'nvarchar' THEN 2
                  ELSE 1
                END ) -- for unicode

        WHILE 1 > 0 
            BEGIN
                IF @k - @BegOfWord > 0 
                    BEGIN
                        INSERT  INTO @GETALLWORDS
                                ( WORDNUM ,
                                  WORD ,
                                  STARTOFWORD ,
                                  LENGTHOFWORD
                                )
                        VALUES
                                ( @wordcount ,
                                  SUBSTRING(@cString, @BegOfWord,
                                            @k - @BegOfWord) ,
                                  @BegOfWord ,
                                  @k - @BegOfWord 
                                )   -- previous word
                        SELECT
                            @wordcount = @wordcount + 1 ,
                            @BegOfWord = @k 
                    END   
                IF @flag = 1 
                    BREAK

                WHILE CHARINDEX(SUBSTRING(@cString, @k, 1)  COLLATE Latin1_General_BIN,
                                @cDelimiters COLLATE Latin1_General_BIN) > 0
                    AND @nEndString > @k  -- skip  break characters, if any
                    SELECT
                        @k = @k + 1 ,
                        @BegOfWord = @BegOfWord + 1
                WHILE CHARINDEX(SUBSTRING(@cString, @k, 1)  COLLATE Latin1_General_BIN,
                                @cDelimiters COLLATE Latin1_General_BIN) = 0
                    AND @nEndString > @k  -- skip  the character in the word
                    SELECT
                        @k = @k + 1 
                IF @k >= @nEndString 
                    SELECT
                        @flag = 1
            END 
        RETURN 
    END

GO
