/****** Object:  StoredProcedure [dbo].[proc_DeleteTimerLockForJob]    Script Date: 5/15/2018 12:13:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_DeleteTimerLockForJob(
    @JobId uniqueidentifier,
    @ServerName nvarchar(128),
    @MarkOnly bit = 1)
AS
    SET NOCOUNT ON
    IF (@MarkOnly = 1)
    BEGIN
        UPDATE
            TimerLocks
        SET
            LockedByServerName = NULL
        WHERE
            JobId = @JobId AND
            (LockedByServerName = @ServerName OR
                @ServerName IS NULL)
    END
    ELSE
    BEGIN
        DELETE
            TimerLocks
        WHERE
            JobId = @JobId AND
            (LockedByServerName = @ServerName OR
                @ServerName IS NULL)
    END
    IF (@@ROWCOUNT = 0)
        RETURN 31
    RETURN 0

GO
