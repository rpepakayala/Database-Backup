/****** Object:  StoredProcedure [dbo].[proc_UpdateUserInfoInTableFromRowUpdater]    Script Date: 5/15/2018 12:13:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateUserInfoInTableFromRowUpdater(
    @SiteId uniqueidentifier,
    @UserId int,
    @Title nvarchar(255) = NULL,
    @Email nvarchar(255) = NULL,
    @IsActive bit = NULL,
    @Locale int = NULL,
    @CalendarType smallint = NULL,
    @AdjustHijriDays smallint = NULL,
    @TimeZone smallint = NULL,
    @Collation smallint = NULL,
    @Time24 bit = NULL,
    @AltCalendarType tinyint = NULL,
    @CalendarViewOptions tinyint = NULL,
    @WorkDays smallint = NULL,
    @WorkDayStartHour smallint = NULL,
    @WorkDayEndHour smallint = NULL)
AS
    SET NOCOUNT ON
    DECLARE @OldIsActive bit
    SELECT
        @OldIsActive = tp_IsActive
    FROM
        UserInfo
    WHERE
        tp_SiteId = @SiteId AND
        tp_ID = @UserId AND
        tp_Deleted = 0
    UPDATE
        UserInfo
    SET
        tp_Title = ISNULL(@Title, N''),
        tp_Email = ISNULL(@Email, N''),
        tp_IsActive = ISNULL(@IsActive, tp_IsActive),
        tp_Locale = @Locale,
        tp_CalendarType = @CalendarType,
        tp_AdjustHijriDays = @AdjustHijriDays,
        tp_TimeZone = @TimeZone,
        tp_Time24 = @Time24,
        tp_AltCalendarType = @AltCalendarType,
        tp_CalendarViewOptions = @CalendarViewOptions,
        tp_WorkDays = @WorkDays,
        tp_WorkDayStartHour = @WorkDayStartHour,
        tp_WorkDayEndHour = @WorkDayEndHour
    WHERE
        tp_SiteID = @SiteId AND
        tp_ID = @UserId
    UPDATE 
        ImmedSubscriptions 
    SET 
        UserEmail = ISNULL(@Email, N'')
    WHERE 
        SiteId = @SiteId AND
        UserId = @UserId
    UPDATE 
        SchedSubscriptions 
    SET 
        UserEmail = ISNULL(@Email, N'')
    WHERE 
        SiteId = @SiteId AND
        UserId = @UserId
    IF @OldIsActive IS NOT NULL 
    BEGIN
        DECLARE @ActivateUserId int
        IF @IsActive = 1 AND
            @OldIsActive <> @IsActive
        BEGIN
            SET @ActivateUserId = @UserId
        END
        EXEC proc_LogChange @SiteId, NULL, NULL, @ActivateUserId, NULL, NULL, @UserId,
            NULL, 8192, 128, NULL
    END

GO
