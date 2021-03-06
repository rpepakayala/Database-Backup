/****** Object:  StoredProcedure [dbo].[proc_DeleteInProgressWorkItems]    Script Date: 5/15/2018 12:11:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteInProgressWorkItems (
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
    DECLARE @Now datetime
    SET @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    BEGIN TRAN
    IF @SiteId IS NULL
    BEGIN
      EXEC proc_RemoveFailOver @ProcessingId, NULL
    END
    ELSE
    BEGIN    
      EXEC proc_UpdateFailOver @ProcessingId, NULL, 20
    END
    DELETE FROM
        dbo.ScheduledWorkItems
    WHERE
        Type = @WorkItemType AND
        (@ProcessingId IS NULL OR
            DeliveryDate < @Now) AND
        SiteId = @SiteId AND
        (@ProcessingId IS NULL OR
            ProcessingId = @ProcessingId) AND
        (@BatchId IS NULL OR
            BatchId = @BatchId) AND
        (@ParentId IS NULL OR
            ParentId = @ParentId)
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
