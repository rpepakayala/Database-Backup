/****** Object:  StoredProcedure [dbo].[proc_ModifySubscription]    Script Date: 5/15/2018 12:12:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ModifySubscription(
    @SiteId             uniqueidentifier,
    @SubId              uniqueidentifier,
    @NotifyFreq         int,
    @NotifyTime         datetime,
    @NotifyTimeUTC      datetime,
    @Status             tinyint,
    @WebId              uniqueidentifier,
    @EventType          int,
    @UserId             int,
    @SiteUrl            nvarchar(64),
    @WebUrl             nvarchar(256),
    @WebTitle           nvarchar(255),
    @WebLanguage        int,
    @WebLocale          int,
    @WebTimeZone        smallint,
    @WebTime24          bit,
    @WebCalendarType    smallint,
    @WebAdjustHijriDays smallint,
    @AlertTitle         nvarchar(1000),
    @AlertType          int,
    @AlertTemplateName    nvarchar(256),
    @Filter              nvarchar(4000) ,
    @BinaryFilter       varbinary(1024),
    @Properties         ntext,
    @UserEmail          nvarchar(255) = NULL OUTPUT,
    @ItemName           nvarchar(255) = NULL OUTPUT,
    @ItemId             int OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @NotifyFreqOld      int
    DECLARE @ListId             uniqueidentifier
    DECLARE @ListUrl            nvarchar(256)
    DECLARE @ListTitle          nvarchar(255)
    DECLARE @ItemDocId          uniqueidentifier
    DECLARE @ListBaseType       int
    DECLARE @ListServerTemplate int
    SELECT
        @NotifyFreqOld      = 0,
        @ListId             = ListId,
        @ItemId             = ItemId,
        @ListUrl            = ListUrl,
        @ListTitle          = ListTitle,
        @ListBaseType       = ListBaseType,
        @ListServerTemplate = ListServerTemplate,
        @ItemDocId          = ItemDocId
    FROM
        ImmedSubscriptions
    WHERE
        SiteId              = @SiteId   AND
        Id                  = @SubId
    IF (@@ROWCOUNT = 0)
    BEGIN
        SELECT
            @NotifyFreqOld      = NotifyFreq,
            @ListId             = ListId,
            @ItemId             = ItemId,
            @ListUrl            = ListUrl,
            @ListTitle          = ListTitle,
            @ListBaseType       = ListBaseType,
            @ListServerTemplate = ListServerTemplate,
            @ItemDocId          = ItemDocId
        FROM
            SchedSubscriptions
        WHERE
            SiteId              = @SiteId   AND
            Id                  = @SubId
        IF (@@ROWCOUNT = 0)
            RETURN 31
    END
    DECLARE @Ret int
    SET @Ret = 1359
    BEGIN TRAN
    SET @UserEmail = ''
    SELECT
        @UserEmail  = tp_Email
    FROM
        UserInfo
    WHERE
        tp_SiteID   = @SiteId AND
        tp_ID       = @UserId
    IF (@ItemDocId IS NOT NULL)
    BEGIN
        SELECT
            @ItemName = LeafName
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            Id = @ItemDocId
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
    IF @NotifyFreq = 0
    BEGIN
        IF @NotifyFreqOld = 0
        BEGIN
            UPDATE
                ImmedSubscriptions
            SET
                UserId            = @UserId,
                UserEmail         = @UserEmail,
                EventType         = @EventType,
                AlertTitle        = @AlertTitle,
                AlertType         = @AlertType,
                AlertTemplateName   = @AlertTemplateName,
                Filter            = @Filter,
                BinaryFilter      = @BinaryFilter,
                Status            = @Status,
                Properties        = @Properties
            WHERE
                SiteId      = @SiteId   AND
                Id          = @SubId
        END
        ELSE
        BEGIN
            DELETE
                EventSubsMatches 
            WHERE
                SubId = @SubId
            DELETE
                SchedSubscriptions
            WHERE
                SiteId      = @SiteId   AND
                Id          = @SubId
            IF (@@ERROR <> 0)
            BEGIN
                SET @Ret = 31
                GOTO cleanup
            END
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
                @SubId,
                @SiteId,
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
                @Status,
                @AlertTitle,
                @AlertType,
                @AlertTemplateName,
                @Filter,
                @BinaryFilter,
                @Properties,
                @ItemDocId)
        END
    END
    ELSE
    BEGIN
        IF @NotifyFreqOld <> 0
        BEGIN
            UPDATE
                SchedSubscriptions
            SET
                UserId            = @UserId,
                UserEmail         = @UserEmail,
                EventType         = @EventType,
                AlertTitle        = @AlertTitle,
                AlertType         = @AlertType,
                AlertTemplateName   = @AlertTemplateName,
                Filter            = @Filter,
                BinaryFilter      = @BinaryFilter,
                NotifyTime        = @NotifyTime,
                NotifyTimeUTC     = @NotifyTimeUTC,
                Status            = @Status,
                Properties        = @Properties
            WHERE
                SiteId      = @SiteId   AND
                Id          = @SubId
            IF @NotifyFreqOld <> @NotifyFreq
            BEGIN
                UPDATE
                    SchedSubscriptions
                SET
                    NotifyFreq  = @NotifyFreq
                WHERE
                    SiteId      = @SiteId   AND
                    Id          = @SubId
            END
        END
        ELSE
        BEGIN
            DELETE
                ImmedSubscriptions
            WHERE
                SiteId      = @SiteId   AND
                Id          = @SubId
            IF (@@ERROR <> 0)
            BEGIN
                SET @Ret = 31
                GOTO cleanup
            END
            INSERT INTO SchedSubscriptions(
                Id,
                SiteId,
                NotifyFreq,
                NotifyTime,
                NotifyTimeUTC,
                Status,
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
                AlertTitle,
                AlertType,
                AlertTemplateName,
                Filter,
                BinaryFilter,
                Properties,
                ItemDocId)
            VALUES(
                @SubId,
                @SiteId,
                @NotifyFreq,
                @NotifyTime,
                @NotifyTimeUTC,
                @Status,
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
                @AlertTitle,
                @AlertType,
                @AlertTemplateName,
                @Filter,
                @BinaryFilter,
                @Properties,
                @ItemDocId)
        END
    END
    IF (@@ERROR <> 0)
    BEGIN
        SET @Ret = 31
        GOTO cleanup
    END
    EXEC proc_SecUpdateUserActiveStatus @SiteId, @UserId
    EXEC proc_LogChange @SiteId, @WebId, @ListId, @ItemId, NULL, @SubId, NULL,
        NULL, 8192,  64, NULL
    SET @Ret = 0
cleanup:
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Ret

GO
