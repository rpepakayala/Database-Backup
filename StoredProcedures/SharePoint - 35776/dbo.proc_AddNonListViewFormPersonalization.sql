/****** Object:  StoredProcedure [dbo].[proc_AddNonListViewFormPersonalization]    Script Date: 5/15/2018 12:11:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddNonListViewFormPersonalization(
    @SiteId uniqueidentifier,
    @DocId uniqueidentifier,
    @WebPartId uniqueidentifier,
    @UserId int,
    @PartOrder int,
    @ZoneId nvarchar(64),
    @IsIncluded bit,
    @FrameState tinyint,
    @UserProperties image)
AS
    SET NOCOUNT ON
    DECLARE @Ret int
    DECLARE @bExists bit
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
    SET @Ret = 0
    IF NOT EXISTS
        (SELECT 1
         FROM
             WebParts
         WHERE
             tp_SiteId = @SiteId AND
             tp_ID = @WebPartId AND
             tp_PageUrlID = @DocId)
    BEGIN
        RETURN 2
    END
    IF EXISTS
        (SELECT 1
         FROM
             Personalization
         WHERE
             tp_SiteId = @SiteId AND
             tp_WebPartID = @WebPartId AND
             tp_UserId = @UserId AND
             tp_PageUrlID = @DocId)
    BEGIN
        SET @bExists = 1
    END
    ELSE
    BEGIN
        SET @bExists = 0
    END
    BEGIN TRAN
    DECLARE @cbDelta bigint
    SET @cbDelta = 66 + ISNULL(DATALENGTH(@UserProperties), 0) + ISNULL(DATALENGTH(NULL), 0)
    EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, @cbDelta, 0
    IF @bExists = 0
    BEGIN
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
            tp_Size)
        VALUES (
            @SiteId,
            @WebPartId,
            @DocId,
            @UserId,
            @PartOrder,
            @ZoneId,
            @IsIncluded,
            @FrameState,
            @UserProperties,
            @cbDelta)
    END
    ELSE
    BEGIN
        UPDATE Personalization
        SET
            tp_PartOrder = @PartOrder,
            tp_ZoneID = @ZoneId,
            tp_IsIncluded =
                CASE
                    WHEN @IsIncluded IS NULL THEN tp_IsIncluded
                    ELSE @IsIncluded
                END,
            tp_FrameState =
                CASE
                    WHEN @FrameState IS NULL THEN tp_FrameState
                    ELSE @FrameState
                END,
            tp_PerUserProperties =
                CASE
                   WHEN @UserProperties IS NULL THEN 0x
                   ELSE @UserProperties
                END,
            tp_Size = @cbDelta
        WHERE
            tp_SiteId = @SiteId AND
            tp_WebPartID = @WebPartId AND
            tp_UserID = @UserId AND
            tp_PageUrlID = @DocId
    END
   IF (@@ERROR <> 0 OR @Ret <> 0)
    BEGIN
        IF (@Ret = 0)
            SET @Ret = 1
    END
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Ret

GO
