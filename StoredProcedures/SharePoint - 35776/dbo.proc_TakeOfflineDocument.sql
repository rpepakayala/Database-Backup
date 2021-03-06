/****** Object:  StoredProcedure [dbo].[proc_TakeOfflineDocument]    Script Date: 5/15/2018 12:12:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_TakeOfflineDocument(
    @SiteId  uniqueidentifier,
    @WebId   uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @CreateVersion bit,
    @EnableMinorVersions bit,
    @Moderated bit,
    @UserId int,
    @MaxMajorVersion int,
    @MaxMajorMinorVersion int)
AS
    SET NOCOUNT ON
    DECLARE @Ret int
    DECLARE @ListID uniqueidentifier
    DECLARE @ItemId int
    DECLARE @CheckinLevel tinyint
    DECLARE @Level tinyint
    DECLARE @cbOld int
    DECLARE @cbOldMetaInfo int
    DECLARE @cbDelta bigint
    DECLARE @DocId uniqueidentifier
    DECLARE @ParentId uniqueidentifier
    DECLARE @DraftOwnerId int
    DECLARE @UIVersion int
    DECLARE @LastUIVersion int
    DECLARE @ModerationStatus int
    SET @ModerationStatus = 1
    DECLARE @FullUrl nvarchar(260)
    DECLARE @Now datetime
    SET @cbDelta = 0
    SET @Level = 1
    SELECT 
        @DocId = Id,
        @ParentId = ParentId,
        @ListID = ListId,
        @ItemId = DoclibRowId, 
        @DraftOwnerId = DraftOwnerId,
        @UIVersion = UIVersion,
        @cbOld = ISNULL(Docs.Size, 0),
        @cbOldMetaInfo = ISNULL(Docs.MetaInfoSize, 0)
    FROM
        Docs
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.WebId = @WebId AND
        Docs.DirName = @DirName AND
        Docs.LeafName = @LeafName AND 
        Docs.Level = @Level
    IF @DocId IS NULL OR @Moderated <> 1 AND @EnableMinorVersions <> 1
        return 3 
    IF @EnableMinorVersions = 1 AND @Moderated = 1
        SET @ModerationStatus = 3
    SET @FullUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END
    SET @Now = GETUTCDATE()
    BEGIN TRANSACTION
    IF @DraftOwnerId IS NULL
    BEGIN
        EXEC @Ret = proc_DenyDoc @SiteId,
            @DirName,
            @LeafName,
            @Level OUTPUT,
            @UserId,
            @EnableMinorVersions,
            @Moderated,
            @ModerationStatus      
    END
    ELSE
    BEGIN          
        IF @EnableMinorVersions = 1
        BEGIN
            SELECT TOP 1
                @LastUIVersion = Version
            FROM 
                AllDocVersions
            WHERE 
                AllDocVersions.Id = @DocId AND
                AllDocVersions.SiteId = @SiteId AND
                AllDocVersions.Version < @UIVersion
            ORDER BY
                Version DESC
            IF @LastUIVersion IS NULL OR
                @LastUIVersion < @UIVersion-512
            BEGIN
              SET @LastUIVersion = @UIVersion-512          
            END
            SET @LastUIVersion = @LastUIVersion+1
        END
        ELSE
            SET @LastUIVersion = @UIVersion
        IF (@cbOld IS NOT NULL) AND (@CreateVersion = 1)
        BEGIN
                EXEC proc_CreateDocVersion @SiteId,
                    @DirName,
                    @LeafName,
                    @ListID,
                    @ItemId,
                    @Level
                UPDATE
                    DocVersions
                SET 
                    Level = 2,                    
                    Version = @LastUIVersion                 
                WHERE
                    DocVersions.SiteId = @SiteId AND
                    DocVersions.Id = @DocId AND
                    DocVersions.Version = @UIVersion AND
                    DocVersions.Level = @Level
                UPDATE
                    UserDataVersioned
                SET 
                    tp_Level = 2,                  
                    tp_CalculatedVersion = @LastUIVersion,    
                    tp_UIVersion = @LastUIVersion,
                    tp_ModerationStatus = @ModerationStatus
                WHERE
                    UserDataVersioned.tp_ListId = @ListID AND
                    UserDataVersioned.tp_ID = @ItemId AND
                    UserDataVersioned.tp_UIVersion = @UIVersion AND
                    UserDataVersioned.tp_IsCurrentVersion = 0 AND
                    UserDataVersioned.tp_Level = @Level
                SET @cbDelta = @cbDelta + @cbOld + @cbOldMetaInfo
        END
        DELETE  FROM
            Docs
        WHERE
            Docs.SiteId = @SiteId AND
            Docs.DirName = @DirName AND
            Docs.LeafName = @LeafName AND 
            Docs.Level = @Level
        DELETE  FROM
            DocStreams
        WHERE
            DocStreams.SiteId = @SiteId AND
            DocStreams.ParentId = @ParentId AND
            DocStreams.Id = @DocId AND 
            DocStreams.Level = @Level
        DELETE FROM 
            UserData
        WHERE
            tp_ListId = @ListId AND
            tp_Id = @ItemId AND
            tp_Level = @Level
        EXEC proc_DeleteFromNVP @SiteId, @ListId, @ItemId, @Level
        DELETE FROM
            Links
        WHERE
            SiteId = @SiteID AND
            DirName = @DirName AND
            LeafName = @LeafName AND
            Level = @Level
        DELETE FROM 
            Deps
        WHERE 
            SiteId = @SiteID AND
            DeleteTransactionId = 0x AND
            FullUrl = @FullUrl AND
            Level = @Level
        EXEC proc_DeleteWebPartForDoc @SiteId, 
             @DocId, @Level, NULL 
        SET @Level = 2
    END
    IF @MaxMajorVersion > 0 OR @MaxMajorMinorVersion > 0
        EXEC  proc_ManageVersions
                    @SiteId,
                    @DirName,
                    @LeafName,
                    @ListId,
                    @ItemId,
                    @MaxMajorVersion,
                    @MaxMajorMinorVersion 
    IF @cbDelta <> 0 
        EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, @cbDelta, 0
    EXEC proc_UpdateDiskUsed @SiteId, 1
    DECLARE @ObjectType int
    IF (@ItemId IS NULL)
    BEGIN
        SET @ListId = NULL
        SET @ObjectType = 16
    END
    ELSE
    BEGIN
        SET @ObjectType = 1
    END
    EXEC proc_LogChange @SiteId, @WebId, @ListId, @ItemId, @DocId,
        NULL, NULL, @FullUrl, 1048576,
        @ObjectType, @Now
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    EXEC proc_GetLinkInfoSingleDoc @SiteId, @DirName, @LeafName, @Level
    EXEC proc_GetMetaInfoForSingleDoc @SiteId,
        @DirName,
        @LeafName,
        @UserId,
        @Level,
        0, 
        @WebId
    RETURN @Ret

GO
