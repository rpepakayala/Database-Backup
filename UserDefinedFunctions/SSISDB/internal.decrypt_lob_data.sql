/****** Object:  UserDefinedFunction [internal].[decrypt_lob_data]    Script Date: 5/15/2018 12:15:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON





CREATE FUNCTION [internal].[decrypt_lob_data]
( 
    @key_name nvarchar(255), 
    @KEY varbinary(8000),
    @IV varbinary(8000),
    @lob varbinary(max) 
)
RETURNS varbinary(max)
WITH EXECUTE AS 'AllSchemaOwner'
AS
BEGIN
    DECLARE @decrypted_binary varbinary(MAX)
    SET @decrypted_binary = (SELECT [internal].[decrypt_binarydata](@key_name, @KEY,@IV, @lob))
    RETURN @decrypted_binary
END

GO
