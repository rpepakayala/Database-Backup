/****** Object:  StoredProcedure [dbo].[proc_DisableAssociationsForTemplate]    Script Date: 5/15/2018 12:12:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DisableAssociationsForTemplate (
        @SiteId                uniqueidentifier,
        @BaseId                uniqueidentifier
        )
AS
    SET NOCOUNT ON
    UPDATE
        dbo.WorkflowAssociation
    SET
        Configuration = (Configuration | 128)
    WHERE
        SiteId = @SiteId AND
        BaseId = @BaseId

GO
