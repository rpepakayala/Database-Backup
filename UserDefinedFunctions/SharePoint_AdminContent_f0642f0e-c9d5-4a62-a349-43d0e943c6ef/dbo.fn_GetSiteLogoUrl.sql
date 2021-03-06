/****** Object:  UserDefinedFunction [dbo].[fn_GetSiteLogoUrl]    Script Date: 5/15/2018 12:15:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_GetSiteLogoUrl(@LogoUrl nvarchar(260),@RootWebId uniqueidentifier)
RETURNS nvarchar(260)
AS
BEGIN
    DECLARE @Url nvarchar(260)
    IF @LogoUrl IS NULL
    BEGIN
        SELECT @Url=Webs.SiteLogoUrl
        FROM Webs WITH (NOLOCK)
        WHERE Webs.Id=@RootWebId
    END
    ELSE
    BEGIN
       SET @Url = @LogoUrl 
    END
    RETURN @Url
END

GO
