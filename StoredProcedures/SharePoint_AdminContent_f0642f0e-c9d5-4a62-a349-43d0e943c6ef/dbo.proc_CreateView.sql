/****** Object:  StoredProcedure [dbo].[proc_CreateView]    Script Date: 5/15/2018 12:12:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CreateView(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ViewId uniqueidentifier,
    @Level tinyint,
    @ListId uniqueidentifier,
    @Type tinyint,
    @Flags int,
    @BaseViewID tinyint,
    @DisplayName nvarchar(255),
    @ContentTypeId tContentTypeId,
    @DocId uniqueidentifier,
    @WebPartTypeId uniqueidentifier,
    @ZoneId nvarchar(64),
    @PartOrder int,
    @ViewOrder int,
    @View ntext ,
    @source ntext = NULL)
AS
    SET NOCOUNT ON
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
        DECLARE @cbDelta bigint
        SET @cbDelta = 116 + ISNULL(DATALENGTH(@View), 0) + ISNULL(DATALENGTH(NULL), 0) + ISNULL(DATALENGTH(NULL), 0) + ISNULL(DATALENGTH(NULL), 0) + ISNULL(DATALENGTH(@source), 0)
        SET @ContentTypeId = ISNULL(@ContentTypeId, 0x)
        BEGIN TRAN
        DECLARE @Ret int
        SET @Ret = 0        
        IF (0 <> @@ERROR)
            GOTO cleanup
        DECLARE @DocWebId uniqueidentifier
        SELECT
            @DocWebId = WebId
        FROM
            Docs WITH (NOLOCK)
        WHERE
            Id = @DocId
        IF (@DocWebId IS NOT NULL AND @DocWebId <> @WebId)
        BEGIN
            SET @Ret = 3
            GOTO CLEANUP
        END
    DECLARE @bHasFGP bit
    SELECT
        @bHasFGP = tp_HasFGP
    FROM
        Lists
    WHERE
        tp_WebId = @WebId AND
        tp_Id = @ListId
    INSERT INTO WebPartLists(
        tp_SiteId,
        tp_WebPartID,
        tp_Level,
        tp_ListId,
        tp_WebId,
        tp_PageUrlID
        )
    VALUES (
        @SiteId,
        @ViewId,
        @Level,
        @ListId,
        @WebId,
        @DocId)
    IF (0 <> @@ERROR)
        GOTO cleanup
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
        tp_WebPartTypeId,
        tp_ZoneID,
        tp_PartOrder,
        tp_CreationTime,
        tp_View,
        tp_Source,
        tp_Size,
        tp_HasFGP
        )
    VALUES (
        @SiteId,
        @ViewId,
        @Level,
        @ListId,
        @Type,
        @Flags,
        @BaseViewID,
        @DisplayName,
        @ContentTypeId,
        1,
        @DocId,
        @WebPartTypeId,
        @ZoneId,
        @PartOrder,
        CASE WHEN @ViewOrder IS NULL THEN
            GETUTCDATE()
        ELSE
            CAST(@ViewOrder AS datetime)
        END,
        CASE
            WHEN DATALENGTH(@View) = 0 THEN
                NULL
            ELSE
                @View
        END,
        @source,
        @cbDelta,
        @bHasFGP)      
        IF (0 <> @@ERROR)
            GOTO cleanup
        IF ((@Flags & 16777216) <> 0)
        BEGIN
            EXEC @Ret = proc_MakeViewMobileDefaultForList @ListId, @ViewId
            IF (0 <> @Ret)
                GOTO cleanup
        END
        ELSE IF ((@Flags & 8388608) <> 0)
        BEGIN
            EXEC @Ret = proc_EnsureMobileDefaultViewForList @ListId
            IF (0 <> @Ret)
                GOTO cleanup
        END
        IF ((@Flags & 268435456) <> 0)
        BEGIN
            EXEC @Ret = proc_MakeViewDefaultForContentType @ListId, @ViewId, @ContentTypeId
            IF (0 <> @Ret)
                GOTO cleanup
        END
cleanup:
    IF @Ret = 0 AND @@Error <> 0
        SET @Ret = 1
    IF (@Ret = 0 AND @BaseViewID IS NOT NULL)
    BEGIN
        EXEC proc_LogChange @SiteId, @WebId, @ListId, NULL, NULL,
            @ViewId, NULL, NULL, 4096, 4096, NULL
    END
    IF (@Ret=0)
    BEGIN
        EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, @cbDelta, 0
    END
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN    
    RETURN @Ret

GO
