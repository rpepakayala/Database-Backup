/****** Object:  StoredProcedure [dbo].[proc_DeleteAllMarkedTimerLocks]    Script Date: 5/15/2018 12:13:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_DeleteAllMarkedTimerLocks(
    @LockTimeout int)
AS
    SET NOCOUNT ON
    DECLARE @Now datetime
    SET @Now = GETUTCDATE()
    DELETE
        TimerLocks
    WHERE
        LockedByServerName IS NULL AND
        DATEADD(minute, @LockTimeout, LockedTime) < @Now

GO
