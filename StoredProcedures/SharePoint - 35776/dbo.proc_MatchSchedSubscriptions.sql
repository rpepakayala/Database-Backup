/****** Object:  StoredProcedure [dbo].[proc_MatchSchedSubscriptions]    Script Date: 5/15/2018 12:12:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MatchSchedSubscriptions(
    @SiteId     uniqueidentifier,
    @NotifyFreq int,
    @bAlwaysNotify bit,
    @@EventTime datetime OUTPUT)
AS
    SET NOCOUNT ON
    SET @@EventTime = GETUTCDATE()
    IF (@bAlwaysNotify = 0)
    SELECT
        SchedSubscriptions.WebId,
        SchedSubscriptions.ListId,
        SchedSubscriptions.UserId,
        SchedSubscriptions.UserEmail,
        SchedSubscriptions.SiteUrl,
        SchedSubscriptions.WebUrl,
        SchedSubscriptions.ListUrl,
        SchedSubscriptions.WebTitle,
        SchedSubscriptions.WebLanguage,
        SchedSubscriptions.WebLocale,
        SchedSubscriptions.WebTimeZone,
        SchedSubscriptions.WebTime24,
        SchedSubscriptions.WebCalendarType,
        SchedSubscriptions.WebAdjustHijriDays,
        SchedSubscriptions.ListTitle,
        SchedSubscriptions.ListBaseType,
        SchedSubscriptions.ListServerTemplate,
        EventLog.ItemName,
        EventLog.ItemFullUrl,
        EventLog.ModifiedBy,
        EventLog.TimeLastModified,
        SchedSubscriptions.Id, 
        EventLog.Id,
        SchedSubscriptions.EventType,
        EventLog.EventType,
        EventLog.ItemId,
        SchedSubscriptions.NotifyTime,
        SchedSubscriptions.NotifyFreq,
        SchedSubscriptions.Properties,
        SchedSubscriptions.AlertTitle, 
        SchedSubscriptions.AlertType,
        SchedSubscriptions.AlertTemplateName, 
        EventLog.EventData,
        EventSubsMatches.LookupFieldPermissionResults
    FROM
        SchedSubscriptions
    INNER LOOP JOIN
        EventLog
    ON
        SchedSubscriptions.SiteId = @SiteId AND
        SchedSubscriptions.NotifyFreq = @NotifyFreq AND
        EventLog.SiteId = SchedSubscriptions.SiteId AND
        EventLog.SiteId = @SiteId
    INNER LOOP JOIN 
        EventSubsMatches
    ON  
        EventSubsMatches.EventId = EventLog.Id AND
        EventSubsMatches.SubId = SchedSubscriptions.Id
    WHERE
        EventLog.EventTime                      < @@EventTime               AND
        EventLog.EventTime  >= @@EventTime - CASE
                                    WHEN (SchedSubscriptions.NotifyFreq = 1)
                                    THEN 1.0
                                    ELSE 7.0
                                    END AND
        SchedSubscriptions.UserEmail            <> N''                      AND
        SchedSubscriptions.NotifyTimeUTC        < @@EventTime               AND
        SchedSubscriptions.Deleted              = 0
    OPTION (FORCE ORDER)
    ELSE 
    SELECT
        SchedSubscriptions.WebId,
        SchedSubscriptions.ListId,
        SchedSubscriptions.UserId,
        SchedSubscriptions.UserEmail,
        SchedSubscriptions.SiteUrl,
        SchedSubscriptions.WebUrl,
        SchedSubscriptions.ListUrl,
        SchedSubscriptions.WebTitle,
        SchedSubscriptions.WebLanguage,
        SchedSubscriptions.WebLocale,
        SchedSubscriptions.WebTimeZone,
        SchedSubscriptions.WebTime24,
        SchedSubscriptions.WebCalendarType,
        SchedSubscriptions.WebAdjustHijriDays,
        SchedSubscriptions.ListTitle,
        SchedSubscriptions.ListBaseType,
        SchedSubscriptions.ListServerTemplate,
        NULL,
        NULL,
        NULL,
        NULL,
        SchedSubscriptions.Id,
        NULL,
        SchedSubscriptions.EventType,        
        NULL,
        NULL,
        SchedSubscriptions.NotifyTime,
        SchedSubscriptions.NotifyFreq,
        SchedSubscriptions.Properties,
        SchedSubscriptions.AlertTitle, 
        SchedSubscriptions.AlertType,
        SchedSubscriptions.AlertTemplateName, 
        NULL,
        NULL
    FROM
        SchedSubscriptions WITH(NOLOCK)
    WHERE
        AlertType & 1073741824 != 0                    AND
        SchedSubscriptions.SiteId = @SiteId                                 AND
        SchedSubscriptions.UserEmail            <> N''                      AND
        SchedSubscriptions.NotifyTimeUTC        < @@EventTime               AND
        SchedSubscriptions.NotifyFreq           = @NotifyFreq               AND
        SchedSubscriptions.Deleted              = 0
    ORDER BY
        SchedSubscriptions.WebId,
        SchedSubscriptions.UserId,
        SchedSubscriptions.Id,
        SchedSubscriptions.ListUrl

GO
