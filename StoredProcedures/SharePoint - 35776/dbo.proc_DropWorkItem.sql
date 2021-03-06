/****** Object:  StoredProcedure [dbo].[proc_DropWorkItem]    Script Date: 5/15/2018 12:11:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DropWorkItem (
        @SiteId                uniqueidentifier,
        @Id                    uniqueidentifier
        )
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    SET @iRet = 0
    DECLARE @oldTranCount int
    SET @oldTranCount = @@TRANCOUNT
    DECLARE @ProcessingId uniqueidentifier
    SET @ProcessingId = NULL
    BEGIN TRAN
    SELECT TOP 1
        @ProcessingId = ProcessingId
    FROM
        dbo.ScheduledWorkItems WITH (XLOCK)
    WHERE
        SiteId = @SiteId AND
        Id = @Id
    DELETE FROM
        dbo.ScheduledWorkItems
    WHERE
        SiteId = @SiteId AND
        Id = @Id
    IF @ProcessingId IS NOT NULL
    BEGIN
        EXEC proc_UpdateFailOver @ProcessingId, NULL, 20
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
