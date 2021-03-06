/****** Object:  StoredProcedure [dbo].[proc_UrlToWebUrlOutput]    Script Date: 5/15/2018 12:13:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UrlToWebUrlOutput(
    @WebSiteId uniqueidentifier,
    @Url nvarchar(260),
    @@OutWebDirName nvarchar(256) OUTPUT,
    @@OutWebLeafName nvarchar(128) OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @WebDirName nvarchar(256)
    DECLARE @WebLeafName nvarchar(128)
    SET @WebDirName = @Url
    WHILE NOT((DATALENGTH(@WebDirName) = 0) AND (DATALENGTH(@WebLeafName) = 0))
    BEGIN
        EXEC proc_SplitUrl @WebDirName, @WebDirName OUTPUT,
            @WebLeafName OUTPUT
        IF EXISTS(SELECT
            *
            FROM
                Docs
            WHERE
                SiteId = @WebSiteId AND
                DirName = @WebDirName AND
                LeafName = @WebLeafName AND
                Type = 2)
        BEGIN
            SET @@OutWebDirName = @WebDirName
            SET @@OutWebLeafName = @WebLeafName
            RETURN 0
        END
    END
    SET @@OutWebDirName = N''
    SET @@OutWebLeafName = N''
    IF NOT EXISTS (SELECT * FROM Sites (NOLOCK) WHERE Id = @WebSiteId)
    BEGIN
        RETURN 1168
    END
    RETURN 0

GO
