/****** Object:  StoredProcedure [dbo].[proc_DeleteZoneWebPartsWhileSaving]    Script Date: 5/15/2018 12:12:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteZoneWebPartsWhileSaving(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @PageUrlID uniqueidentifier,
    @Level tinyint,
    @WebPartZoneID nvarchar(64))
AS
    SET NOCOUNT ON
    DECLARE @DocId uniqueidentifier
    DECLARE @IsCurrentVersion bit
    DECLARE @Ret int
    SET @Ret = 0
    SELECT
        @DocId = Id,
        @IsCurrentVersion = IsCurrentVersion
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        Level = @Level
    IF (@IsCurrentVersion = 0)
    BEGIN
        RETURN 33
    END
    DELETE FROM
        Links
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        Level = @Level AND
        FieldId IS NULL AND
        WebPartId IN (
            SELECT
                tp_ID
            FROM
                WebParts
            WHERE
                WebParts.tp_SiteID = @SiteId AND
                WebParts.tp_PageUrlID = @PageUrlID AND
                WebParts.tp_Level = @Level AND
                WebParts.tp_UserID IS NULL AND
                WebParts.tp_ZoneID = @WebPartZoneID)
    IF (@@ERROR <> 0)
    BEGIN
        SET @Ret = 1
        GOTO cleanup
    END
    DELETE
        WebPartLists
    FROM
        WebParts WITH (NOLOCK) INNER JOIN WebPartLists
    ON
        WebParts.tp_SiteId = WebPartLists.tp_SiteId AND
        WebParts.tp_PageUrlID = WebPartLists.tp_PageUrlID AND
        WebParts.tp_Level = WebPartLists.tp_Level AND
        WebParts.tp_UserID = WebPartLists.tp_UserID AND
        WebParts.tp_ID = WebPartLists.tp_WebPartID
    WHERE
        WebParts.tp_SiteID = @SiteID AND
        WebParts.tp_PageUrlID = @PageUrlID AND
        WebParts.tp_UserID IS NULL AND
        WebParts.tp_ZoneID = @WebPartZoneID AND
        WebParts.tp_Level = @Level
    IF (@@ERROR <> 0)
    BEGIN
        SET @Ret = 1
        GOTO cleanup
    END
    DELETE FROM
        WebParts
    WHERE
        WebParts.tp_SiteID = @SiteID AND
        WebParts.tp_PageUrlID = @PageUrlID AND
        WebParts.tp_UserID IS NULL AND
        WebParts.tp_ZoneID = @WebPartZoneID AND
        WebParts.tp_level = @Level
    IF (@@ERROR <> 0)
    BEGIN
        SET @Ret = 1
        GOTO cleanup
    END
    UPDATE
        Personalization
    SET
        tp_ZoneID = wp.tp_ZoneID
    FROM
        Personalization p, WebParts wp
    WHERE
        p.tp_SiteID = wp.tp_SiteID AND
        p.tp_SiteID = @SiteID AND
        p.tp_WebPartID = wp.tp_ID AND
        wp.tp_PageUrlID = @PageUrlID AND
        p.tp_PageUrlID = @PageUrlID AND
        p.tp_ZoneID = @WebPartZoneID
    IF (@@ERROR <> 0)
    BEGIN
        SET @Ret = 1
        GOTO cleanup
    END
cleanup:
    RETURN @Ret

GO
