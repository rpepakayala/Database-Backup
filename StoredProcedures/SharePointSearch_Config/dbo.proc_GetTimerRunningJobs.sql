/****** Object:  StoredProcedure [dbo].[proc_GetTimerRunningJobs]    Script Date: 5/15/2018 12:13:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_GetTimerRunningJobs(
    @ServiceId uniqueidentifier,
    @VirtualServerId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        ServiceId,
        VirtualServerId,
        JobId,
        JobTitle,
        ServerName,
        Status,
        StartTime,
        CurrentTarget,
        TargetCount,
        CurrentTargetPercentDone
    FROM
        TimerRunningJobs
    WHERE
        ServiceId = @ServiceId AND
        (VirtualServerId = @VirtualServerId OR
            (VirtualServerId IS NULL AND
                @VirtualServerId IS NULL))

GO
