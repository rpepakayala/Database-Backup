/****** Object:  StoredProcedure [dbo].[proc_UpdateWebPartWhileSaving]    Script Date: 5/15/2018 12:13:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateWebPartWhileSaving(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @Level tinyint,
    @WebPartID uniqueidentifier,
    @WebPartTypeID uniqueidentifier,
    @IsIncluded bit,
    @FrameState tinyint,
    @ZoneID nvarchar(64),
    @PartOrder int,
    @ContentTypeId tContentTypeId,
    @Source ntext,
    @AllUsersProperties image,
    @PerUserProperties image)
AS
    SET NOCOUNT ON
    DECLARE @DocID uniqueidentifier
    DECLARE @ExistingWebPartID uniqueidentifier
    DECLARE @ExistingUserID int
    DECLARE @Ret int
    DECLARE @SourceSize int
    DECLARE @AllUsersPropertiesSize int
    DECLARE @PerUserPropertiesSize int
    DECLARE @@NewSize bigint
    DECLARE @OldWebPartTypeID uniqueidentifier
    DECLARE @IsCurrentVersion bit
    SET @Ret = 0
    SELECT
        @DocID = Id,
        @IsCurrentVersion = IsCurrentVersion
    FROM
        dbo.Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        Level = @Level
    IF @DocID IS NULL
    BEGIN
        RETURN 2
    END
    IF (@IsCurrentVersion = 0)
    BEGIN
        RETURN 33
    END
    SELECT
        @ExistingWebPartID = tp_ID,
        @OldWebPartTypeID = tp_WebPartTypeID
    FROM
        WebParts
    WHERE
        tp_SiteID = @SiteId AND
        tp_PageUrlID = @DocID AND
        tp_UserID IS NULL AND
        tp_ID = @WebPartID AND
        tp_Level = @Level
    IF (@ExistingWebPartID IS NOT NULL)
    BEGIN
        SET @SourceSize = ISNULL(DATALENGTH(@Source), 0)
        SET @AllUsersPropertiesSize = ISNULL(DATALENGTH(@AllUsersProperties), 0)
        SET @PerUserPropertiesSize = ISNULL(DATALENGTH(@PerUserProperties), 0)
        EXEC @Ret = proc_OnUpdateWebParts
            @SiteId,
            @WebPartID,
            @Level,
            NULL,    
            @AllUsersPropertiesSize,
            @PerUserPropertiesSize,
            0,    
            @SourceSize,
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
            tp_ZoneID = @ZoneID,
            tp_PartOrder = @PartOrder,
            tp_IsIncluded = @IsIncluded,
            tp_FrameState = @FrameState,
            tp_AllUsersProperties = @AllUsersProperties,
            tp_PerUserProperties = @PerUserProperties,
            tp_Source = @Source,
            tp_PageUrlID = @DocID,
            tp_Cache = NULL,
            tp_ContentTypeId = CASE WHEN @ContentTypeId IS NULL
                THEN tp_ContentTypeId ELSE @ContentTypeId END,
            tp_Size = @@NewSize
        WHERE
            tp_SiteID = @SiteId AND
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
        IF NOT EXISTS(
            SELECT
                *
            FROM
                WebParts
            WHERE
                tp_SiteId = @SiteID AND
                tp_ID = @WebPartID AND
                tp_Level = @Level)
        BEGIN
            SET @Ret = 2  
        END
    END
    ELSE
    BEGIN
        IF EXISTS (
            SELECT
                *
            FROM
                WebParts
            WHERE
                tp_SiteID = @SiteId AND
                tp_ID = @WebPartID AND
                tp_Level = @Level)
        BEGIN
            SET @WebPartID=NEWID()
        END
        DECLARE @cbDelta bigint
        SET @cbDelta = 116 + ISNULL(DATALENGTH(NULL), 0) + ISNULL(DATALENGTH(@AllUsersProperties), 0) + ISNULL(DATALENGTH(@PerUserProperties), 0) + ISNULL(DATALENGTH(NULL), 0) + ISNULL(DATALENGTH(@Source), 0)
        EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, @cbDelta, 0
        INSERT INTO dbo.WebParts (
            tp_WebPartTypeId,
            tp_SiteId,
            tp_ID,
            tp_ZoneID,
            tp_PartOrder,
            tp_IsIncluded,
            tp_FrameState,
            tp_Source,
            tp_AllUsersProperties,
            tp_PerUserProperties,
            tp_PageUrlID,
            tp_Size,
            tp_ContentTypeId,
            tp_Level)
        VALUES (
            @WebPartTypeID,
            @SiteId,
            @WebPartID,
            @ZoneID,
            @PartOrder,
            @IsIncluded,
            @FrameState,
            @Source,
            @AllUsersProperties,
            @PerUserProperties,
            @DocID,
            @cbDelta,
            CASE WHEN @ContentTypeId IS NULL THEN 0x ELSE @ContentTypeId END,
            @Level)
    END
cleanup:
    IF (0 <> @@ERROR OR 0 <> @Ret)
    BEGIN
        RETURN CASE WHEN (0 = @Ret) THEN -2147467259 ELSE @Ret END
    END
    RETURN 0

GO
