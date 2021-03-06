/****** Object:  StoredProcedure [dbo].[proc_AddWorkflowAssociation]    Script Date: 5/15/2018 12:12:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddWorkflowAssociation (
        @Id                          uniqueidentifier, 
        @BaseId                      uniqueidentifier,
        @ParentId                    uniqueidentifier,
        @Name                        nvarchar(255),
        @Description                 nvarchar(1023),
        @StatusFieldName             nvarchar(64),
        @SiteId                      uniqueidentifier,
        @WebId                       varbinary(16),
        @ListId                      varbinary(16),
        @ContentTypeId               tContentTypeId,
        @TaskListId                  varbinary(16),
        @HistoryListId               varbinary(16),
        @TaskListTitle               nvarchar(255),
        @HistoryListTitle            nvarchar(255),
        @Author                      int,
        @Configuration               int,
        @AutoCleanupDays             int,
        @PermissionsManual           tPermMask,
        @InstantiationParams         ntext
        )
AS
        SET NOCOUNT ON
        DECLARE @iRet int
        SET @iRet = 0
        DECLARE @oldTranCount int
        SET @oldTranCount = @@TRANCOUNT
        DECLARE @Created    datetime
        SET @Created = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
        IF @Id IS NULL
            SET @Id = NEWID()    
        BEGIN TRAN
        INSERT INTO dbo.WorkflowAssociation (
            Id, BaseId, ParentId, Name, Description, StatusFieldName, SiteId, WebId, ListId, ContentTypeId, InstanceCount, TaskListId, HistoryListId, TaskListTitle, HistoryListTitle, Author, Created, Modified, PermissionsManual, Version, AutoCleanupDays,
            InstantiationParams,
            Configuration
            )
        VALUES (
            @Id, 
            @BaseId,
            @ParentId,
            @Name,
            @Description,
            @StatusFieldName,
            @SiteId,
            @WebId,
            @ListId,
            @ContentTypeId,
            0 ,
            @TaskListId,
            @HistoryListId,
            @TaskListTitle,
            @HistoryListTitle,
            @Author,
            @Created,
            @Created,
            @PermissionsManual,
            1 ,
            @AutoCleanupDays,
            @InstantiationParams,
            @Configuration
            )
        IF (@@ROWCOUNT = 0 OR @@ERROR <> 0)
        BEGIN
            SET @iRet = 82
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
