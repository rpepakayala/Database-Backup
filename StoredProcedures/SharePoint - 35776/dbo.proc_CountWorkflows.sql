/****** Object:  StoredProcedure [dbo].[proc_CountWorkflows]    Script Date: 5/15/2018 12:11:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CountWorkflows (
        @AssociationId         uniqueidentifier,
        @SiteId                uniqueidentifier,
        @BaseId                uniqueidentifier,
        @InternalState         int
        )
AS
    SET NOCOUNT ON
    IF @AssociationId IS NULL
        BEGIN
            SELECT COUNT(*)
            FROM
                dbo.Workflow INNER JOIN dbo.WorkflowAssociation
            ON
                dbo.Workflow.TemplateId = dbo.WorkflowAssociation.Id
            WHERE
                dbo.Workflow.SiteId = @SiteId AND
                (@BaseId IS NULL OR
                    dbo.WorkflowAssociation.BaseId = @BaseId) AND
                (@InternalState IS NULL OR
                    (dbo.Workflow.InternalState & @InternalState) <> 0)
         END
    ELSE
    BEGIN
      SELECT COUNT(*)
      FROM
          dbo.Workflow
      WHERE
          dbo.Workflow.TemplateId = @AssociationId AND
          (@InternalState IS NULL OR
              (dbo.Workflow.InternalState & @InternalState) <> 0)
    END

GO
