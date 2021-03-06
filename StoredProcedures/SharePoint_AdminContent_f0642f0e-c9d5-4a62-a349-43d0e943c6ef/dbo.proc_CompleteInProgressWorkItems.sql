/****** Object:  StoredProcedure [dbo].[proc_CompleteInProgressWorkItems]    Script Date: 5/15/2018 12:12:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CompleteInProgressWorkItems (
        @ProcessingId          uniqueidentifier,
        @SiteId                uniqueidentifier,
        @ParentId              uniqueidentifier,
        @WorkItemType          uniqueidentifier,
        @BatchId               uniqueidentifier
        )
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    SET @iRet = 0
    DECLARE @oldTranCount int
    SET @oldTranCount = @@TRANCOUNT
    BEGIN TRAN
    DECLARE @Now datetime
    SET @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    IF @SiteId IS NULL
    BEGIN
      EXEC proc_RemoveFailOver @ProcessingId, NULL
    END
    ELSE
    BEGIN    
      EXEC proc_UpdateFailOver @ProcessingId, NULL, 20
    END
    UPDATE
        dbo.ScheduledWorkItems
    SET
        InternalState = (InternalState & ~1 & ~16) | 2,
        ProcessingId = NULL,
        ProcessMachinePID = NULL
    WHERE
        Type = @WorkItemType AND
        DeliveryDate < @Now AND
        ProcessingId = @ProcessingId AND
        (@SiteId IS NULL OR
            SiteId = @SiteId) AND
        (@ParentId IS NULL OR
            ParentId = @ParentId) AND
        (@BatchId IS NULL OR
            BatchId = @BatchId)
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
