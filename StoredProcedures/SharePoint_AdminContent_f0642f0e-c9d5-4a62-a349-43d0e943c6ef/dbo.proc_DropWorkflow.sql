/****** Object:  StoredProcedure [dbo].[proc_DropWorkflow]    Script Date: 5/15/2018 12:12:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DropWorkflow (
        @WorkflowInstanceId    uniqueidentifier,
        @SiteId                uniqueidentifier,
        @WebId                 uniqueidentifier,
        @ListId                uniqueidentifier
        )
AS
    SET NOCOUNT ON
    DECLARE @oldTranCount int
    SET @oldTranCount = @@TRANCOUNT
    BEGIN TRAN
    DECLARE @ProcessingId uniqueidentifier
    DECLARE @InternalState int
    DECLARE @TaskListId uniqueidentifier
    DECLARE @TemplateId uniqueidentifier
    DECLARE @cbDelta bigint
    SET @cbDelta = 0
    DECLARE @NULL_GUID uniqueidentifier
    SET @NULL_GUID = CONVERT(uniqueidentifier, '00000000-0000-0000-0000-000000000000')
    SELECT TOP 1
        @ProcessingId = LockMachineId,
        @InternalState = InternalState,
        @TaskListId = TaskListId,
        @TemplateId = TemplateId,
        @cbDelta = CASE WHEN @ProcessingId IS NULL THEN ISNULL(-InstanceDataSize,0) ELSE ISNULL(-HistorySize,0) END,
        @WebId = WebId,
        @ListId = ListId
    FROM
        dbo.Workflow WITH (XLOCK)
    WHERE
        SiteId = @SiteId AND
        Id = @WorkflowInstanceId
    IF (@InternalState & 2) <> 0
    BEGIN
        IF @TemplateId <> @NULL_GUID
        BEGIN    
            UPDATE
                dbo.WorkflowAssociation
            SET
                InstanceCount = InstanceCount - 1
            WHERE
                SiteId = @SiteId AND
                Id = @TemplateId
        END
    END
    IF @ProcessingId IS NOT NULL
    BEGIN
        EXEC proc_RemoveFailOver @ProcessingId, @SiteId
    END
    DELETE FROM
        dbo.Workflow
    WHERE
        SiteId = @SiteId AND
        Id = @WorkflowInstanceId
    EXEC proc_AppendSiteQuota @SiteId, @cbDelta, 1
    COMMIT TRAN
    EXEC proc_DropWorkflowTasks @WorkflowInstanceId, @SiteId, @WebId, @TaskListId
    IF (@InternalState & 2) <> 0
    BEGIN
        EXEC proc_DeleteContextCollectionEventReceivers @SiteID, @WorkflowInstanceId
        DELETE FROM
            dbo.ScheduledWorkItems
        WHERE
            Type = CAST (N'BDEADF09-C265-11d0-BCED-00A0C90AB50F' as uniqueidentifier) AND
            ParentId = @ListId AND
            SiteId = @SiteId AND
            BatchId = @WorkflowInstanceId
    END

GO
