/****** Object:  StoredProcedure [dbo].[proc_RevertInProgressWorkItem]    Script Date: 5/15/2018 12:12:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_RevertInProgressWorkItem (
        @ProcessingId          uniqueidentifier,
        @SiteId                uniqueidentifier,
        @Id                    uniqueidentifier
        )
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    SET @iRet = 0
    DECLARE @oldTranCount int
    SET @oldTranCount = @@TRANCOUNT
    DECLARE @Now datetime
    SET @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    DECLARE @AutoDeleteDate datetime
    SET @AutoDeleteDate = DateAdd(Day, -10, @Now)
    EXEC proc_UpdateFailOver @ProcessingId, NULL, 20
    BEGIN TRAN
    DELETE
        dbo.ScheduledWorkItems
    WHERE
        SiteId = @SiteId AND
        Id = @Id AND
        ProcessingId = @ProcessingId AND
        DeliveryDate < @AutoDeleteDate AND
        (InternalState & (4)) != 0 
    DECLARE @RetryBackoff TABLE(
        Id int IDENTITY PRIMARY KEY,
        Minutes int)
    INSERT INTO @RetryBackoff VALUES (10) INSERT INTO @RetryBackoff VALUES (20) INSERT INTO @RetryBackoff VALUES (40) INSERT INTO @RetryBackoff VALUES (80) INSERT INTO @RetryBackoff VALUES (160) INSERT INTO @RetryBackoff VALUES (320) INSERT INTO @RetryBackoff VALUES (640) INSERT INTO @RetryBackoff VALUES (1280)
    UPDATE
        dbo.ScheduledWorkItems
    SET
        DeliveryDate = CASE WHEN ((InternalState & 8) = 0 OR ProcessMachinePID = 0) THEN DeliveryDate
			           ELSE (select DateAdd(Minute, (Select top 1 Minutes from @RetryBackoff where Id = ProcessMachinePID OR Id = (8)), @Now)) END,
        InternalState = InternalState & ~1 & ~16,
        ProcessingId = NULL,
        ProcessMachinePID = ProcessMachinePID + 1
    WHERE
        SiteId = @SiteId AND
        Id = @Id AND
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
