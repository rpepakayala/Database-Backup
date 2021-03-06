/****** Object:  StoredProcedure [dbo].[proc_DropWorkflowTasks]    Script Date: 5/15/2018 12:12:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DropWorkflowTasks (
        @WorkflowInstanceId    uniqueidentifier,
        @SiteId                uniqueidentifier,
        @WebId                 uniqueidentifier,
        @TaskListId            uniqueidentifier
        )
AS
    SET NOCOUNT ON
    DECLARE @oldTranCount int
    SET @oldTranCount = @@TRANCOUNT
    DECLARE @ItemId int
    DECLARE @WorkflowTask CURSOR
    SET @WorkflowTask = CURSOR LOCAL FAST_FORWARD FOR
    (
        SELECT tp_ID
        FROM dbo.AllUserData
        WHERE tp_ListId = @TaskListId AND
              tp_WorkflowInstanceID = @WorkflowInstanceId
    )    
    OPEN @WorkflowTask
    IF @@CURSOR_ROWS <> 0
    BEGIN
        FETCH NEXT FROM @WorkflowTask INTO @ItemId
        WHILE @@FETCH_STATUS = 0
        BEGIN
            EXEC proc_DropListRecord
                @SiteID,
                @WebID, 
                @TaskListId, 
                0, 
                @ItemId,
                1, 
                0, 
                NULL,
                NULL,
                0, 
                0, 
                NULL, 
                3 
            FETCH NEXT FROM @WorkflowTask INTO @ItemId
        END
    END
    CLOSE @WorkflowTask
    DEALLOCATE @WorkflowTask

GO
