/****** Object:  StoredProcedure [dbo].[proc_AddDocument]    Script Date: 5/15/2018 12:11:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddDocument(
    @DocSiteId   uniqueidentifier,
    @DocWebId    uniqueidentifier,
    @UserId      int,
    @AuthorId    int, 
    @DocDirName  nvarchar(256),
    @DocLeafName nvarchar(128) OUTPUT,
    @Level tinyint,
    @UIVersion int = 512,
    @NewDocId uniqueidentifier,
    @DoclibId uniqueidentifier,
    @NewDoclibRowId int,
    @DocContent image,
    @DocMetaInfo image,
    @DocSize int,
    @DocMetainfoSize int,
    @EnableMinorVersions bit,
    @DocDirty bit,
    @DocFlags int,
    @DocIncomingCreatedDTM datetime,
    @DocIncomingDTM datetime,
    @GetWebListForNormalization bit,
    @PutFlags int,
    @CreateParentDir bit,
    @UrlIsSuggestion bit,
    @ThicketMainFile bit,
    @CharSet int,
    @ProgId nvarchar(255),
    @AttachmentOp    int,
    @VirusVendorID int,
    @VirusStatus int,
    @VirusInfo nvarchar(255),
    @LockTimeout int,
    @Comment nvarchar(1023),
    @@DocDTM datetime OUTPUT,
    @fNoQuotaOrLockCheck bit,
    @ChunkSize int,
    @DocTextptr varbinary(16) OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @Now datetime
    DECLARE @DocCreatedDTM datetime
    DECLARE @iRet int
    DECLARE @DraftOwnerId int
    DECLARE @DocParentId uniqueidentifier
    DECLARE @ScopeId uniqueidentifier
    DECLARE @LockOrCheckout bit
    DECLARE @PutOpt_Migrate bit 
    SET @LockOrCheckout = CASE
            WHEN @Level = 255 OR @LockTimeout IS NOT NULL
            THEN 1
            ELSE 0
        END
    IF (@fNoQuotaOrLockCheck = 0)
    BEGIN
        DECLARE @quotaOrLockStatus int
        SELECT  @quotaOrLockStatus =
            dbo.fn_IsOverQuotaOrWriteLocked(@DocSiteId)
        IF (@quotaOrLockStatus = 1)
        BEGIN
            RETURN 1816
        END
        ELSE IF (@quotaOrLockStatus > 1)
        BEGIN
            RETURN 212
        END
    END
    DECLARE @guidT uniqueidentifier
    DECLARE @crowT bigint
    IF @DoclibId IS NOT NULL
    BEGIN
        SELECT
            @guidT = tp_Id
        FROM
            Lists WITH(UPDLOCK)
        WHERE
            tp_WebId = @DocWebId AND
            tp_Id = @DoclibId
    END
    EXEC @iRet = proc_CanonicalDirNameFromUserInput
        @DocSiteId,
        @DocWebId,
        @DocDirName OUTPUT,
        @DocParentId OUTPUT,
        @ScopeId OUTPUT
    IF (@AttachmentOp <> 0)
        EXEC proc_GetAttachmentParentScopeId @DocSiteId, @DocDirName, @ScopeId OUTPUT
    IF 0 <> @iRet
    BEGIN
        IF @CreateParentDir = 1
        BEGIN
            DECLARE @DirDirName nvarchar(256)
            DECLARE @DirLeafName nvarchar(128)
            EXEC proc_SplitUrl
                @DocDirName,
                @DirDirName OUTPUT,
                @DirLeafName OUTPUT
            DECLARE @CreateDirFlags int
            SET @CreateDirFlags =
            CASE 
                WHEN (@PutFlags & 128) <> 0
                    THEN 32 |
                        16
                ELSE 0
            END
            EXEC @iRet = proc_CreateDir
                @DocSiteId,
                @DocWebId,
                @DirDirName OUTPUT,
                @DirLeafName OUTPUT,
                @Level,
                @EnableMinorVersions,
                0,       
                @CreateDirFlags,  
                @UserId,    
                @DocParentId OUTPUT,
                @ScopeId OUTPUT,
                NULL,
                @ScopeId 
            IF @iRet <> 0 
                RETURN @iRet
            SET @DocDirName = CASE WHEN (DATALENGTH(@DirDirName) = 0) THEN @DirLeafName WHEN (DATALENGTH(@DirLeafName) = 0) THEN @DirDirName ELSE @DirDirName + N'/' + @DirLeafName END
        END
        ELSE
        BEGIN
            RETURN 3
        END
    END
    IF @UrlIsSuggestion = 1
    BEGIN
        EXEC @iRet = proc_GetUniqueFileName
                        @DocSiteId,
                        @DocDirName,
                        @DocLeafName OUTPUT
        IF @iRet <> 0
            RETURN @iRet
    END
    IF @GetWebListForNormalization = 1
    BEGIN
        SELECT
            FullUrl
        FROM
            Webs
        WHERE
            SiteId = @DocSiteId AND
            ParentWebId = @DocWebId 
    END
    SELECT @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    IF @DocIncomingDTM IS NULL
    BEGIN
        SET @@DocDTM = @Now
    END
    ELSE
    BEGIN
        SET @@DocDTM = @DocIncomingDTM
    END
    IF @DocIncomingCreatedDTM IS NULL
    BEGIN
        SET @DocCreatedDTM = @@DocDTM
    END
    ELSE
    BEGIN
        SET @DocCreatedDTM = @DocIncomingCreatedDTM
    END
    IF @Level = 2
        SET @DraftOwnerId = ISNULL(@AuthorId, @UserId)
    ELSE
        SET @DraftOwnerId = NULL
    IF @Level = 255
        SET @DocFlags = @DocFlags | 32
    INSERT INTO AllDocs (
        Id,
        SiteId,
        DirName,
        LeafName,
        Level,
        WebId,
        ListId,
        DoclibRowId,
        Type,
        Size,
        ParentId,
        MetaInfo,
        MetaInfoSize,
        Version,
        UIVersion,
        Dirty,
        TimeCreated,
        TimeLastModified,
        MetaInfoTimeLastModified,
        TimeLastWritten,
        DocFlags,
        ThicketFlag,
        CharSet,
        ProgId,
        VirusVendorID,
        VirusStatus,
        VirusInfo,
        ScopeId,
        DraftOwnerId,
        CheckoutUserId,
        CheckoutDate,
        CheckoutExpires,
        CheckinComment)
    VALUES (
        @NewDocId,
        @DocSiteId,
        @DocDirName,
        @DocLeafName,
        @Level,
        @DocWebId,
        @DoclibId,
        @NewDoclibRowId,
        0,
        @DocSize,
        @DocParentId,
        @DocMetaInfo,
        @DocMetainfoSize,
        1,
        COALESCE(@UIVersion, 512),
        @DocDirty,
        @DocCreatedDTM,
        @@DocDTM,
        @Now,
        @Now,
        @DocFlags,
        @ThicketMainFile,
        @CharSet,
        @ProgId,
        @VirusVendorID,
        @VirusStatus,
        @VirusInfo,
        @ScopeId,
        @DraftOwnerId,
        CASE WHEN @LockOrCheckout = 1 THEN ISNULL(@AuthorId, @UserId) ELSE NULL END,
        CASE WHEN @LockOrCheckout = 1 THEN @Now ELSE NULL END,
        CASE WHEN @LockTimeout IS NOT NULL
            THEN DATEADD(mi, @LockTimeout, @Now)
            ELSE NULL
            END,
        CASE WHEN @Level = 255 THEN NULL ELSE @Comment END)
    IF (@@ROWCOUNT = 0 OR @@ERROR <> 0)
    BEGIN
        RETURN 80
    END
    EXEC proc_UpdateChildCount @DocSiteId, @DocDirName, @DocLeafName,
                               @NewDoclibRowId, @Level, 0, 1    
    IF @DocContent IS NOT NULL
    BEGIN
        IF @DocFlags & 256 = 0
        BEGIN
            RETURN 80
        END
        ELSE
        BEGIN
            INSERT INTO AllDocStreams (
                Id,
                Level,
                SiteId,
                ParentId,
                Content,
                Size)
            VALUES (
                @NewDocId,
                @Level,
                @DocSiteId,
                @DocParentId,
                @DocContent,
                @DocSize)
            IF (@@ROWCOUNT = 0 OR @@ERROR <> 0)
            BEGIN
                RETURN 80
            END
                IF @DocSize > @ChunkSize
                BEGIN
                    SELECT
                        @DocTextptr = TEXTPTR(Content)
                    FROM
                        AllDocStreams WITH (UPDLOCK)
                    WHERE
                        SiteId = @DocSiteId AND
                        DeleteTransactionId = 0x AND
                        ParentId = @DocParentId AND
                        Id = @NewDocId AND
                        Level = @Level
                END
        END
    END
    SET @PutOpt_Migrate =
        CASE WHEN (@PutFlags & 8192 = 8192)
        THEN 1
        ELSE 0
        END
    IF (@NewDoclibRowId IS NULL)
    BEGIN
        DECLARE @Url nvarchar(260)
        DECLARE @TimeLastModifiedLog datetime
        IF (@PutOpt_Migrate = 1)
        BEGIN
            SET @TimeLastModifiedLog = NULL
        END
        ELSE
        BEGIN
            SET @TimeLastModifiedLog = @@DocDTM
        END
        SET @Url = CASE WHEN (DATALENGTH(@DocDirName) = 0) THEN @DocLeafName WHEN (DATALENGTH(@DocLeafName) = 0) THEN @DocDirName ELSE @DocDirName + N'/' + @DocLeafName END 
        EXEC proc_LogChange @DocSiteId, @DocWebId, NULL, NULL, @NewDocId, NULL,
            NULL, @Url, 4096, 16, @TimeLastModifiedLog
        IF (@PutOpt_Migrate = 1)
        BEGIN
            EXEC proc_LogChange @DocSiteId, @DocWebId, NULL, NULL, @NewDocId, NULL,
                NULL, @Url, 1048576, 16, @TimeLastModifiedLog
        END
    END    
    EXEC proc_ResyncWelcomeLinks @DocSiteId, @DocDirName, @DocLeafName, NULL
    IF (@AttachmentOp <> 0)
        EXEC proc_UpdateAttachmentsFlag @DocSiteId, @DocDirName,
            @UserId, @AttachmentOp
    EXEC proc_AddAuditEntryFromSql
            @DocSiteId,
            @DocDirName,
            @DocLeafName,
            1,
            @UserId,                
            5,
            NULL,
            0x00000010
    IF (@DoclibId IS NOT NULL)
    BEGIN
        EXEC proc_AddAuditEntryFromSql
                @DocSiteId,
                @DocDirName,
                @DocLeafName,
                4,
                @UserId,                
                5,
                @DocLeafName,
                0x00000010
    END
    IF @LockOrCheckout = 1
        EXEC proc_GetLockInfo @DocSiteId, @DocDirName, @DocLeafName, @Level
    DECLARE @cbDelta INT
    SET @cbDelta = ISNULL(@DocSize, 0) + 152 + @DocMetainfoSize
    IF @NewDoclibRowId IS NULL OR @DoclibId IS NULL
        EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @DocSiteId, @cbDelta, 1
    DECLARE @Ret int
    SET @Ret = 0
    RETURN @Ret

GO
