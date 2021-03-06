/****** Object:  StoredProcedure [dbo].[proc_CancelWorkflow]    Script Date: 5/15/2018 12:11:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CancelWorkflow (
        @SiteId                uniqueidentifier,
        @WorkflowInstanceId    uniqueidentifier
        )
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    SET @iRet = 0
    DECLARE @oldTranCount int
    SET @oldTranCount = @@TRANCOUNT
    DECLARE @ProcessingId uniqueidentifier
    DECLARE @cbDelta bigint
    SET @cbDelta = 0
    DECLARE @TemplateId uniqueidentifier
    DECLARE @ParentId uniqueidentifier
    DECLARE @InternalStateOnFlags int
    DECLARE @InternalStateOffFlags int
    SET @InternalStateOnFlags  = 0
    SET @InternalStateOffFlags = ~0
    DECLARE @Modified    datetime
    SET @Modified = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    DECLARE @WebId uniqueidentifier
    DECLARE @TaskListId uniqueidentifier
    DECLARE @DidCancel bit
    SET @DidCancel = 0
    BEGIN TRAN
    SET @InternalStateOnFlags = @InternalStateOnFlags | 8
    SET @InternalStateOffFlags = @InternalStateOffFlags & ~(2 | 1 | 1024)
    UPDATE
        dbo.Workflow
    SET
        @DidCancel = 1,
        @ProcessingId = LockMachineId,
        @cbDelta = CASE WHEN @ProcessingId IS NULL THEN ISNULL(-InstanceDataSize,0) ELSE ISNULL(-HistorySize,0) END,
        HistorySize = 0,
        LockMachineId = NULL,
        InstanceData = NULL,
        InstanceDataSize = 0,
        Modifications = NULL,
        InternalState = (InternalState & @InternalStateOffFlags) | (@InternalStateOnFlags & @InternalStateOffFlags),
        Modified = @Modified,
        Status1 = CASE WHEN Status1 = 6 THEN 1 ELSE 4 END,
        @TaskListId = TaskListId,
        @WebId = WebId,
        @TemplateId = TemplateId,
        @ParentId = ListId
    WHERE    
        SiteId = @SiteId AND
        Id = @WorkflowInstanceId AND
        (InternalState & (4 | 8)) = 0
    IF (@DidCancel = 1)
    BEGIN        
        UPDATE
            dbo.WorkflowAssociation
        SET
            InstanceCount = InstanceCount - 1
        WHERE
            SiteId = @SiteId AND
            Id = @TemplateId
        IF @ProcessingId IS NOT NULL
        BEGIN
            EXEC proc_RemoveFailOver @ProcessingId, @SiteId
        END
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
        IF (@DidCancel = 1)
        BEGIN        
            EXEC proc_DropWorkflowTasks @WorkflowInstanceId, @SiteId, @WebId, @TaskListId    
            EXEC proc_DeleteContextCollectionEventReceivers @SiteID, @WorkflowInstanceId
            DELETE FROM
                dbo.ScheduledWorkItems
            WHERE
                Type = CAST (N'BDEADF09-C265-11d0-BCED-00A0C90AB50F' as uniqueidentifier) AND
                ParentId = @ParentId AND
                SiteId = @SiteId AND
                BatchId = @WorkflowInstanceId
        END
    END
    RETURN @iRet

GO
