/****** Object:  StoredProcedure [dbo].[proc_CompleteTimerRunningJob]    Script Date: 5/15/2018 12:13:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_CompleteTimerRunningJob(
    @ServiceId uniqueidentifier, 
    @VirtualServerId uniqueidentifier,
    @JobId uniqueidentifier,
    @ServerName nvarchar(128),
    @Status int)
AS
    SET NOCOUNT ON
    DECLARE @StartTime datetime
    UPDATE
        TimerRunningJobs
    SET
        Status = @Status,
        CurrentTarget = TargetCount
    WHERE
        ServiceId = @ServiceId AND
        (VirtualServerId = @VirtualServerId OR
            (VirtualServerId IS NULL AND
                @VirtualServerId IS NULL)) AND
        JobId = @JobId AND
        ServerName = @ServerName AND
        Status = 1
    RETURN 0

GO
