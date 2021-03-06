/****** Object:  StoredProcedure [dbo].[proc_UpdateWebPartLinks]    Script Date: 5/15/2018 12:12:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateWebPartLinks(
    @SiteId uniqueidentifier,
    @WebPartID uniqueidentifier,
    @Level tinyint,
    @AllUsersProperties image,
    @Source ntext)
AS
    SET NOCOUNT ON
    DECLARE @Ret int
    DECLARE @AllUsersSize int
    DECLARE @SourceSize int
    DECLARE @@NewSize bigint
    SET @Ret = 0
    SET @AllUsersSize = ISNULL(DATALENGTH(@AllUsersProperties), 0)
    SET @SourceSize = ISNULL(DATALENGTH(@Source), 0)
    EXEC @Ret = proc_OnUpdateWebParts
        @SiteId,
        @WebPartID,
        @Level,
        NULL,    
        @AllUsersSize,
        NULL,    
        0,    
        @SourceSize,
        NULL,
        @@NewSize OUTPUT
    IF (@@ERROR <> 0)
    BEGIN
        SET @Ret = -2147467259
        GOTO cleanup
    END
    UPDATE
        WebParts
    SET
        tp_AllUsersProperties = @AllUsersProperties,
        tp_Source = @Source,
        tp_Cache = NULL,
        tp_Size = @@NewSize
    WHERE
        tp_SiteID = @SiteId AND
        tp_ID = @WebPartID AND
        tp_Level = @Level
    IF (@@ERROR <> 0)
    BEGIN
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
    IF NOT EXISTS(
        SELECT
            *
            FROM
                WebParts
        WHERE
            tp_SiteID = @SiteId AND
            tp_ID = @WebPartID AND
            tp_Level = @Level)
    BEGIN
        SET @Ret = 2  
    END
cleanup:
    IF (0 <> @@ERROR OR 0 <> @Ret)
    BEGIN
        RETURN CASE WHEN (0 = @Ret) THEN -2147467259 ELSE @Ret END
    END
    RETURN 0

GO
