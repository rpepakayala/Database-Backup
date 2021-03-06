/****** Object:  StoredProcedure [dbo].[proc_RenameAllTimerLocksAndRunningJobs]    Script Date: 5/15/2018 12:13:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_RenameAllTimerLocksAndRunningJobs(
    @OldServerName nvarchar(128),
    @NewServerName nvarchar(128))
AS
    SET NOCOUNT ON
    UPDATE
        TimerLocks
    SET
        LockedByServerName = @NewServerName
    WHERE
        LockedByServerName = @OldServerName
    UPDATE
        TimerRunningJobs
    SET
        ServerName = @NewServerName
    WHERE
        ServerName = @OldServerName

GO
