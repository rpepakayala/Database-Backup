/****** Object:  UserDefinedFunction [internal].[decrypt_binarydata]    Script Date: 5/15/2018 12:15:13 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE FUNCTION [internal].[decrypt_binarydata](@algorithmName [nvarchar](255), @key [varbinary](8000), @IV [varbinary](8000), @binary_value [varbinary](max))
RETURNS [varbinary](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [ISSERVER].[Microsoft.SqlServer.IntegrationServices.Server.Security.CryptoGraphy].[DecryptBinaryData]
GO
