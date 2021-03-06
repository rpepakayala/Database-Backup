/****** Object:  StoredProcedure [dbo].[proc_ProvisionWebPart]    Script Date: 5/15/2018 12:12:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ProvisionWebPart(
    @SiteId uniqueidentifier,
    @DocID uniqueidentifier,
    @WebPartID uniqueidentifier,
    @Level tinyint,
    @IsIncluded bit,
    @FrameState tinyint,
    @ZoneID nvarchar(64),
    @PartOrder int,
    @Source ntext)
AS
    SET NOCOUNT ON
    DECLARE @cbDelta bigint
    DECLARE @Ret int
    SET @Ret = 0
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
    SET @cbDelta = 116 + ISNULL(DATALENGTH(NULL), 0) + ISNULL(DATALENGTH(NULL), 0) + ISNULL(DATALENGTH(NULL), 0) + ISNULL(DATALENGTH(NULL), 0) + ISNULL(DATALENGTH(@Source), 0)
    BEGIN TRAN
    EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, @cbDelta, 0
    INSERT INTO dbo.WebParts (
        tp_SiteId,
        tp_ID,
        tp_Level,
        tp_ZoneID,
        tp_PartOrder,
        tp_IsIncluded,
        tp_FrameState,
        tp_Source,
        tp_PageUrlID,
        tp_Size)
    VALUES (
        @SiteId,
        @WebPartID,
        @Level,
        @ZoneID,
        @PartOrder,
        @IsIncluded,
        @FrameState,
        @Source,
        @DocID,
        @cbDelta)
    IF (@@ERROR <> 0 OR @Ret <> 0)
    BEGIN
        IF (@Ret = 0)
            SET @Ret = 1
        GOTO cleanup
    END
cleanup:
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Ret

GO
