/****** Object:  StoredProcedure [dbo].[proc_InsertContextEventReceiver]    Script Date: 5/15/2018 12:12:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_InsertContextEventReceiver(
    @Id uniqueidentifier,
    @Name nvarchar(256),
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ParentHostId uniqueidentifier,
    @ParentHostType int,
    @Type int,
    @SequenceNumber int,
    @Assembly nvarchar(256),
    @Class nvarchar(256),
    @Data nvarchar(256),
    @Filter nvarchar(256),
    @Credential int,
    @ContextHostType int,
    @ContextObjectItemId int,
    @ContextObjectUrl nvarchar(260),
    @ContextType uniqueidentifier,
    @ContextEventType uniqueidentifier,
    @ContextId uniqueidentifier,
    @ContextObjectId uniqueidentifier,
    @ContextCollectionId uniqueidentifier)
AS
    DECLARE @iRet int
    SET @iRet = 0
    DECLARE @oldTranCount int
    SET @oldTranCount = @@TRANCOUNT
    IF @ContextCollectionId IS NULL
    BEGIN
        SET @iRet = 87
        GOTO CLEANUP
    END
    BEGIN TRAN
    IF @ContextObjectId IS NOT NULL
    BEGIN
    	DECLARE @ParentId uniqueidentifier;
        SET @ParentId = NEWID();
        DECLARE @ContextObjectDirName nvarchar(256)
        DECLARE @ContextObjectLeafName nvarchar(128)
        if @ContextObjectUrl IS NOT NULL
            EXEC proc_SplitUrl @ContextObjectUrl, @ContextObjectDirName OUTPUT, @ContextObjectLeafName OUTPUT
        ELSE
        BEGIN
            SET @ContextObjectDirName = NULL
            SET @ContextObjectLeafName = NULL
        END
        EXEC proc_InsertEventReceiver @ParentId, N'' ,
                                        @SiteId, @WebId, @ParentHostId, @ParentHostType,
                                        @ContextObjectItemId, @ContextObjectDirName, @ContextObjectLeafName,
                                        32767,
                                        @SequenceNumber, N'' , N'' , N'' , N'' ,
                                        NULL , 0 , 0 ,
                                        NULL , NULL ,
                                        NULL , NULL , @ContextObjectId 
    END
    EXEC @iRet = proc_InsertEventReceiver @Id, @Name,
                                     @SiteId, @WebId, @ParentHostId, @ContextHostType,
                                     @ContextObjectItemId, NULL , NULL ,
                                     @Type, @SequenceNumber,
                                     @Assembly, @Class, @Data, @Filter,
                                     NULL , 0 , @Credential,
                                     @ContextType, @ContextEventType,
                                     @ContextId, @ContextObjectId, @ContextCollectionId
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
