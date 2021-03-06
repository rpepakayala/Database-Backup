/****** Object:  StoredProcedure [dbo].[proc_AddWebPart]    Script Date: 5/15/2018 12:12:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddWebPart(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @Level tinyint OUTPUT,
    @bAllUser bit,
    @UserId int,
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
    DECLARE @DocID uniqueidentifier
    DECLARE @Ret int
    DECLARE @IsCurrentVersion bit
    DECLARE @IsForceCheckout bit
    DECLARE @EnableMinorVersions bit
    DECLARE @IsModerate bit
    DECLARE @WebId uniqueidentifier
    DECLARE @ListId uniqueidentifier
    DECLARE @ItemId int
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
        @DocID = Id,
        @IsCurrentVersion = IsCurrentVersion,
        @WebId = WebId,
        @ListId = ListId,
        @ItemId = DoclibRowId
    FROM
        Docs
    LEFT OUTER JOIN
        Lists WITH (NOLOCK)
    ON
        Lists.tp_ID = Docs.ListId AND
        Lists.tp_WebId = Docs.WebId AND
        Docs.DoclibRowId IS NOT NULL
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @DirName AND
        Docs.LeafName = @LeafName AND
        Docs.Level = @Level
    IF (@IsForceCheckout = 1 AND @Level <> 255 AND @bAllUser = 1)
        RETURN 158
    IF @DocID IS NULL
    BEGIN
        RETURN 2
    END
    IF @bCheckLock = 1
    BEGIN
    IF (@bAllUser = 1) AND (@IsCurrentVersion = 0)
        BEGIN
            RETURN 33
        END
        IF (@bAllUser = 0) AND (@Level = 255)
        BEGIN
            RETURN 12
        END
    END
    BEGIN TRAN
    IF (@EnableMinorVersions = 1 OR @IsModerate = 1 ) AND
        @Level = 1 AND @bAllUser = 1 AND
        @ItemId IS NOT NULL AND
        @bCheckLock = 1
    BEGIN
        EXEC @Ret  = proc_CloneDoc  @SiteId,
                      @DirName,
                      @LeafName,
                      NULL,
                      NULL,
                      NULL,
                      @Level,
                      2,
                      @EnableMinorVersions,
                      @IsModerate,
                      @UserId,
                      NULL
        IF (@@ERROR <> 0 OR @Ret <> 0)
        BEGIN
            IF (@Ret = 0)
                SET @Ret = 1
            GOTO cleanup
        END
        SET @Level = 2
    END
    DECLARE @cbDelta bigint
    SET @cbDelta = 116 + ISNULL(DATALENGTH(NULL), 0) + ISNULL(DATALENGTH(@AllUsersProperties), 0) + ISNULL(DATALENGTH(@PerUserProperties), 0) + ISNULL(DATALENGTH(NULL), 0) + ISNULL(DATALENGTH(NULL), 0)
    EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, @cbDelta, 0
    IF @bAllUser = 1
        SET @UserId = NULL
    INSERT INTO dbo.WebParts (
        tp_SiteId,
        tp_ID,
        tp_AllUsersProperties,
        tp_PerUserProperties,
        tp_ZoneID,
        tp_PartOrder,
        tp_IsIncluded,
        tp_FrameState,
        tp_PageUrlID,
        tp_WebPartTypeId,
        tp_UserID,
        tp_Size,
        tp_Level)
    VALUES (
        @SiteId,
        @WebPartID,
        @AllUsersProperties,
        @PerUserProperties,
        @ZoneID,
        @PartOrder,
        @IsIncluded,
        @FrameState,
        @DocID,
        @WebPartTypeID,
        @UserId,      
        @cbDelta,
        @Level)
    IF (@@ERROR <> 0 OR @Ret <> 0)
    BEGIN
        IF (@Ret = 0)
            SET @Ret = 1
        GOTO cleanup
    END
cleanup:
    if (0 = @Ret)
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
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Ret

GO
