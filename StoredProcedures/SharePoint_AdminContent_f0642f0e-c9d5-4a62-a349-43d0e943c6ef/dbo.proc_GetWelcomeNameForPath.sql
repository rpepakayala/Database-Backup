/****** Object:  StoredProcedure [dbo].[proc_GetWelcomeNameForPath]    Script Date: 5/15/2018 12:12:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetWelcomeNameForPath(
    @DocSiteId uniqueidentifier,
    @DocDirName nvarchar(256),
    @DocLeafName nvarchar(128),
    @DocFullUrl nvarchar(260),
    @RedirectUrl nvarchar(260) OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @FolderRedirectUrl nvarchar(260)
    SELECT TOP 1
        @FolderRedirectUrl = Docs.WelcomePageUrl
    FROM
        Docs
    WHERE
        Docs.SiteId = @DocSiteId AND
        Docs.DirName = @DocDirName AND
        Docs.LeafName = @DocLeafName
    IF @FolderRedirectUrl IS NOT NULL AND NOT (DATALENGTH(@FolderRedirectUrl) = 0)
    BEGIN
        IF @DocFullUrl IS NULL
        BEGIN
            SET @DocFullUrl = CASE WHEN (DATALENGTH(@DocDirName) = 0) THEN @DocLeafName WHEN (DATALENGTH(@DocLeafName) = 0) THEN @DocDirName ELSE @DocDirName + N'/' + @DocLeafName END
        END
        DECLARE @RedirDirName nvarchar(256)
        DECLARE @RedirLeafName nvarchar(128)
        DECLARE @DocTypeMask tinyint
        SET @FolderRedirectUrl = CASE WHEN (DATALENGTH(@DocFullUrl) = 0) THEN @FolderRedirectUrl WHEN (DATALENGTH(@FolderRedirectUrl) = 0) THEN @DocFullUrl ELSE @DocFullUrl + N'/' + @FolderRedirectUrl END
        EXEC proc_SplitUrl
            @FolderRedirectUrl,
            @RedirDirName OUTPUT,
            @RedirLeafName OUTPUT
        SET @DocTypeMask = 0
        IF (DATALENGTH(@RedirLeafName) = 0) AND NOT (DATALENGTH(@RedirDirName) = 0)
        BEGIN
            SET @DocTypeMask = 1 | 2
            EXEC proc_SplitUrl
                @RedirDirName,
                @RedirDirName OUTPUT,
                @RedirLeafName OUTPUT
        END
        SET @RedirectUrl =
            CASE WHEN EXISTS(
                SELECT TOP 1
                    Docs.LeafName
                FROM
                    Docs
                WHERE
                    Docs.SiteId = @DocSiteId AND
                    Docs.DirName = @RedirDirName AND
                    Docs.LeafName = @RedirLeafName AND
                    ((@DocTypeMask = 0) OR
                     (Docs.Type & @DocTypeMask) <> 0))
            THEN
                @FolderRedirectUrl
            ELSE
                NULL
            END
    END
    ELSE
    BEGIN
        SET @RedirectUrl = NULL
    END
    RETURN 0

GO
