/****** Object:  StoredProcedure [dbo].[proc_RefreshAllTimerLocks]    Script Date: 5/15/2018 12:13:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_RefreshAllTimerLocks(
    @ServerName nvarchar(128))
AS
    SET NOCOUNT ON
    DECLARE @Now datetime
    SET @Now = GETUTCDATE()
    UPDATE
        TimerLocks
    SET
        LockedByServerName = @ServerName,
        LockedTime = @Now
    WHERE
        LockedByServerName = @ServerName

GO
