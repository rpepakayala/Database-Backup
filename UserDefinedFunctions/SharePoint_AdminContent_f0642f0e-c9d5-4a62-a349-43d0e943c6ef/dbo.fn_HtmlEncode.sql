/****** Object:  UserDefinedFunction [dbo].[fn_HtmlEncode]    Script Date: 5/15/2018 12:15:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_HtmlEncode(
    @Value nvarchar(1023),
    @PreserveNewLine bit)
RETURNS nvarchar(4000)
AS
BEGIN
    DECLARE @Result nvarchar(4000)
    SELECT @Result = @Value
    IF @Result IS NOT NULL AND LEN(@Result) > 0
    BEGIN
        SELECT @Result = REPLACE(@Result, N'&', N'&amp;')
        SELECT @Result = REPLACE(@Result, N'<', N'&lt;')
        SELECT @Result = REPLACE(@Result, N'>', N'&gt;')
        SELECT @Result = REPLACE(@Result, N'''', N'&#39;')
        SELECT @Result = REPLACE(@Result, N'"', N'&quot;')
        IF @PreserveNewLine = 1
            SELECT @Result = REPLACE(@Result, CHAR(10), CHAR(10) + N'<br>')
    END
    RETURN @Result
END

GO
