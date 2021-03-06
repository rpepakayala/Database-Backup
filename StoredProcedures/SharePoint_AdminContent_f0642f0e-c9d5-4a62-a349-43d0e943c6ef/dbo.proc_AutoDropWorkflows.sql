/****** Object:  StoredProcedure [dbo].[proc_AutoDropWorkflows]    Script Date: 5/15/2018 12:12:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AutoDropWorkflows (
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @ListItemId int,
    @TemplateId uniqueidentifier,
    @AutoCleanupDate datetime,
    @ForceDelete int,
    @TopBeforeQuick int = 2147483647)
AS
    SET NOCOUNT ON
    DECLARE @WorkflowInstanceId uniqueidentifier
    DECLARE @Workflow CURSOR
    SET @Workflow = CURSOR LOCAL FAST_FORWARD FOR
    (
        SELECT Id
        FROM dbo.Workflow
        WHERE SiteId = @SiteId AND
              (@ListId IS NULL OR
                ListId = @ListId) AND
              (@ListItemId IS NULL OR
                ItemId = @ListItemId) AND
              (@WebId IS NULL OR
                WebId = @WebId) AND
              (@TemplateId IS NULL OR
                TemplateId = @TemplateId) AND                
              (@ForceDelete <> 0 OR
                (Modified <= @AutoCleanupDate AND
                (InternalState & (4 | 8)) <> 0))
    )
    DECLARE @ITER_COUNT int
    SET @ITER_COUNT = 0
    DECLARE @AllDeleted bit
    SET @AllDeleted = 0
    OPEN @Workflow
    IF @@CURSOR_ROWS <> 0
    BEGIN
        FETCH NEXT FROM @Workflow INTO @WorkflowInstanceId
        WHILE @@FETCH_STATUS = 0 AND @ITER_COUNT < @TopBeforeQuick
        BEGIN
            EXEC proc_DropWorkflow @WorkflowInstanceId, @SiteId, @WebId, @ListId
            SET @ITER_COUNT = @ITER_COUNT + 1
            FETCH NEXT FROM @Workflow INTO @WorkflowInstanceId
        END
        IF @ForceDelete = 1
        BEGIN
            IF @ITER_COUNT = @TopBeforeQuick
            BEGIN
                IF @TemplateId IS NOT NULL
                BEGIN
                    UPDATE
                        WorkflowAssociation
                    SET
                        Configuration = Configuration | 512
                    WHERE
                        SiteId = @SiteId AND
                        Id = @TemplateId
                END
                ELSE
                BEGIN
                    EXEC proc_AutoQuickDropWorkflows @SiteId, @ListId, @ListItemId
                END
            END
            ELSE
            BEGIN
                 SET @AllDeleted = 1
            END
        END
        EXEC proc_UpdateDiskUsed @SiteId
    END
    CLOSE @Workflow
    DEALLOCATE @Workflow
    RETURN @AllDeleted

GO
