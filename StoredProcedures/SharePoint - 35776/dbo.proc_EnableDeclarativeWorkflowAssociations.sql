/****** Object:  StoredProcedure [dbo].[proc_EnableDeclarativeWorkflowAssociations]    Script Date: 5/15/2018 12:11:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_EnableDeclarativeWorkflowAssociations (
    @SiteId uniqueidentifier,
    @Enabled int)
AS
    SET NOCOUNT ON
    UPDATE
        dbo.WorkflowAssociation
    SET
        Configuration = CASE WHEN (@Enabled = 1) THEN (Configuration & ~128) ELSE (Configuration | 128) END        
    WHERE    
        SiteId = @SiteId AND
        (Configuration & 64) <> 0

GO
