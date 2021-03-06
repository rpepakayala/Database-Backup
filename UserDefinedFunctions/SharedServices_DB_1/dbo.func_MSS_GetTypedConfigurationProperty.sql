/****** Object:  UserDefinedFunction [dbo].[func_MSS_GetTypedConfigurationProperty]    Script Date: 5/15/2018 12:15:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.func_MSS_GetTypedConfigurationProperty
(
    @Name NVARCHAR(64),
    @Type NVARCHAR(100),
    @StringValue NTEXT
)
RETURNS SQL_VARIANT
AS
 BEGIN
  IF (@Type IS NULL) OR (@Type = N'null')
   RETURN NULL

  IF (@Name = N'indexLocationsOnQueryServers') AND (@Type != N'list')
   RETURN NULL

  DECLARE @nvarcharValue NVARCHAR(4000)

  SET @nvarcharValue = CONVERT(NVARCHAR(4000), @StringValue)

  IF @Type = N'int'
   RETURN CONVERT(int, @nvarcharValue)

  IF @Type = N'float'
   RETURN CONVERT(float, @nvarcharValue)

  IF @Type = N'boolean'
   IF @nvarcharValue = N'true'
    RETURN CONVERT(BIT, 1)
   ELSE
    RETURN CONVERT(BIT, 0)

  RETURN @nvarcharValue
 END


GO
