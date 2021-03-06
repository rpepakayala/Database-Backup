/****** Object:  StoredProcedure [dbo].[proc_StartTimerRunningJob]    Script Date: 5/15/2018 12:13:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_StartTimerRunningJob(
    @ServiceId uniqueidentifier, 
    @VirtualServerId uniqueidentifier,
    @JobId uniqueidentifier,
    @JobTitle nvarchar(255),
    @ServerName nvarchar(128),
    @TargetCount int)
AS
    SET NOCOUNT ON
    DECLARE @Now datetime
    SET @Now = GETUTCDATE()
    UPDATE
        TimerRunningJobs
    SET
        JobTitle = @JobTitle,
        Status = 1,
        StartTime = @Now,
        CurrentTarget = 0,
        TargetCount = @TargetCount,
        CurrentTargetPercentDone = NULL
    WHERE
        ServiceId = @ServiceId AND
        (VirtualServerId = @VirtualServerId OR
            (VirtualServerId IS NULL AND
                @VirtualServerId IS NULL)) AND
        JobId = @JobId AND
        ServerName = @ServerName
    IF (@@ROWCOUNT = 0)
    BEGIN
        INSERT INTO TimerRunningJobs(
            ServiceId,
            VirtualServerId,
            JobId,
            JobTitle,
            ServerName,
            Status,
            StartTime,
            CurrentTarget,
            TargetCount,
            CurrentTargetPercentDone)
        SELECT
            @ServiceId,
            @VirtualServerId,
            Objects.Id,
            @JobTitle,
            @ServerName,
            1,
            @Now,
            0,
            @TargetCount,
            NULL
        FROM
            Objects
        WHERE
            Objects.Id = @JobId
        IF (@@ROWCOUNT = 0)
            RETURN 31
    END
    RETURN 0

GO
