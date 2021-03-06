/****** Object:  StoredProcedure [dbo].[proc_CopyWebParts]    Script Date: 5/15/2018 12:11:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CopyWebParts(
    @SiteId uniqueidentifier,
    @OldDocID uniqueidentifier,
    @OldUrlDirName nvarchar(256),
    @OldUrlLeafName nvarchar(128),
    @NewDocID uniqueidentifier,
    @NewUrlDirName nvarchar(256),
    @NewUrlLeafName nvarchar(128),
    @CopyForNewViewPage bit,
    @OldLevel tinyint = 1,
    @NewLevel tinyint = LEVEL_DEAFULT)
AS
    SET NOCOUNT ON
    DECLARE @cbDelta bigint
    DECLARE @Ret int
    SET @Ret = 0
    DECLARE @idTable table (
        OldWebPartId uniqueidentifier,
        NewWebPartId uniqueidentifier,
        ZoneID nvarchar(64))
    DECLARE @WebPartCount int
    DECLARE @quotaOrLockStatus int
    SELECT  @quotaOrLockStatus = dbo.fn_IsOverQuotaOrWriteLocked(@SiteId)
    IF (@quotaOrLockStatus = 1)
    BEGIN
        RETURN 1816
    END
    ELSE IF (@quotaOrLockStatus > 1)
    BEGIN
        RETURN 212
    END
    INSERT INTO @idTable(
        OldWebPartId,
        NewWebPartId,
        ZoneID)
    SELECT
        tp_ID,
        NEWID(),
        tp_ZoneID
    FROM
        WebParts
    WHERE
        tp_SiteID = @SiteId AND
        tp_PageUrlID = @OldDocID AND
        tp_Level = @OldLevel AND
        (@CopyForNewViewPage = 0 OR
        tp_UserID IS NULL AND (tp_Type IS NULL OR tp_Type <> 0))
    SET @WebPartCount = @@ROWCOUNT
    IF @WebPartCount = 0
        GOTO cleanup
    IF @CopyForNewViewPage = 1
    BEGIN
        DELETE
            @idTable
        WHERE
            ZoneID COLLATE Latin1_General_CI_AS NOT IN (
            SELECT DISTINCT
                tp_ZoneID
            FROM
                WebParts
            WHERE
                tp_SiteID = @SiteId AND
                tp_PageUrlID = @NewDocID AND
                tp_UserID IS NULL
            )
        IF @@ROWCOUNT = @WebPartCount
            GOTO cleanup
    END
    INSERT INTO WebPartLists(
        tp_SiteId,
        tp_ListId,
        tp_WebId,
        tp_PageUrlID,
        tp_WebPartID,
        tp_UserID,
        tp_Level)
    SELECT
        tp_SiteId,
        tp_ListId,
        tp_WebId,
        tp_PageUrlID,
        idTable1.NewWebPartId,
        tp_UserID,
        @NewLevel
    FROM
        @idTable idTable1 INNER JOIN WebPartLists
    ON
        WebPartLists.tp_WebPartID = idTable1.OldWebPartId
    WHERE
        WebPartLists.tp_SiteID = @SiteId AND
        WebPartLists.tp_PageUrlID = @OldDocID AND
        WebPartLists.tp_Level = @OldLevel
    IF (@@ERROR <> 0 )
    BEGIN
        RETURN 1150
    END
    INSERT INTO WebParts(
        tp_SiteId,
        tp_ID,
        tp_Level,
        tp_ListId,
        tp_Type,
        tp_Flags,
        tp_BaseViewID,
        tp_DisplayName,
        tp_ContentTypeId,
        tp_Version,
        tp_PageUrlID,
        tp_PartOrder,
        tp_ZoneID,
        tp_IsIncluded,
        tp_FrameState,
        tp_View,
        tp_WebPartTypeId,
        tp_AllUsersProperties,
        tp_PerUserProperties,
        tp_Cache,
        tp_UserID,
        tp_Source,
        tp_Size,
        tp_HasFGP)
    SELECT
        tp_SiteId,
        idTable1.NewWebPartId,
        @NewLevel,
        tp_ListId,
        CASE WHEN tp_Type = 0 THEN 1 ELSE tp_Type END,
        tp_Flags & ~(0 | 1048576),
        tp_BaseViewID,
        tp_DisplayName,
        tp_ContentTypeId,
        tp_Version,
        @NewDocID,
        tp_PartOrder,
        tp_ZoneID,
        tp_IsIncluded,
        tp_FrameState,
        tp_View,
        tp_WebPartTypeId,
        tp_AllUsersProperties,
        tp_PerUserProperties,
        tp_Cache,
        tp_UserID,
        tp_Source,
        tp_Size,
        tp_HasFGP
    FROM
        WebParts INNER JOIN @idTable idTable1
    ON
        WebParts.tp_ID = idTable1.OldWebPartId
    WHERE
        WebParts.tp_SiteID = @SiteId AND
        WebParts.tp_PageUrlID = @OldDocID AND
        WebParts.tp_Level = @OldLevel
    IF (@@ERROR <> 0 )
    BEGIN
        RETURN 1150
    END
    SELECT
        @cbDelta = ISNULL((SUM(CAST((tp_Size) AS BIGINT))), 0)
    FROM
        WebParts
    WHERE
        WebParts.tp_SiteID = @SiteId AND
        WebParts.tp_PageUrlID = @NewDocID
    INSERT INTO Personalization(
        tp_SiteId,
        tp_WebPartID,
        tp_PageUrlID,
        tp_UserID,
        tp_PartOrder,
        tp_ZoneID,
        tp_IsIncluded,
        tp_FrameState,
        tp_PerUserProperties,
        tp_Cache,
        tp_Size)
    SELECT
        Personalization.tp_SiteId,
        idTable1.NewWebPartId,
        @NewDocID,
        Personalization.tp_UserID,
        Personalization.tp_PartOrder,
        Personalization.tp_ZoneID,
        Personalization.tp_IsIncluded,
        Personalization.tp_FrameState,
        Personalization.tp_PerUserProperties,
        Personalization.tp_Cache,
        Personalization.tp_Size
    FROM
        Personalization INNER JOIN WebParts
    ON
        Personalization.tp_SiteID = WebParts.tp_SiteID AND
        Personalization.tp_SiteID = @SiteId AND
        Personalization.tp_WebPartID = WebParts.tp_ID
        INNER JOIN @idTable idTable1
    ON
        WebParts.tp_ID = idTable1.OldWebPartId
    WHERE
        WebParts.tp_SiteID = @SiteId AND
        WebParts.tp_PageUrlID = @OldDocID
    IF (@@ERROR <> 0 )
    BEGIN
        RETURN 1150
    END
    IF @cbDelta > 0
    BEGIN
        SELECT
            @cbDelta = @cbDelta + ISNULL((SUM(CAST((tp_Size) AS BIGINT))), 0)
        FROM
            Personalization
        WHERE
            Personalization.tp_SiteID = @SiteId AND
            Personalization.tp_PageUrlID = @NewDocID
        EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, @cbDelta, 0
    END
    INSERT INTO Links  (
        SiteId,
        DirName,
        LeafName,
        Level,
        FieldId,
        WebPartId,
        TargetDirName,
        TargetLeafName,
        Type,
        Security,
        Dynamic,
        ServerRel,
        PointsToDir,
        LinkNumber)
    SELECT
        @SiteId,
        @NewUrlDirName,
        @NewUrlLeafName,
        @NewLevel,
        FieldId,
        idTable1.NewWebPartId,
        TargetDirName,
        CASE
        WHEN (TargetDirName = @OldUrlDirName AND
            TargetLeafName = @OldUrlLeafName)
        THEN
            @NewUrlLeafName
        ELSE
            TargetLeafName
        END AS NewTargetLeafName,
        Type,
        Security,
        Dynamic,
        ServerRel,
        PointsToDir,
        LinkNumber
    FROM
        Links INNER JOIN @idTable idTable1
    ON
        Links.WebPartId = idTable1.OldWebPartId
    WHERE
        SiteId = @SiteId AND
        DirName = @OldUrlDirName AND
        LeafName = @OldUrlLeafName AND
        Level = @OldLevel AND
        WebPartId IS NOT NULL
cleanup:
    IF (0 <> @@ERROR OR 0 <> @Ret)
    BEGIN
        RETURN CASE WHEN (0 = @Ret) THEN 1150 ELSE @Ret END
    END
    RETURN 0

GO
