/****** Object:  StoredProcedure [dbo].[proc_RenameTimerLock]    Script Date: 5/15/2018 12:12:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_RenameTimerLock(
    @OldServerName nvarchar(255),
    @NewServerName nvarchar(255))
AS
    SET NOCOUNT ON
    UPDATE
        TimerLock
    SET
        LockedBy = @NewServerName
    WHERE
        LockedBy = @OldServerName
    RETURN 0

GO
