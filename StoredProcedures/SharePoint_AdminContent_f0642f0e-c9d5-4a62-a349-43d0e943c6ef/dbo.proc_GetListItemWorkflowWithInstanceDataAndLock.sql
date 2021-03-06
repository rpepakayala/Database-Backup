/****** Object:  StoredProcedure [dbo].[proc_GetListItemWorkflowWithInstanceDataAndLock]    Script Date: 5/15/2018 12:12:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetListItemWorkflowWithInstanceDataAndLock (
        @SiteId                uniqueidentifier,
        @WebId                 uniqueidentifier,
        @ListId                uniqueidentifier,
        @ItemId                int,
        @WorkflowInstanceId    uniqueidentifier,
        @HasInstanceData       int OUTPUT
        )
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    SET @iRet = 0
    DECLARE @InternalState int
    DECLARE @oldTranCount int
    SET @oldTranCount = @@TRANCOUNT
    DECLARE @ProcessingId uniqueidentifier
    SET @ProcessingId = NEWID()
    BEGIN TRAN
    SET @HasInstanceData = 0            
    SELECT TOP 1
        @InternalState = InternalState
    FROM
        dbo.Workflow WITH (UPDLOCK)
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        Id = @WorkflowInstanceId
    IF (@@ROWCOUNT = 0)
    BEGIN
        SET @iRet = 19
        GOTO CLEANUP 
    END
    IF (@InternalState & 1) = 0
    BEGIN
        EXEC @iRet = proc_AddFailOver @ProcessingId, @SiteId, @WorkflowInstanceId, 7, 1
        IF @iRet <> 0
            GOTO CLEANUP
        SELECT TOP 1
            Id, TemplateId, ListId, SiteId, WebId, ItemId, ItemGUID, TaskListId, AdminTaskListId, Author, Modified, Created, StatusVersion, Status1, Status2, Status3, Status4, Status5, Status6, Status7, Status8, Status9, Status10, TextStatus1, TextStatus2, TextStatus3, TextStatus4, TextStatus5, Modifications,
            InstanceData,
            InstanceDataSize,
            InternalState | 1 as InternalState,
            @ProcessingId  as ProcessingId
        FROM
            dbo.Workflow WITH (UPDLOCK)
        WHERE
            SiteId = @SiteId AND
            WebId = @WebId AND
            Id = @WorkflowInstanceId AND
            (InternalState & (1 | (4 | 8))) = 0 AND
            LockMachineId IS NULL
        IF (@@ROWCOUNT = 0)
        BEGIN
            SET @iRet = 19
            GOTO CLEANUP 
        END
        SET @HasInstanceData = 1
        UPDATE
            dbo.Workflow
        SET
            InternalState = (InternalState | 1) & ~1024,
            Status1 = CASE WHEN (Status1 = 0) THEN 2 ELSE Status1 END ,
            LockMachineId = @ProcessingId,
            HistorySize = InstanceDataSize
        WHERE    
            SiteId = @SiteId AND
            WebId = @WebId AND
            Id = @WorkflowInstanceId
    END
    ELSE
    BEGIN
        EXEC @iRet = proc_GetListItemWorkflows @SiteId,
                                               @WebId,
                                               NULL,
                                               0,
                                               @WorkflowInstanceId,
                                               NULL
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
    END
    RETURN @iRet

GO
