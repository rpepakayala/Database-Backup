/****** Object:  StoredProcedure [dbo].[proc_GetListItemWorkflows]    Script Date: 5/15/2018 12:12:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetListItemWorkflows (
        @SiteId                uniqueidentifier,
        @WebId                 uniqueidentifier,
        @ListId                uniqueidentifier,
        @ItemId                int,
        @WorkflowInstanceId    uniqueidentifier,
        @TemplateId            uniqueidentifier,
        @InclusiveFilterState  int = 0xFFFFFFFF,
        @ExclusiveFilterState  int = 0
        )
AS
    SET NOCOUNT ON
    IF (@WorkflowInstanceId IS NOT NULL)
        BEGIN
            SELECT TOP 1
                Id, TemplateId, ListId, SiteId, WebId, ItemId, ItemGUID, TaskListId, AdminTaskListId, Author, Modified, Created, StatusVersion, Status1, Status2, Status3, Status4, Status5, Status6, Status7, Status8, Status9, Status10, TextStatus1, TextStatus2, TextStatus3, TextStatus4, TextStatus5, Modifications,
                null as InstanceData,     
                0 as InstanceDataSize,     
                InternalState,
                LockMachineId as ProcessingId
            FROM
                dbo.Workflow
            WHERE
                SiteId = @SiteId AND
                WebId = @WebId AND
                Id = @WorkflowInstanceId AND
                (InternalState & @InclusiveFilterState) != 0 AND
                (InternalState & @ExclusiveFilterState) = 0
        END
    ELSE
        BEGIN
            SELECT ALL
                Id, TemplateId, ListId, SiteId, WebId, ItemId, ItemGUID, TaskListId, AdminTaskListId, Author, Modified, Created, StatusVersion, Status1, Status2, Status3, Status4, Status5, Status6, Status7, Status8, Status9, Status10, TextStatus1, TextStatus2, TextStatus3, TextStatus4, TextStatus5, Modifications,
                null as InstanceData,     
                0 as InstanceDataSize,     
                InternalState,
                null as ProcessingId
            FROM
                dbo.Workflow
            WHERE
                SiteId = @SiteId AND
                WebId = @WebId AND
                (@ListId IS NULL OR
                    ListId = @ListId) AND
                (@ItemId IS NULL OR
                    ItemId = @ItemId) AND
                (@TemplateId IS NULL OR
                    TemplateId = @TemplateId) AND
                (InternalState & @InclusiveFilterState) != 0 AND
                (InternalState & @ExclusiveFilterState) = 0
        END

GO
