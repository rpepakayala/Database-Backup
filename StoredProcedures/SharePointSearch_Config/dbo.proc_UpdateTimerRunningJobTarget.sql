/****** Object:  StoredProcedure [dbo].[proc_UpdateTimerRunningJobTarget]    Script Date: 5/15/2018 12:13:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_UpdateTimerRunningJobTarget(
    @ServiceId uniqueidentifier, 
    @VirtualServerId uniqueidentifier,
    @JobId uniqueidentifier,
    @ServerName nvarchar(128),
    @CurrentTarget int)
AS
    SET NOCOUNT ON
    UPDATE
        TimerRunningJobs
    SET
        CurrentTarget = @CurrentTarget,
        CurrentTargetPercentDone = NULL
    WHERE
        ServiceId = @ServiceId AND
        (VirtualServerId = @VirtualServerId OR
            (VirtualServerId IS NULL AND
                @VirtualServerId IS NULL)) AND
        JobId = @JobId AND
        ServerName = @ServerName AND
        Status = 1
    IF (@@ROWCOUNT = 0)
        RETURN 31
    RETURN 0

GO
