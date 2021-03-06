/****** Object:  StoredProcedure [dbo].[proc_UpdateListItemWorkflowLock]    Script Date: 5/15/2018 12:13:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateListItemWorkflowLock (
        @SiteId                uniqueidentifier,
        @WorkflowInstanceId    uniqueidentifier,
        @Lock                  bit,
        @ProcessingId          uniqueidentifier,
        @EventsNotDelivered    bit = 0
        )
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    SET @iRet = 0
    DECLARE @oldTranCount int
    SET @oldTranCount = @@TRANCOUNT
    DECLARE @cbDelta bigint
    SET @cbDelta = 0
    DECLARE @updtError int
    DECLARE @bDidModify int
    SET @bDidModify = 0
    DECLARE @bFailedOnStart bit
    BEGIN TRAN
    UPDATE
        dbo.Workflow
    SET
        @bDidModify = 1,
        @bFailedOnStart = CASE WHEN (@Lock = 0 AND ((InternalState & 2048) = 0)) THEN 0 ELSE 1 END,
        Status1 = CASE WHEN (@bFailedOnStart = 1) THEN (CASE WHEN (@EventsNotDelivered = 0) THEN 6 ELSE 0 END) ELSE Status1 END, 
        InternalState = (CASE WHEN (@EventsNotDelivered = 0) THEN ~2048 ELSE ~0 END) & (CASE WHEN (@Lock = 1) THEN (InternalState | 1) ELSE ((InternalState & ~1) | (CASE WHEN (@bFailedOnStart = 1) THEN 2 ELSE 0 END)) END),
        LockMachineId = CASE WHEN (@Lock = 1) THEN @ProcessingId ELSE NULL END,
        @cbDelta = ISNULL(InstanceDataSize - HistorySize,0),
        HistorySize = CASE WHEN (@Lock = 1) THEN InstanceDataSize ELSE 0 END
    WHERE    
        SiteId = @SiteId AND
        Id = @WorkflowInstanceId AND
        InternalState = CASE WHEN (@Lock = 1) THEN (InternalState & ~1) ELSE (InternalState | 1) END AND
        ((@Lock = 1 AND LockMachineId IS NULL) OR (@Lock = 0 AND LockMachineId = @ProcessingId))
    SET @updtError = @@ERROR
    IF (@bDidModify = 0 OR @updtError <> 0)
    BEGIN
        IF (@bDidModify = 0 AND @updtError = 0)
        BEGIN
            IF @Lock = 0
            BEGIN
                EXEC proc_RemoveFailOver @ProcessingId, @SiteId
                EXEC proc_AppendSiteQuota @SiteId, @cbDelta, 1
            END
        END
        ELSE
        BEGIN
            SET @iRet = 82
        END
        GOTO CLEANUP
    END
    IF @Lock = 1
      BEGIN
        EXEC @iRet = proc_AddFailOver @ProcessingId, @SiteId, @WorkflowInstanceId, 7, 0
        IF @iRet <> 0
            GOTO CLEANUP
      END
    ELSE
      BEGIN
        EXEC proc_RemoveFailOver @ProcessingId, @SiteId
        EXEC proc_AppendSiteQuota @SiteId, @cbDelta, 1
      END
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
        IF @Lock = 0
        BEGIN
            EXEC proc_UpdateDiskUsed @SiteId
        END
    END
    RETURN @iRet

GO
