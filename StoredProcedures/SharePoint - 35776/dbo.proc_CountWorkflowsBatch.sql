/****** Object:  StoredProcedure [dbo].[proc_CountWorkflowsBatch]    Script Date: 5/15/2018 12:11:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CountWorkflowsBatch (
        @SiteId                uniqueidentifier,
        @WebId                 uniqueidentifier,
        @ListId                uniqueidentifier,
        @ContentTypeId         uniqueidentifier,
        @InternalState         int
        )
AS
    SET NOCOUNT ON
    IF @ListId IS NOT NULL
    BEGIN
        SELECT dbo.Workflow.TemplateId, COUNT(*)
        FROM
            dbo.Workflow
        WHERE
            dbo.Workflow.SiteId = @SiteId AND
            dbo.Workflow.WebId = @WebId AND
            dbo.Workflow.ListId = @ListId AND
            (@InternalState IS NULL OR (dbo.Workflow.InternalState & @InternalState) <> 0)
        GROUP BY
            dbo.Workflow.TemplateId
    END
    ELSE 
    BEGIN
        SELECT dbo.Workflow.TemplateId, COUNT(*)
        FROM
                dbo.Workflow INNER JOIN dbo.WorkflowAssociation
            ON
                dbo.Workflow.TemplateId = dbo.WorkflowAssociation.Id
        WHERE
            dbo.Workflow.SiteId = @SiteId AND
            dbo.Workflow.WebId = @WebId AND
            dbo.WorkflowAssociation.ContentTypeId = @ContentTypeId AND
            (@InternalState IS NULL OR (dbo.Workflow.InternalState & @InternalState) <> 0)
        GROUP BY
            dbo.Workflow.TemplateId
    END

GO
