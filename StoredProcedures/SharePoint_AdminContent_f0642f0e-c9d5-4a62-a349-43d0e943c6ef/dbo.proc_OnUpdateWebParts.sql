/****** Object:  StoredProcedure [dbo].[proc_OnUpdateWebParts]    Script Date: 5/15/2018 12:12:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_OnUpdateWebParts(
    @SiteId uniqueidentifier,
    @WebPartId uniqueidentifier,
    @Level tinyint,
    @NewSizeView int,
    @NewSizeAllUsersProperties int,
    @NewSizePerUserProperties int,
    @NewSizeCache int,
    @NewSizeSource int,
    @DeleteTransactionId uniqueidentifier,
    @@NewSize bigint OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @cbDelta bigint
    DECLARE @currentSize bigint
    DECLARE @existingSizeOfChangingColumns bigint
    DECLARE @NewSizeOfChangingColumns bigint
    DECLARE @Ret int
    SET @Ret = 0
    IF (COALESCE(
        @NewSizeView,
        @NewSizeAllUsersProperties,
        @NewSizePerUserProperties,
        @NewSizeCache,
        @NewSizeSource) IS NOT NULL)
    BEGIN
        SET @NewSizeOfChangingColumns =
            ISNULL(@NewSizeView, 0)
            + ISNULL(@NewSizeAllUsersProperties, 0)
            + ISNULL(@NewSizePerUserProperties, 0)
            + ISNULL(@NewSizeCache, 0)
            + ISNULL(@NewSizeSource, 0)
        SELECT
            @currentSize = tp_Size,
            @existingSizeOfChangingColumns =
                CASE WHEN (@NewSizeView IS NULL)
                    THEN 0 ELSE ISNULL(DATALENGTH(tp_View), 0) END
                + CASE WHEN (@NewSizeAllUsersProperties IS NULL)
                    THEN 0 ELSE ISNULL(DATALENGTH(tp_AllUsersProperties), 0) END
                + CASE WHEN (@NewSizePerUserProperties IS NULL)
                    THEN 0 ELSE ISNULL(DATALENGTH(tp_PerUserProperties), 0) END
                + CASE WHEN (@NewSizeCache IS NULL)
                    THEN 0 ELSE ISNULL(DATALENGTH(tp_Cache), 0) END
                + CASE WHEN (@NewSizeSource IS NULL)
                    THEN 0 ELSE ISNULL(DATALENGTH(tp_Source), 0) END
        FROM
            WebParts
        WHERE
            tp_SiteID = @SiteId AND
            tp_ID = @WebPartId AND
            tp_Level = @Level
        SET @cbDelta = @NewSizeOfChangingColumns - @existingSizeOfChangingColumns
        IF (@cbDelta > 0)
        BEGIN
            DECLARE @quotaOrLockStatus int
            SELECT  @quotaOrLockStatus = dbo.fn_IsOverQuotaOrWriteLocked(@SiteId)
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
        END
        IF (@DeleteTransactionId IS NULL OR
            @DeleteTransactionId = '00000000-0000-0000-0000-000000000000')
        BEGIN
            EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp
                @SiteId, @cbDelta, 0
        END
        ELSE
        BEGIN
            DECLARE @BinId int
            SELECT
                @BinId = BinId
            FROM
                RecycleBin
            WHERE
                SiteId = @SiteId AND
                DeleteTransactionId = @DeleteTransactionId
            IF @BinId IS NULL
                RETURN 1359
            UPDATE
                RecycleBin
            SET
                Size = Size + @cbDelta
            WHERE
                SiteId = @SiteId AND
                DeleteTransactionId = @DeleteTransactionId
            IF @BinId = 1
            BEGIN
                EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp
                    @SiteId, @cbDelta, 0
            END
            ELSE
            BEGIN
                UPDATE
                    Sites
                SET
                    SecondStageDiskUsed = SecondStageDiskUsed + @cbDelta
                WHERE
                    Id = @SiteId
            END
        END
        SET @@NewSize = @currentSize + @cbDelta
    END
    ELSE
    BEGIN
        SELECT
            @@NewSize = tp_Size
        FROM
            WebParts
        WHERE
            tp_SiteID = @SiteId AND
            tp_ID = @WebPartId AND
            tp_Level = @Level
    END
cleanup:
    IF (0 <> @@ERROR OR 0 <> @Ret)
    BEGIN
        RETURN CASE WHEN (0 = @Ret) THEN -2147467259 ELSE @Ret END
    END
    RETURN 0

GO
