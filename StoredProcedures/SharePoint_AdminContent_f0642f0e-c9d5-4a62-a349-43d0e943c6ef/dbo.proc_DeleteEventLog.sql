/****** Object:  StoredProcedure [dbo].[proc_DeleteEventLog]    Script Date: 5/15/2018 12:12:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteEventLog(
    @SiteId         uniqueidentifier,
    @EventTime      datetime)
AS
    SET NOCOUNT ON
    DELETE 
    FROM EventSubsMatches 
    WHERE EventId in 
       (SELECT Id FROM 
            EventLog
        WHERE
            EventLog.SiteId     = @SiteId       AND
            EventLog.EventTime  < @EventTime)
    DELETE
        EventLog
    WHERE
        EventLog.SiteId     = @SiteId       AND
        EventLog.EventTime  < @EventTime

GO
