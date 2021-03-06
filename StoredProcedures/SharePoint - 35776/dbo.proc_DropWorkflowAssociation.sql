/****** Object:  StoredProcedure [dbo].[proc_DropWorkflowAssociation]    Script Date: 5/15/2018 12:11:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DropWorkflowAssociation (
        @SiteId                uniqueidentifier,
        @Id                    uniqueidentifier,
        @DropAll               int=0
        )
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    SET @iRet = 0
    DECLARE @oldTranCount int
    SET @oldTranCount = @@TRANCOUNT
    BEGIN TRAN
    DECLARE @WebId uniqueidentifier
    DECLARE @ListId uniqueidentifier
    SELECT TOP 1
        @WebId = WebId,
        @ListId = ListId
    FROM
        dbo.WorkflowAssociation WITH (XLOCK)
    WHERE
        SiteId = @SiteId AND
        Id = @Id
    IF @@ROWCOUNT <> 0
    BEGIN
        IF @DropAll <> 0
        BEGIN
            EXEC proc_AutoDropWorkflows @SiteId, NULL, @ListId, NULL, @Id, NULL, 1 
            DELETE FROM
                dbo.WorkflowAssociation
            WHERE
                SiteId = @SiteId AND
                Id = @Id
        END
        ELSE
        BEGIN
            DECLARE @AllDeleted bit
            EXEC @AllDeleted = proc_AutoDropWorkflows @SiteId, NULL, @ListId, NULL, @Id, NULL, 1 , 200
            IF @AllDeleted = 1
            BEGIN
                DELETE FROM
                    dbo.WorkflowAssociation
                WHERE
                    SiteId = @SiteId AND
                    Id = @Id
            END
        END
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
