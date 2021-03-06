/****** Object:  StoredProcedure [dbo].[proc_UpdateWebPart]    Script Date: 5/15/2018 12:12:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateWebPart(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @Level tinyint OUTPUT,
    @bAllUser bit,
    @SystemID tSystemID,
    @WebPartID uniqueidentifier,
    @WebPartTypeID uniqueidentifier,
    @bCheckLock bit,
    @IsIncluded bit,
    @FrameState tinyint,
    @ZoneID nvarchar(64),
    @PartOrder int,
    @AllUsersProperties image,
    @PerUserProperties image)
AS
    SET NOCOUNT ON
    DECLARE @DocId uniqueidentifier
    DECLARE @PartDocId uniqueidentifier
    DECLARE @UserID int
    DECLARE @Ret int
    DECLARE @AllUsersSize int
    DECLARE @PerUserSize int
    DECLARE @@NewSize bigint
    DECLARE @OldWebPartTypeID uniqueidentifier
    DECLARE @CurrentUserId int
    DECLARE @IsCurrentVersion bit
    DECLARE @IsForceCheckout bit
    DECLARE @EnableMinorVersions bit
    DECLARE @IsModerate bit
    DECLARE @WebId uniqueidentifier
    DECLARE @ListId uniqueidentifier
    DECLARE @ItemId int
    SET @Ret = 0
    SET @CurrentUserId = dbo.fn_UserIDFromSid(@SiteId, @SystemID)
    SELECT
        @IsForceCheckout =
            CASE WHEN Lists.tp_Flags & 0x40000 <>0
                 AND @bCheckLock = 1
            THEN 1
            ELSE 0
            END,
        @EnableMinorVersions = CASE WHEN Lists.tp_Flags & 0x80000 <>0
            THEN 1
            ELSE 0
            END,
        @IsModerate = CASE WHEN Lists.tp_Flags & 0x400 <>0
            THEN 1
            ELSE 0
            END,
        @DocId = Id,
        @IsCurrentVersion = IsCurrentVersion,
        @WebId = WebId,
        @ListId = ListId,
        @ItemId = DoclibRowId
    FROM
        Docs
    LEFT OUTER JOIN Lists WITH (NOLOCK)
    ON
        Lists.tp_ID = Docs.ListId AND
        Lists.tp_WebId = Docs.WebId AND
        Docs.DoclibRowId IS NOT NULL
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @DirName AND
        Docs.LeafName = @LeafName AND
        Docs.Level = @Level
    IF (@IsForceCheckout = 1
        AND @Level <> 255
        AND @bAllUser = 1)
        RETURN 158
    IF @DocId IS NULL
    BEGIN
        RETURN 2
    END
    IF @bCheckLock = 1
    BEGIN
        IF (@bAllUser = 0) AND (@Level = 255)
        BEGIN
            RETURN 12
        END
        IF (@bAllUser = 1) AND (@IsCurrentVersion = 0)
        BEGIN
            RETURN 33
        END
    END
    SELECT
        @PartDocId=tp_PageUrlID,
        @UserID = tp_UserID,
        @OldWebPartTypeID = tp_WebPartTypeID
    FROM
        WebParts
    WHERE
        tp_SiteID = @SiteId AND
        tp_ID = @WebPartID AND
        tp_Level = @Level
    IF (@DocId <> @PartDocId)
    BEGIN
        RETURN 5
    END
    IF (@EnableMinorVersions = 1 OR @IsModerate = 1 ) AND
        @Level = 1 AND @bAllUser = 1 AND
        @ItemId IS NOT NULL AND
        @bCheckLock = 1 AND @CurrentUserId IS NOT NULL
    BEGIN
        EXEC @Ret = proc_CloneDoc  @SiteId,
                      @DirName,
                      @LeafName,
                      NULL,
                      NULL,
                      NULL,
                      @Level,
                      2,
                      @EnableMinorVersions,
                      @IsModerate,
                      @CurrentUserId,
                      NULL
        IF (@@ERROR <> 0 OR @Ret <> 0)
        BEGIN
            IF (@Ret = 0)
                SET @Ret = -2147467259
            GOTO cleanup
        END
        SET @Level = 2
    END
    IF (@bAllUser = 1 OR @UserID IS NOT NULL)
    BEGIN                
        SET @AllUsersSize = ISNULL(DATALENGTH(@AllUsersProperties), 0)
        SET @PerUserSize = ISNULL(DATALENGTH(@PerUserProperties), 0)
        EXEC @Ret = proc_OnUpdateWebParts
            @SiteId,
            @WebPartID,
            @Level,
            NULL,    
            @AllUsersSize,
            @PerUserSize,
            0,       
            0,       
            NULL,    
            @@NewSize OUTPUT
        IF (@@ERROR <> 0 OR @Ret <> 0)
        BEGIN
            IF (@Ret = 0)
                SET @Ret = -2147467259
            GOTO cleanup
        END
        IF (@OldWebPartTypeID IS NOT NULL) AND
            (@OldWebPartTypeID <> @WebPartTypeID) AND
            (@IsIncluded IS NULL) AND
            (@Level <> 255)
        BEGIN
            EXEC @Ret = proc_DeleteWebPartPersonalization
                @SiteId,
                @DirName,
                @LeafName,
                NULL,
                @WebPartID
        END
        IF (@@ERROR <> 0 OR @Ret <> 0)
        BEGIN
            IF (@Ret = 0)
                SET @Ret = -2147467259
            GOTO cleanup
        END
        UPDATE
            dbo.WebParts
        SET
            tp_WebPartTypeID = @WebPartTypeID,
            tp_AllUsersProperties = @AllUsersProperties,
            tp_PerUserProperties = @PerUserProperties,
            tp_ZoneID = CASE WHEN (@IsIncluded IS NULL) THEN tp_ZoneID ELSE @ZoneID END,
            tp_PartOrder = COALESCE(@PartOrder, tp_PartOrder),
            tp_Source = NULL,       
            tp_IsIncluded = COALESCE(@IsIncluded, tp_IsIncluded),
            tp_FrameState = COALESCE(@FrameState, tp_FrameState),
            tp_Cache = NULL,
            tp_Size = @@NewSize
        WHERE
            tp_SiteId = @SiteId AND
            tp_ID = @WebPartID AND
            tp_Level = @Level
        IF (@@ERROR <> 0 OR @Ret <> 0)
        BEGIN
            IF (@Ret = 0)
                SET @Ret = -2147467259
            GOTO cleanup
        END
        IF (@Level = 1)
        BEGIN
            EXEC @Ret = proc_InvalidatePerUserWebPartCache
                    @SiteId,
                    @WebPartID
            IF (@@ERROR <> 0 OR @Ret <> 0)
            BEGIN
                IF (@Ret = 0)
                    SET @Ret = -2147467259
                GOTO cleanup
            END
        END
        DELETE FROM
            Links
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName AND
            FieldId IS NULL AND
            WebPartId = @WebPartID AND
            Level = @Level
    END
    ELSE
    BEGIN                
        SET @UserID = @CurrentUserId
        IF (EXISTS (
            SELECT
                *
            FROM
                dbo.Personalization
            WHERE
                tp_SiteID = @SiteID AND
                tp_PageUrlID = @DocId AND
                tp_UserID = @UserID AND
                tp_WebPartID = @WebPartID))
        BEGIN            
            SET @PerUserSize = ISNULL(DATALENGTH(@PerUserProperties), 0)
            EXEC @Ret = proc_OnUpdatePersonalization
                @SiteId,
                @DocId,
                @UserID,
                @WebPartID,
                @PerUserSize,
                0,    
                @@NewSize OUTPUT
            IF (@@ERROR <> 0 OR @Ret <> 0)
            BEGIN
                IF (@Ret = 0)
                    SET @Ret = -2147467259
                GOTO cleanup
            END
            UPDATE
                dbo.Personalization
            SET
                tp_PerUserProperties = @PerUserProperties,
                tp_ZoneID = @ZoneID,
                tp_PartOrder = @PartOrder,
                tp_IsIncluded = @IsIncluded,
                tp_FrameState = @FrameState,
                tp_Cache = NULL,
                tp_Size = @@NewSize
            WHERE
                tp_SiteID = @SiteID AND
                tp_PageUrlID = @DocId AND
                tp_UserID = @UserID AND
                tp_WebPartID = @WebPartID
        END
        ELSE
        BEGIN            
            DECLARE @cbDelta bigint
            DECLARE @quotaOrLockStatus int
            SELECT @quotaOrLockStatus = dbo.fn_IsOverQuotaOrWriteLocked(@SiteId)
            IF (@quotaOrLockStatus = 1)
            BEGIN
                SET @Ret = 1816
                GOTO cleanup
            END
            ELSE IF (@quotaOrLockStatus > 1)
            BEGIN
                SET @Ret = 212
                GOTO cleanup
            END
            SET @cbDelta = 66 + ISNULL(DATALENGTH(@PerUserProperties), 0) + ISNULL(DATALENGTH(NULL), 0)
            EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp
                @SiteId, @cbDelta, 0
            INSERT INTO dbo.Personalization (
                tp_SiteId,
                tp_WebPartID,
                tp_PageUrlID,
                tp_UserID,
                tp_PerUserProperties,
                tp_ZoneID,
                tp_PartOrder,
                tp_IsIncluded,
                tp_FrameState,
                tp_Size)
            VALUES (
                @SiteId,
                @WebPartID,
                @DocId,
                @UserID,
                @PerUserProperties,
                @ZoneID,
                @PartOrder,
                @IsIncluded,
                @FrameState,
                @cbDelta)
        END
    END
    IF (@@ERROR <> 0 OR @Ret <> 0)
    BEGIN
        IF (@Ret = 0)
            SET @Ret = -2147467259
        GOTO cleanup
    END
    IF NOT EXISTS(
        SELECT
            *
            FROM
                WebParts
        WHERE
            tp_SiteID = @SiteID AND
            tp_ID = @WebPartID AND
            tp_Level = @Level)
    BEGIN
        SET @Ret = 2  
    END
    ELSE
    BEGIN
        IF (@ItemId IS NOT NULL)
        BEGIN
            EXEC proc_LogChange @SiteId, @WebId, @ListId, @ItemId, @DocId,
                NULL, NULL, NULL, 8192, 1, NULL
        END
        ELSE
        BEGIN
            EXEC proc_LogChange @SiteId, @WebId, NULL, NULL, @DocId,
                NULL, NULL, NULL, 8192, 16, NULL
        END
    END
cleanup:
    IF (0 <> @@ERROR OR 0 <> @Ret)
    BEGIN
        RETURN CASE WHEN (0 = @Ret) THEN -2147467259 ELSE @Ret END
    END
    RETURN 0

GO
