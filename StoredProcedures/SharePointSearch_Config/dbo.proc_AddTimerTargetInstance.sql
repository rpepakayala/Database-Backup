/****** Object:  StoredProcedure [dbo].[proc_AddTimerTargetInstance]    Script Date: 5/15/2018 12:13:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_AddTimerTargetInstance(
    @JobId uniqueidentifier,
    @TargetInstanceId uniqueidentifier)
AS
    SET NOCOUNT ON
    INSERT INTO TimerTargetInstances(
        JobId,
        TargetInstanceId)
    SELECT
        Objects.Id,
        @TargetInstanceId
    FROM
        Objects
    WHERE
        Objects.Id = @JobId
    IF (@@ROWCOUNT = 0)
    BEGIN
        EXEC proc_DeleteTimerTargetInstances @JobId
        RETURN 31
    END
    RETURN 0

GO
