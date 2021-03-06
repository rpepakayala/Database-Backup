/****** Object:  StoredProcedure [dbo].[proc_UpdateWorkflowAssociation]    Script Date: 5/15/2018 12:13:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateWorkflowAssociation (
        @Id                        uniqueidentifier,
        @SiteId                    uniqueidentifier,
        @Name                      nvarchar(255),
        @Description               nvarchar(1023),
        @StatusFieldName           nvarchar(64),
        @TaskListId                varbinary(16),
        @HistoryListId             varbinary(16),
        @TaskListTitle             nvarchar(255),
        @HistoryListTitle          nvarchar(255),
        @Configuration             int,
        @AutoCleanupDays           int,
        @PermissionsManual         tPermMask,
        @InstantiationParams       ntext,
        @Version                   int
        )
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    SET @iRet = 0
    DECLARE @oldTranCount int
    SET @oldTranCount = @@TRANCOUNT
    DECLARE @Modified    datetime
    SET @Modified = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    DECLARE @updtError int
    DECLARE @bDidModify int
    SET @bDidModify = 0
    BEGIN TRAN
    UPDATE
        dbo.WorkflowAssociation
    SET
        @bDidModify = 1,
        Name = CASE WHEN (@Name IS NULL) THEN Name ELSE @Name END,
        Description = CASE WHEN (@Description IS NULL) THEN Description ELSE @Description END,
        StatusFieldName = CASE WHEN (@StatusFieldName IS NULL) THEN StatusFieldName ELSE @StatusFieldName END,
        TaskListId = CASE WHEN (@TaskListId IS NULL) THEN TaskListId ELSE @TaskListId END,
        HistoryListId = CASE WHEN (@HistoryListId IS NULL) THEN HistoryListId ELSE @HistoryListId END,
        TaskListTitle = CASE WHEN (@TaskListTitle IS NULL) THEN TaskListTitle ELSE @TaskListTitle END,
        HistoryListTitle = CASE WHEN (@HistoryListTitle IS NULL) THEN HistoryListTitle ELSE @HistoryListTitle END,
        InstantiationParams = CASE WHEN (@InstantiationParams IS NULL) THEN InstantiationParams ELSE @InstantiationParams END,
        Configuration = @Configuration & ~(8192 | 16384), 
        PermissionsManual = @PermissionsManual,
        Modified = @Modified,
        Version = Version + 1,
        AutoCleanupDays = @AutoCleanupDays
    WHERE    
        SiteId = @SiteId AND
        Id = @Id AND
        (@Version = 0 OR
          Version = @Version)
    SET @updtError = @@ERROR
    IF (@bDidModify = 0 OR @updtError <> 0)
    BEGIN
        SET @iRet = 5
        GOTO CLEANUP
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
