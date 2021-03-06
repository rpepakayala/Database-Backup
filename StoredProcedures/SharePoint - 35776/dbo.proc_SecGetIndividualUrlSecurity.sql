/****** Object:  StoredProcedure [dbo].[proc_SecGetIndividualUrlSecurity]    Script Date: 5/15/2018 12:12:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetIndividualUrlSecurity(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @FullUrl nvarchar(260),
    @DirName nvarchar(256),
    @LeafName nvarchar(128),   
    @UserId int,
    @AttachmentsFlag tinyint,
    @bGetAttachmentWritePerm bit,
    @bGetListMetaData bit = 0,
    @bGetListScopes bit = 0,
    @bLockLists bit = 0,
    @Level tinyint = NULL)
AS
    SET NOCOUNT ON
    DECLARE @NeedManageListRight bit
    DECLARE @IsAttachment bit
    SET @NeedManageListRight = 0
    SET @IsAttachment = 0
    DECLARE @ListId uniqueidentifier
    DECLARE @ScopeId uniqueidentifier
    DECLARE @BaseType int
    DECLARE @ExcludedType int
    DECLARE @ListFlags bigint
    DECLARE @DraftOwnerId int
    DECLARE @DoclibRowId int
    EXEC proc_GetContainingListOutput @SiteId, @WebId, @FullUrl,
        @ListId OUTPUT, @BaseType OUTPUT, @ExcludedType OUTPUT, @bLockLists,@ListFlags OUTPUT
    IF @Level IS NULL
        EXEC proc_GetLevel  
                @SiteId, 
                @DirName, 
                @LeafName, 
                @UserId,
                1,
                @Level OUTPUT    
    IF @ListId IS NULL
    BEGIN
        SELECT
            NULL,
            NULL,
            NULL,
            CAST (0 AS bit),
            CAST (0 AS bit),
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            0
    END
    ELSE
    BEGIN
        IF @AttachmentsFlag <> 0
        BEGIN
            IF @bGetAttachmentWritePerm = 1
                EXEC @IsAttachment = proc_TestAttachmentsFlagWritePerm 
                    @SiteId, 
                    @DirName, 
                    @LeafName, 
                    @AttachmentsFlag, 
                    @UserId,
                    @NeedManageListRight  OUTPUT
            ELSE
                EXEC @IsAttachment = proc_TestAttachmentsFlagReadPerm 
                    @SiteId, 
                    @DirName, 
                    @LeafName, 
                    @AttachmentsFlag, 
                    @UserId,
                    @NeedManageListRight  OUTPUT
        END
        SELECT
            @ScopeId = ScopeId,
            @DraftOwnerId = DraftOwnerId,
            @DoclibRowId = DoclibRowId
        FROM
            Docs
        WHERE
            Docs.SiteId = @SiteId AND
            Docs.DirName = @DirName AND
            Docs.LeafName = @LeafName
        WHILE @ScopeId IS NULL AND @DirName <> N''
        BEGIN
            EXEC proc_SplitUrl @DirName, @DirName output, @LeafName output
            SELECT
                @ScopeId = ScopeId
            FROM
                Docs
            WHERE
                Docs.SiteId = @SiteId AND
                Docs.DirName = @DirName AND
                Docs.LeafName = @LeafName
        END
        SELECT
            @ListId,
            Perms.Acl,
            Perms.AnonymousPermMask,
            @IsAttachment,
            @NeedManageListRight,
            @BaseType,
            @ExcludedType,
            @ListFlags,
            @Level,
            @DraftOwnerId,
            @DoclibRowId
        FROM            
            Perms
        WHERE
            SiteId = @SiteId AND
            ScopeId = @ScopeId
    END
    IF @bGetListMetaData = 1 AND @ListId IS NOT NULL
    BEGIN
        EXEC proc_GetListMetaDataAndEventReceivers @SiteId, @WebId, @ListId, 0
    END
    IF @bGetListScopes = 1 AND @ListId IS NOT NULL
    BEGIN
        DECLARE @UrlLike nvarchar(1024)
        EXEC proc_EscapeForLike @FullUrl, @UrlLike OUTPUT
        SELECT
            ScopeId, Acl, AnonymousPermMask 
        FROM
            Perms
        WHERE
            SiteId = @SiteId AND
             ((ScopeId = @ScopeId) OR 
                (WebId = @WebId AND DelTransId = 0x AND ScopeUrl LIKE @UrlLike))
    END
    RETURN 0        

GO
