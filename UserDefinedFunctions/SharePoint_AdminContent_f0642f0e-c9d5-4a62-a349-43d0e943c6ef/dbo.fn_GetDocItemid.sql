/****** Object:  UserDefinedFunction [dbo].[fn_GetDocItemid]    Script Date: 5/15/2018 12:15:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_GetDocItemid(@DirName nvarchar(260))
RETURNS int
AS
BEGIN
    DECLARE @strItemId nvarchar(260)
    DECLARE @iSlash int
    SET @iSlash = CHARINDEX(N'/', REVERSE(@DirName))
    SET @strItemId = SUBSTRING(@DirName, LEN(@DirName) - @iSlash + 2, @iSlash - 1)
    return CONVERT(int, @strItemId)
END

GO
