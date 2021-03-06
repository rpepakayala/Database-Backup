/****** Object:  StoredProcedure [dbo].[proc_AddSubscription]    Script Date: 5/15/2018 12:11:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddSubscription(
    @SiteId             uniqueidentifier,
    @NotifyFreq         int,
    @NotifyTime         datetime,
    @NotifyTimeUTC      datetime,
    @Status             tinyint,
    @WebId              uniqueidentifier,
    @ListId             uniqueidentifier,
    @ItemId             int,
    @EventType          int,
    @UserId             int,
    @SiteUrl            nvarchar(64),
    @WebUrl             nvarchar(256),
    @WebTitle           nvarchar(255),
    @WebLanguage        int,
    @WebLocale          int,
    @WebTimeZone        smallint,
    @WebTime24          bit,
    @WebCalendarType        smallint,
    @WebAdjustHijriDays     smallint,
    @ListUrl            nvarchar(256),
    @ListTitle          nvarchar(255),
    @ListBaseType       int,
    @ListServerTemplate int,
    @AlertTitle         nvarchar(1000),
    @AlertType          int,
    @AlertTemplateName    nvarchar(256),
    @Filter             nvarchar(4000),
    @BinaryFilter       varbinary(1024),
    @Properties         ntext,
    @ItemDocUrl         nvarchar(260),
    @ItemDocId          uniqueidentifier,
    @Max                int,
    @NewSubId           uniqueidentifier = NULL OUTPUT,
    @UserEmail          nvarchar(255) = NULL OUTPUT,
    @ItemName           nvarchar(255) = NULL OUTPUT)
AS
    SET NOCOUNT ON
    IF (@Max IS NOT NULL AND @Max >= 0 AND @UserId <> 0)
    BEGIN
        DECLARE @Count int
        DECLARE @Total int
        SELECT
            @Total = COUNT(*)
        FROM
            ImmedSubscriptions
        WHERE
            SiteId      = @SiteId       AND
            WebId       = @WebId        AND
            UserId      = @UserId       AND
            Deleted     = 0
        SELECT
            @Count = COUNT(*)
        FROM
            SchedSubscriptions
        WHERE
            SiteId      = @SiteId       AND
            WebId       = @WebId        AND
            UserId      = @UserId       AND
            Deleted     = 0
        SET @Total = @Total + @Count
        IF (@Total >= @Max)
            RETURN 68
    END
    SELECT
        @UserEmail  = tp_Email
    FROM
        UserInfo
    WHERE
        tp_SiteID   = @SiteId AND
        tp_ID       = @UserId
    IF (@ItemId IS NOT NULL AND @ItemDocId IS NULL)
    BEGIN
        IF (@ItemDocUrl IS NOT NULL)
        BEGIN
            DECLARE @DirName    nvarchar(256)
            DECLARE @LeafName   nvarchar(128)
            EXEC proc_SplitUrl @ItemDocUrl, @DirName OUTPUT, @LeafName OUTPUT
            SELECT
                @ItemDocId  = Id,
                @ItemName   = LeafName
            FROM
                Docs
            WHERE
                SiteId      = @SiteId       AND
                DirName     = @DirName      AND
                LeafName    = @LeafName
        END
        ELSE
        BEGIN
            SELECT
                @ItemName   = CASE
                    WHEN (@ListBaseType = 5 OR
                        @ListServerTemplate = 103)
                    THEN NULL
                    ELSE nvarchar1
                    END
            FROM
                UserData
            WHERE
                tp_ListId   = @ListId   AND
                tp_ID       = @ItemId AND
                tp_RowOrdinal = 0
        END
    END
    SET @NewSubId = NEWID()
    DECLARE @Ret int
    SET @Ret = 1359
    BEGIN TRAN
    IF @NotifyFreq = 0
    BEGIN
        INSERT INTO ImmedSubscriptions(
            Id,
            SiteId,
            WebId,
            ListId,
            ItemId,
            EventType,
            UserId,
            UserEmail,
            SiteUrl,
            WebUrl,
            WebTitle,
            WebLanguage,
            WebLocale,
            WebTimeZone,
            WebTime24,
            WebCalendarType,
            WebAdjustHijriDays,
            ListUrl,
            ListTitle,
            ListBaseType,
            ListServerTemplate,
            Status,
            AlertTitle,
            AlertType,
            AlertTemplateName,
            Filter,
            BinaryFilter,
            Properties,
            ItemDocId)
        VALUES(
            @NewSubId,
            @SiteId,
            @WebId,
            @ListId,
            @ItemId,
            @EventType,
            @UserId,
            COALESCE (@UserEmail,N''),
            @SiteUrl,
            @WebUrl,
            @WebTitle,
            @WebLanguage,
            @WebLocale,
            @WebTimeZone,
            @WebTime24,
            @WebCalendarType,
            @WebAdjustHijriDays,
            @ListUrl,
            @ListTitle,
            @ListBaseType,
            @ListServerTemplate,
            @Status,
            @AlertTitle,
            @AlertType,
            @AlertTemplateName,
            @Filter,
            @BinaryFilter,
            @Properties,
            @ItemDocId)
    END
    ELSE
    BEGIN
        INSERT INTO SchedSubscriptions(
            Id,
            SiteId,
            NotifyFreq,
            WebId,
            ListId,
            ItemId,
            EventType,
            UserId,
            UserEmail,
            SiteUrl,
            WebUrl,
            WebTitle,
            WebLanguage,
            WebLocale,
            WebTimeZone,
            WebTime24,
            WebCalendarType,
            WebAdjustHijriDays,
            ListUrl,
            ListTitle,
            ListBaseType,
            ListServerTemplate,
            NotifyTime,
            NotifyTimeUTC,
            Status,
            AlertTitle,
            AlertType,
            AlertTemplateName,
            Filter,
            BinaryFilter,
            Properties,
            ItemDocId)
        VALUES(
            @NewSubId,
            @SiteId,
            @NotifyFreq,
            @WebId,
            @ListId,
            @ItemId,
            @EventType,
            @UserId,
            @UserEmail,
            @SiteUrl,
            @WebUrl,
            @WebTitle,
            @WebLanguage,
            @WebLocale,
            @WebTimeZone,
            @WebTime24,
            @WebCalendarType,
            @WebAdjustHijriDays,
            @ListUrl,
            @ListTitle,
            @ListBaseType,
            @ListServerTemplate,
            @NotifyTime,
            @NotifyTimeUTC,
            @Status,
            @AlertTitle,
            @AlertType,
            @AlertTemplateName,
            @Filter,
            @BinaryFilter,
            @Properties,
            @ItemDocId)
    END
    IF (@@ERROR <> 0)
    BEGIN
        SET @Ret = 31
        GOTO cleanup
    END
    EXEC proc_SecUpdateUserActiveStatus @SiteId, @UserId
    EXEC proc_LogChange @SiteId, @WebId, @ListId, @ItemId, NULL, @NewSubId,
        NULL, NULL, 4096,  64, NULL
    UPDATE
        Lists
    SET
        tp_Subscribed = 1
    WHERE
        Lists.tp_WebId  = @WebId            AND
        Lists.tp_ID     = @ListId
    IF (@@ERROR <> 0)
    BEGIN
        SET @Ret = 31
        GOTO cleanup
    END
    UPDATE
        Sites
    SET
        Subscribed = 1
    WHERE
        Sites.Id = @SiteId
    IF (@@ERROR <> 0)
    BEGIN
        SET @Ret = 31
        GOTO cleanup
    END
    SET @Ret = 0
cleanup:
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Ret

GO
