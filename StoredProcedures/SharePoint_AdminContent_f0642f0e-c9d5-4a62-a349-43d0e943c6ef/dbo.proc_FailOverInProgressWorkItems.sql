/****** Object:  StoredProcedure [dbo].[proc_FailOverInProgressWorkItems]    Script Date: 5/15/2018 12:12:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_FailOverInProgressWorkItems (
        @ProcessingId          uniqueidentifier
        )
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    SET @iRet = 0
    DECLARE @oldTranCount int
    SET @oldTranCount = @@TRANCOUNT
    DECLARE @Now datetime
    SET @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    BEGIN TRAN
    EXEC proc_RemoveFailOver @ProcessingId, NULL
    UPDATE
        dbo.ScheduledWorkItems
    SET
        InternalState = InternalState & ~1 & ~16,
        ProcessingId = NULL
    WHERE
        DeliveryDate < @Now AND
        ProcessingId = @ProcessingId
CLEANUP:
    IF @iRet <> 0
    BEGIN
        IF @@TRANCOUNT = @oldTranCount + 1
        BEGIN
            ROLLBACK TRAN
        END
    END
    ELSE
    BEGIN
        COMMIT TRAN
    END
    RETURN @iRet

GO
