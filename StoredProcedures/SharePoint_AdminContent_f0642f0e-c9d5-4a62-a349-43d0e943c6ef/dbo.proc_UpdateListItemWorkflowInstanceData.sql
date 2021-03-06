/****** Object:  StoredProcedure [dbo].[proc_UpdateListItemWorkflowInstanceData]    Script Date: 5/15/2018 12:13:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateListItemWorkflowInstanceData (
        @SiteId                uniqueidentifier,
        @WebId                 uniqueidentifier,
        @ListId                uniqueidentifier,
        @ItemId                int,
        @WorkflowInstanceId    uniqueidentifier,
        @InstanceData          image,
        @InstanceDataSize      int,
        @Modifications         ntext,
        @WakeupTime            datetime,
        @InstanceDataVersionId int,
        @Status1               int,        
        @Status2               int,        
        @Status3               int,        
        @Status4               int,        
        @Status5               int,        
        @Status6               int,        
        @Status7               int,        
        @Status8               int,        
        @Status9               int,        
        @Status10              int,        
        @WorkflowCompleted     bit, 
        @WorkflowSuspended     bit,
        @WorkflowFaulting      bit,
        @WorkflowTerminated    bit, 
        @WorkflowCanceled      bit, 
        @UnlockInstance        bit,
        @ProcessingId          uniqueidentifier,
        @InternalState         int OUTPUT
        )
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    SET @iRet = 0
    DECLARE @TemplateId uniqueidentifier
    DECLARE @AllDone bit
    DECLARE @HadWakeupTime bit
    DECLARE @UpdateStatusVersion int
    DECLARE @oldTranCount int
    SET @oldTranCount = @@TRANCOUNT
    DECLARE @InternalStateOnFlags int
    DECLARE @InternalStateOffFlags int
    SET @InternalStateOnFlags  = 2
    SET @InternalStateOffFlags = ~0 & ~2048
    DECLARE @Modified    datetime
    SET @Modified = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    DECLARE @UpdateModifications bit
    SET @UpdateModifications = 1
    IF (NOT @Modifications IS NULL) AND (DATALENGTH(@Modifications) = 0)
        SET @UpdateModifications = 0
    DECLARE @cbDelta bigint
    SET @cbDelta = 0
    BEGIN TRAN
    IF (@WorkflowCompleted = 1 OR @WorkflowCanceled = 1)
    BEGIN
        SET @AllDone = 1
        SET @UnlockInstance = 0 
    END
    ELSE
        SET @AllDone = 0
    IF (@UnlockInstance = 1 OR @AllDone = 1)
        SET @InternalStateOffFlags = @InternalStateOffFlags & ~1
    IF (@WorkflowSuspended = 1)
    BEGIN
        SET @InternalStateOnFlags = @InternalStateOnFlags | 256
    END
    IF (@WorkflowFaulting = 1)
    BEGIN
        SET @InternalStateOnFlags = @InternalStateOnFlags | 64
        IF (@WorkflowCompleted = 0 AND @WorkflowTerminated = 0)
        BEGIN
            SET @Status1 = CASE WHEN (@Status1 IS NULL) THEN 7 ELSE @Status1 END
        END
    END
    IF (@WorkflowTerminated = 1)
    BEGIN
        SET @InternalStateOnFlags = @InternalStateOnFlags | 128
        IF (@WorkflowCompleted = 0)
        BEGIN
            SET @Status1 = CASE WHEN (@Status1 IS NULL) THEN 3 ELSE @Status1 END
        END
    END
    IF (@WorkflowCompleted = 1)
    BEGIN
        SET @InternalStateOnFlags = @InternalStateOnFlags | 4
        SET @InternalStateOffFlags = @InternalStateOffFlags & ~(2 | 1024)
        SET @Status1 = CASE WHEN (@Status1 IS NULL) THEN 5 ELSE @Status1 END
    END
    IF (@WorkflowCanceled = 1)
    BEGIN
        SET @InternalStateOnFlags = @InternalStateOnFlags | 8
        SET @InternalStateOffFlags = @InternalStateOffFlags & ~(2 | 1024)
    END
    IF @WakeupTime < CONVERT(datetime, '99991231 23:59:59')
    BEGIN
        SET @InternalStateOnFlags = @InternalStateOnFlags | 4096
    END
    ELSE
    BEGIN
        SET @InternalStateOffFlags = @InternalStateOffFlags & ~(4096)
    END
    IF (@Status1 IS NOT NULL) OR (@Status2 IS NOT NULL) OR (@Status3 IS NOT NULL) OR (@Status4 IS NOT NULL) OR (@Status5 IS NOT NULL) OR
       (@Status6 IS NOT NULL) OR (@Status7 IS NOT NULL) OR (@Status8 IS NOT NULL) OR (@Status9 IS NOT NULL) OR (@Status10 IS NOT NULL)
        SET @UpdateStatusVersion = 1
    ELSE
        SET @UpdateStatusVersion = 0
    UPDATE
        dbo.Workflow
    SET
        StatusVersion = StatusVersion + @UpdateStatusVersion,
        Status1 = CASE WHEN (@Status1 IS NULL) THEN (CASE WHEN (Status1 = 3 AND 2 = (@InternalStateOnFlags & 2)) THEN 2 ELSE Status1 END) ELSE @Status1 END,
        Status2 = CASE WHEN (@Status2 IS NULL) THEN Status2 ELSE @Status2 END,
        Status3 = CASE WHEN (@Status3 IS NULL) THEN Status3 ELSE @Status3 END,
        Status4 = CASE WHEN (@Status4 IS NULL) THEN Status4 ELSE @Status4 END,
        Status5 = CASE WHEN (@Status5 IS NULL) THEN Status5 ELSE @Status5 END,
        Status6 = CASE WHEN (@Status6 IS NULL) THEN Status6 ELSE @Status6 END,
        Status7 = CASE WHEN (@Status7 IS NULL) THEN Status7 ELSE @Status7 END,
        Status8 = CASE WHEN (@Status8 IS NULL) THEN Status8 ELSE @Status8 END,
        Status9 = CASE WHEN (@Status9 IS NULL) THEN Status9 ELSE @Status9 END,
        Status10 = CASE WHEN (@Status10 IS NULL) THEN Status10 ELSE @Status10 END,
        Modifications = CASE WHEN (@WorkflowTerminated = 0) THEN (
                            CASE
        			        WHEN (@AllDone = 1) THEN NULL
        			        WHEN (@UpdateModifications = 0) THEN Modifications
        			        ELSE @Modifications END) 
        			    ELSE Modifications END,
        InstanceData = CASE WHEN (@WorkflowTerminated = 0) THEN (CASE WHEN (@AllDone = 1) THEN NULL ELSE @InstanceData END) ELSE InstanceData END,
        InstanceDataSize = CASE WHEN (@WorkflowTerminated = 0) THEN (CASE WHEN (@AllDone = 1) THEN 0 ELSE @InstanceDataSize END) ELSE InstanceDataSize END,
        @HadWakeupTime = CASE WHEN ((InternalState & 4096) <> 0) THEN 1 ELSE 0 END,
        @InternalState = (InternalState & @InternalStateOffFlags) | (@InternalStateOnFlags & @InternalStateOffFlags),
        InternalState = @InternalState,
        Modified = @Modified,
        LockMachineId = CASE WHEN (@AllDone = 1 OR @UnlockInstance = 1) THEN NULL ELSE @ProcessingId END,
        @TemplateId = TemplateId,
        @cbDelta = ISNULL(InstanceDataSize - HistorySize,0),
        HistorySize = CASE WHEN (@AllDone = 1 OR @UnlockInstance = 1) THEN 0 ELSE HistorySize END
    WHERE    
        SiteId = @SiteId AND
        WebId = @WebId AND
        ListId = @ListId AND
        Id = @WorkflowInstanceId AND
        (InternalState & (4 | 8)) = 0 AND
        LockMachineId = @ProcessingId
    IF (@@ROWCOUNT = 0 OR @@ERROR <> 0)
    BEGIN
        SET @iRet = 5
        GOTO CLEANUP
    END
    IF @UnlockInstance = 1
    BEGIN
        EXEC proc_SetWorkflowWakeup @SiteId, @WebId, @ListId, @WorkflowInstanceId, @WakeupTime, @HadWakeupTime
        EXEC proc_RemoveFailOver @ProcessingId, @SiteId
        EXEC proc_AppendSiteQuota @SiteId, @cbDelta, 1
    END
    ELSE   
    IF @AllDone = 0
    BEGIN
      EXEC proc_SetWorkflowWakeup @SiteId, @WebId, @ListId, @WorkflowInstanceId, @WakeupTime, @HadWakeupTime
      EXEC @iRet = proc_UpdateFailOver @ProcessingId, @SiteId, 7
      IF @iRet <> 0
          GOTO CLEANUP
    END
    ELSE  
    BEGIN
        EXEC proc_RemoveFailOver @ProcessingId, @SiteId
        UPDATE
            dbo.WorkflowAssociation
        SET
            InstanceCount = InstanceCount - 1
        WHERE
            SiteId = @SiteId AND
            Id = @TemplateId
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
        IF @AllDone = 1
        BEGIN
            EXEC proc_DeleteContextCollectionEventReceivers @SiteID, @WorkflowInstanceId
            DELETE FROM
                dbo.ScheduledWorkItems
            WHERE
                Type = CAST (N'BDEADF09-C265-11d0-BCED-00A0C90AB50F' as uniqueidentifier) AND
                ParentId = @ListId AND
                SiteId = @SiteId AND
                BatchId = @WorkflowInstanceId
            EXEC proc_UpdateDiskUsed @SiteId
        END
        IF @UnlockInstance = 1
        BEGIN
            EXEC proc_UpdateDiskUsed @SiteId
        END
    END
    RETURN @iRet

GO
