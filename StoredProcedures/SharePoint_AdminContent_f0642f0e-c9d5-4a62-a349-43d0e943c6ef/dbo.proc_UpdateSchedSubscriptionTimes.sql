/****** Object:  StoredProcedure [dbo].[proc_UpdateSchedSubscriptionTimes]    Script Date: 5/15/2018 12:13:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateSchedSubscriptionTimes(
    @EventTime      datetime)
AS
    SET NOCOUNT ON
    DECLARE @Now datetime
    SELECT @Now = GETUTCDATE()
    UPDATE 
        SchedSubscriptions
    SET
        NotifyTime    = CASE WHEN (NotifyTime    IS NOT NULL) THEN NotifyTime    ELSE  @Now END + CASE WHEN (NotifyFreq = 1) THEN 1.0 ELSE 7.0 END,
        NotifyTimeUTC = CASE WHEN (NotifyTimeUTC IS NOT NULL) THEN NotifyTimeUTC ELSE  @Now END + CASE WHEN (NotifyFreq = 1) THEN 1.0 ELSE 7.0 END 
    WHERE
        NotifyTimeUTC < @EventTime OR NotifyTimeUTC IS NULL

GO
