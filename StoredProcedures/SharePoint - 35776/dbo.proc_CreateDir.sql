/****** Object:  StoredProcedure [dbo].[proc_CreateDir]    Script Date: 5/15/2018 12:11:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CreateDir(
    @DirSiteId  uniqueidentifier,
    @DirWebId   uniqueidentifier,
    @DirDirName nvarchar(256) OUTPUT,
    @DirLeafName nvarchar(128) OUTPUT,
    @DirLevel tinyint,
    @AddMinorVersion bit,
    @DocFlags int,    
    @CreateDirFlags int,
    @UserId int = NULL,
    @DirId uniqueidentifier = NULL OUTPUT,
    @ScopeId uniqueidentifier = NULL OUTPUT,
    @DoclibRowIdRequired int = NULL,
    @ScopeIdOverride uniqueidentifier = NULL,
    @bAlreadyExists bit = NULL OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @AttachmentsFlag tinyint
    DECLARE @DirParentDir nvarchar(256)
    DECLARE @DirParentLeaf nvarchar(128)
    DECLARE @ListId uniqueidentifier
    DECLARE @DirParentId uniqueidentifier
    DECLARE @DoclibRowId int
    DECLARE @Now datetime
    DECLARE @UIVersion int
    DECLARE @DraftOwnerId int
    DECLARE @CtoOffset int
    SET @AttachmentsFlag = @CreateDirFlags & 7
    DECLARE @quotaOrLockStatus int
    SELECT @quotaOrLockStatus = dbo.fn_IsOverQuotaOrWriteLocked(@DirSiteId)
    IF (@quotaOrLockStatus = 1)
    BEGIN
        RETURN 1816
    END
    ELSE IF (@quotaOrLockStatus > 1)
    BEGIN
        RETURN 212
    END
    IF @DoclibRowIdRequired IS NOT NULL
    BEGIN
        SET @DoclibRowId = @DoclibRowIdRequired
    END
    IF @DirId IS NULL
    BEGIN
        SET @DirId = NEWID()    
    END
    IF @AddMinorVersion = 1
        SET @UIVersion = 1
    ELSE
        SET @UIVersion = 512
    IF @DirLevel = 2
        SET @DraftOwnerId = @UserId
    EXEC proc_SplitUrl
        @DirDirName,
        @DirParentDir OUTPUT,
        @DirParentLeaf OUTPUT
    SELECT
        @ListId = ListId,
        @DirParentDir = DirName,
        @DirParentLeaf = LeafName,
        @DirParentId = Id,
        @ScopeId = ScopeId,
        @CtoOffset = CtoOffset
    FROM
        Docs WITH (REPEATABLEREAD)
    WHERE
        SiteId = @DirSiteId AND
        DirName = @DirParentDir AND
        LeafName = @DirParentLeaf AND
        IsCurrentVersion = 1 AND
        (Type = 1 OR Type = 2) AND
        WebId = @DirWebId
    IF @@ROWCOUNT = 0
    BEGIN
        RETURN 3
    END
    IF (@ScopeIdOverride IS NOT NULL)
        SET @ScopeId = @ScopeIdOverride
    SET @DirDirName = CASE WHEN (DATALENGTH(@DirParentDir) = 0) THEN @DirParentLeaf WHEN (DATALENGTH(@DirParentLeaf) = 0) THEN @DirParentDir ELSE @DirParentDir + N'/' + @DirParentLeaf END
    IF @AttachmentsFlag <> 0
    BEGIN
        DECLARE @IsAttachment bit
        EXEC @IsAttachment = proc_TestAttachmentsFlag @DirSiteId,
            @DirDirName, @AttachmentsFlag
        IF @IsAttachment <> 0
        BEGIN
            IF (@CreateDirFlags & 8) = 0
            BEGIN
                DECLARE @DirLeafNameTemp nvarchar(128)
                SELECT 
                    @DirLeafNameTemp = LeafName
                FROM 
                    Docs
                WHERE 
                    SiteId = @DirSiteId AND
                    DirName = @DirDirName AND
                    LeafName = @DirLeafName AND
                    IsCurrentVersion = 1
                IF @DirLeafNameTemp IS NOT NULL
                BEGIN
                    SET @DirLeafName = @DirLeafNameTemp
                    RETURN 0;
                END
            END
            RETURN 5
        END
    END
    SET @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    BEGIN TRAN
    DECLARE @Error int
    SET @Error = 0
    IF NOT EXISTS (
        SELECT 
            * 
        FROM 
            Docs
        WHERE 
            SiteId = @DirSiteId AND
            DirName = @DirDirName AND
            LeafName = @DirLeafName)
    BEGIN
        DECLARE @MaxNewListRowOrd int
        SET @bAlreadyExists = 0
        IF @ListId IS NOT NULL
        BEGIN
        SELECT 
            @MaxNewListRowOrd = tp_MaxRowOrdinal
        FROM 
            Lists (NOLOCK)
        WHERE
            tp_WebId = @DirWebId AND
            tp_ID = @ListId AND
            tp_BaseType = 1
        END
        IF (@CreateDirFlags & 16) = 0
            AND @MaxNewListRowOrd IS NOT NULL
            AND @DirLeafName <> N'_w'   
            AND @DirLeafName <> N'_t'  
        BEGIN
            DECLARE @DirFullUrl nvarchar(260)
            DECLARE @ModerationStatus int
            SET @DirFullUrl = CASE WHEN (DATALENGTH(@DirDirName) = 0) THEN @DirLeafName WHEN (DATALENGTH(@DirLeafName) = 0) THEN @DirDirName ELSE @DirDirName + N'/' + @DirLeafName END
            SET @ModerationStatus =
                (@CreateDirFlags & 896) /
                    128
            EXEC @Error = proc_AddListItem
                @SiteId = @DirSiteId,
                @WebId = @DirWebId,
                @ListId = @ListId,
                @RowOrdinal = 0,
                @ItemId = @DoclibRowId OUTPUT,
                @UserId = @UserId,                           
                @Size = 0,                                   
                @TimeNow = @Now,
                @Level = @DirLevel,
                @ItemName = @DirLeafName,                    
                @UseNvarchar1ItemName =0,                    
                @ItemDirName = @DirDirName OUTPUT,
                @ItemLeafName = @DirLeafName OUTPUT,
                @ItemDocType = 1,
                @DocIdAdded = @DirId,  
                @tp_ModerationStatus = @ModerationStatus,
                @UIVersion = @UIVersion
            IF @MaxNewListRowOrd > 0
            BEGIN
                DECLARE @rowOrdCount int
                SET @rowOrdCount = 1
                WHILE  @rowOrdCount  <= @MaxNewListRowOrd
                BEGIN
                    INSERT INTO AllUserData(
                        tp_ID,
                        tp_ListId,
                        tp_SiteId,
                        tp_DirName,
                        tp_LeafName,
                        tp_RowOrdinal,
                        tp_Version,
                        tp_Author,
                        tp_Editor,
                        tp_Created,
                        tp_Modified,
                        tp_Size,
                        tp_Level,
                        tp_UIVersion,
                        tp_ModerationStatus,
                        tp_DraftOwnerId)
                    VALUES(
                        @DoclibRowId,
                        @ListId,
                        @DirSiteId,
                        @DirDirName,
                        @DirLeafName,
                        @rowOrdCount,
                        1,
                        @UserID,
                        @UserID,
                        @Now,
                        @Now,                        
                        0,
                        @DirLevel,
                        @UIVersion,
                        @ModerationStatus,
                        @DraftOwnerId)
                    SET @rowOrdCount = @rowOrdCount + 1
                END
            END
            IF @Error <> 0
                GOTO CLEANUP
       END
        INSERT INTO AllDocs (
            Id,
            ParentId,
            SiteId,
            DirName,
            LeafName,
            Level,
            WebId,
            ListId,
            DoclibRowId,
            Type,
            DocFlags,
            ThicketFlag,
            TimeCreated,
            TimeLastModified,
            ScopeId,
            UIVersion,
            CtoOffset,
            DraftOwnerId)
        VALUES (
            @DirId,
            @DirParentId,
            @DirSiteId,
            @DirDirName,
            @DirLeafName,
            @DirLevel,
            @DirWebId,
            @ListId,
            @DoclibRowId,
            1,
            @DocFlags & ~8192,         
            @CreateDirFlags & 32,
            @Now,
            @Now,
            @ScopeId,
            @UIVersion,
            @CtoOffset,
            @DraftOwnerId)
        SET @Error = @@Error
        IF @Error <> 0
	        GOTO CLEANUP
        EXEC proc_UpdateChildCount @DirSiteId, @DirDirName, @DirLeafName, 
                                   @DoclibRowId, @DirLevel, 1, 1
        IF (@DoclibRowId IS NULL)
        BEGIN
            DECLARE @Url nvarchar(260)
            SET @Url = CASE WHEN (DATALENGTH(@DirDirName) = 0) THEN @DirLeafName WHEN (DATALENGTH(@DirLeafName) = 0) THEN @DirDirName ELSE @DirDirName + N'/' + @DirLeafName END 
            EXEC proc_LogChange @DirSiteId, @DirWebId, NULL, NULL, @DirId, NULL,
                NULL, @Url, 4096, 32, @Now
            EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @DirSiteId,
                152, 1
        END    
    END
    ELSE
    BEGIN
        SET @bAlreadyExists = 1
        IF (@CreateDirFlags & 8) <> 0
            SET @Error = 80     
        ELSE   
        BEGIN
            IF @@TRANCOUNT = 1
                ROLLBACK TRAN
        END
    END
CLEANUP:
    IF (@Error <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Error

GO
