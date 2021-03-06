/****** Object:  StoredProcedure [dbo].[proc_DeleteWebPartWhileSaving]    Script Date: 5/15/2018 12:11:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteWebPartWhileSaving(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @Level tinyint,
    @WebPartID uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @DocId uniqueidentifier
    DECLARE @PartDocId uniqueidentifier
    DECLARE @UserId int
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
    IF @DocId IS NULL
    BEGIN
        RETURN 2
    END
    IF (@IsCurrentVersion = 0)
    BEGIN
        RETURN 33
    END
    SELECT
        @PartDocId=tp_PageUrlID,
        @UserId = tp_UserID
    FROM
        WebParts
    WHERE
        tp_SiteID = @SiteId AND
        tp_ID = @WebPartID AND
        tp_Level = @Level
    IF (@DocId <> @PartDocId OR @UserId IS NOT NULL)
    BEGIN
        RETURN 5
    END
    DELETE FROM
        Links
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        WebPartId = @WebPartID AND
        FieldId IS NULL AND
        Level = @Level
    IF (@@ERROR <> 0)
    BEGIN
        SET @Ret = 1
        GOTO cleanup
    END
    DELETE
        WebPartLists
    WHERE
        tp_SiteId = @SiteId AND
        tp_WebPartID = @WebPartID AND
        tp_PageUrlID = @PartDocId AND
        tp_Level = @Level
    IF (@@ERROR <> 0)
    BEGIN
        SET @Ret = 1
        GOTO cleanup
    END
    DELETE FROM
        WebParts
    WHERE
        WebParts.tp_SiteID = @SiteId AND
        WebParts.tp_ID = @WebPartID AND
        WebParts.tp_Level = @Level
    IF (@@ERROR <> 0)
    BEGIN
        SET @Ret = 1
        GOTO cleanup
    END
cleanup:
    RETURN @Ret

GO
