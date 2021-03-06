/****** Object:  StoredProcedure [dbo].[proc_CountWorkflowAssociations]    Script Date: 5/15/2018 12:12:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CountWorkflowAssociations (
        @SiteId                uniqueidentifier,
        @BaseId                uniqueidentifier
        )
AS
    SET NOCOUNT ON
    SELECT COUNT(*)
    FROM
        dbo.WorkflowAssociation
    WHERE
        SiteId = @SiteId AND
        (@BaseId IS NULL OR
            BaseId = @BaseId)

GO
