/****** Object:  StoredProcedure [dbo].[proc_SecFixAttachments]    Script Date: 5/15/2018 12:12:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecFixAttachments(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @ListBaseType int,
    @Url nvarchar(260),
    @OldScopeId uniqueidentifier,
    @NewScopeId uniqueidentifier)
AS
    SET NOCOUNT ON
    IF (@ListId IS NULL OR @ListBaseType = 1)
        RETURN 0
    DECLARE @UrlDirName nvarchar(256)
    DECLARE @UrlLeafName nvarchar(128)
    DECLARE @ListRootUrl nvarchar(260)
    DECLARE @AttachmentSubfolderUrl nvarchar(260)
    DECLARE @UrlLike nvarchar(1024)
    SELECT 
        @ListRootUrl = CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END,
        @AttachmentSubfolderUrl = CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END + N'/'+ N'Attachments'
    FROM 
        Docs, Lists
    WHERE
        Docs.SiteId         = @SiteId AND
        Lists.tp_WebId      = @WebId AND
        Lists.tp_ID         = @ListId AND
        Lists.tp_RootFolder = Docs.Id
    IF (@ListRootUrl = @Url)
        RETURN 0
    EXEC proc_SplitUrl @Url, @UrlDirName OUTPUT, @UrlLeafName OUTPUT
    EXEC proc_EscapeForLike @Url, @UrlLike OUTPUT
    DECLARE @DocType tinyint
    DECLARE @DoclibRowId int
    SELECT 
        @DocType = Type,
        @DoclibRowId = DoclibRowId
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @UrlDirName AND
        LeafName = @UrlLeafName
    IF @DocType = 1
    BEGIN
        UPDATE 
            Docs
        SET
            ScopeId = @NewScopeId
        FROM
            Docs AS d1
        JOIN
            (
                SELECT 
                    DoclibrowId 
                FROM 
                    Docs  WITH(NOLOCK)
                WHERE 
                    Docs.SiteId = @SiteId AND
                    Docs.WebId = @WebId AND
                    Docs.ListId = @ListId AND
                    Docs.DoclibrowId IS NOT NULL AND
                    ((Docs.Dirname = @UrlDirName AND Docs.LeafName = @UrlLeafName) OR
                     (Docs.Dirname = @Url) OR 
                     (Docs.Dirname LIKE @UrlLike)) AND
                    Docs.ScopeId = @NewScopeId 
            ) AS d2 ON 1=1
        WHERE
            d1.Siteid = @SiteId AND
            d1.Webid = @WebId AND
            d1.Listid = @ListId AND        
            ((d1.Dirname = @AttachmentSubfolderUrl AND d1.Leafname = CAST(d2.DoclibrowId AS nvarchar(10))) OR
             (d1.Dirname = @AttachmentSubfolderUrl + '/' + CAST(d2.DoclibrowId AS nvarchar(10))) OR
             (d1.Dirname LIKE dbo.fn_EscapeForLike(@AttachmentSubfolderUrl + '/' + CAST(d2.DoclibrowId AS nvarchar(10)), 1)))
    END
    ELSE
    BEGIN
        DECLARE @ItemIdStr nvarchar(10)
        SET @ItemIdStr = CAST(@DoclibrowId AS nvarchar(10))
        DECLARE @ItemAttachmentFolderUrl nvarchar(260)
        SET @ItemAttachmentFolderUrl = @AttachmentSubfolderUrl + '/' + @ItemIdStr
        DECLARE @HasAttachment bit
        SELECT 
            @HasAttachment = tp_HasAttachment
        FROM
            UserData
        WHERE
            tp_SiteId = @SiteId AND
            tp_DirName = @UrlDirName AND
            tp_LeafName = @UrlLeafName
        UPDATE 
            Docs
        SET
            ScopeId = @NewScopeId
        WHERE
            Siteid = @SiteId AND
            Dirname = @AttachmentSubfolderUrl AND Leafname = @ItemIdStr
        IF @HasAttachment = 1
        BEGIN
            UPDATE 
                Docs
            SET
                ScopeId = @NewScopeId
            WHERE
                Siteid = @SiteId AND
                Dirname = @ItemAttachmentFolderUrl
            UPDATE 
                Docs
            SET
                ScopeId = @NewScopeId
            WHERE
                Siteid = @SiteId AND
                Dirname LIKE dbo.fn_EscapeForLike(@ItemAttachmentFolderUrl, 1)
        END
    END

GO
