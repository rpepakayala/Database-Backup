/****** Object:  UserDefinedFunction [dbo].[fn_IsValidUniqueIdentifier]    Script Date: 5/15/2018 12:15:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/*
 * Object: fn_IsValidUniqueIdentifier
 * --------------------------------------------------------------
 * Updated By: Jeremiah Nazaruk
 * Source : Pragmatic Works - BI xPress Auditing Framework 47
 * Created On : 6/13/2013
 * Purpose : 
 *     - Determines if the string input can be converted into a UNIQUEIDENTIFIER. Returns a BIT value of 1 or 0 (True or False).
 * --------------------------------------------------------------
*/
CREATE FUNCTION [dbo].[fn_IsValidUniqueIdentifier](@input NVARCHAR(MAX))
    RETURNS BIT
    WITH SCHEMABINDING
AS
BEGIN
    DECLARE @isValidGuid BIT

    SET @input = UPPER(LTRIM(RTRIM(REPLACE(REPLACE(REPLACE(@input, '-', ''), '{', ''), '}', ''))))

    IF (@input LIKE REPLICATE('[0-9a-fA-F]', 32) COLLATE Latin1_General_100_BIN)
    BEGIN
        SET @isValidGuid = 1
    END
    ELSE
    BEGIN
        SET @isValidGuid = 0
    END

    RETURN @isValidGuid
END

GO
