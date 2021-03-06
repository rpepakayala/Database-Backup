/****** Object:  StoredProcedure [dbo].[proc_LoadTheme]    Script Date: 5/15/2018 12:12:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_LoadTheme(
    @WebSiteId uniqueidentifier,
    @ThemesDir nvarchar(256),      
    @ThemeName nvarchar(128),       
    @GraphicCSS nvarchar(128),      
    @ColorCSS nvarchar(128),        
    @ExtCSS nvarchar(128),        
    @NeedThemesInf bit)
AS
    SET NOCOUNT ON
    DECLARE @ThemeRootDir nvarchar(256)
    SET @ThemeRootDir = @ThemesDir + N'/' + @ThemeName
    IF EXISTS (SELECT
        NULL
        FROM
            Docs
        WHERE
            SiteId = @WebSiteId AND DirName = @ThemeRootDir AND
            LeafName = (@ThemeName + N'.utf8') AND
            Level = 1)
    BEGIN
        SELECT
            Docs.LeafName,
            Docs.SetupPathVersion,
            Docs.SetupPath,
            Docs.SetupPathUser,
            DocStreams.Content
        FROM
            Docs 
        LEFT OUTER JOIN 
            DocStreams
        ON
            Docs.SiteId = DocStreams.SiteId AND
            Docs.ParentId = DocStreams.ParentId AND
            Docs.Id = DocStreams.Id AND
            Docs.Level = DocStreams.Level
        WHERE
            Docs.SiteId = @WebSiteId AND Docs.DirName = @ThemeRootDir AND
            (Docs.LeafName = N'theme.css' OR
                Docs.LeafName = N'custom.css' OR
                Docs.LeafName = (@ThemeName + N'.utf8') OR
                Docs.LeafName = @GraphicCSS OR
                Docs.LeafName = @ColorCSS OR
                Docs.LeafName LIKE @ExtCSS) AND
            Docs.Level = 1
    END
    ELSE
    BEGIN
        SELECT
            Docs.LeafName,
            Docs.SetupPathVersion,
            Docs.SetupPath,
            Docs.SetupPathUser,
            DocStreams.Content
        FROM
            Docs 
        LEFT OUTER JOIN 
            DocStreams
        ON
            Docs.SiteId = DocStreams.SiteId AND
            Docs.ParentId = DocStreams.ParentId AND
            Docs.Id = DocStreams.Id AND
            Docs.Level = DocStreams.Level
        WHERE
            Docs.SiteId = @WebSiteId AND Docs.DirName = @ThemeRootDir AND
            (Docs.LeafName = N'theme.css' OR
                Docs.LeafName = N'custom.css' OR
                Docs.LeafName = (@ThemeName + N'.inf') OR
                Docs.LeafName = @GraphicCSS OR
                Docs.LeafName = @ColorCSS OR
                Docs.LeafName LIKE @ExtCSS) AND
                Docs.Level = 1
    END
    IF @NeedThemesInf = 1
    BEGIN
        SELECT
            Docs.LeafName,
            Docs.SetupPathVersion,
            Docs.SetupPath,
            Docs.SetupPathUser,
            DocStreams.Content
        FROM
            Docs 
        LEFT OUTER JOIN 
            DocStreams
        ON
            Docs.SiteId = DocStreams.SiteId AND
            Docs.ParentId = DocStreams.ParentId AND
            Docs.Id = DocStreams.Id AND
            Docs.Level = DocStreams.Level
        WHERE
            Docs.SiteId = @WebSiteId AND
            Docs.DirName = @ThemesDir AND
            Docs.LeafName = N'themes.inf' AND
            Docs.Level = 1
        IF @@ROWCOUNT <> 1
        BEGIN
            RETURN 1    
        END
    END
    RETURN 0

GO
