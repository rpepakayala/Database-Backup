/****** Object:  StoredProcedure [dbo].[proc_AddWorkItem]    Script Date: 5/15/2018 12:12:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddWorkItem (
        @WorkItemId            uniqueidentifier,
        @DeliveryDate          datetime,
        @Type                  uniqueidentifier,
        @SubType               uniqueidentifier,
        @SiteId                uniqueidentifier,
        @ParentId              varbinary(16),
        @ItemId                int,
        @WebId                 varbinary(16),
        @ItemGuid              varbinary(16),
        @BatchId               varbinary(16),
        @UserId                int,
        @BinaryPayload         image,
        @TextPayload           ntext,
        @ProcessingId          uniqueidentifier,
        @AutoDeleteOld         bit = 0,
        @ExponentialRetryBackOff bit = 1)
AS
        SET NOCOUNT ON
        DECLARE @iRet int
        SET @iRet = 0
        DECLARE @oldTranCount int
        SET @oldTranCount = @@TRANCOUNT
        DECLARE @Created    datetime
        SET @Created = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
        IF @DeliveryDate IS NULL
            SET @DeliveryDate = @Created
        IF @WorkItemId IS NULL
            SET @WorkItemId = NEWID()    
        DECLARE @InternalStateOnFlags int
        DECLARE @InternalStateOffFlags int
        SET @InternalStateOnFlags  = 0
        IF (@ProcessingId IS NOT NULL AND @ProcessingId != CONVERT(uniqueidentifier, '00000000-0000-0000-0000-000000000000'))
            SET @InternalStateOnFlags = @InternalStateOnFlags | 1 | 16
        IF @AutoDeleteOld <> 0
            SET @InternalStateOnFlags = @InternalStateOnFlags | 4
        IF @ExponentialRetryBackOff <> 0
            SET @InternalStateOnFlags = @InternalStateOnFlags | 8
        BEGIN TRAN
        INSERT INTO dbo.ScheduledWorkItems (
            DeliveryDate, Type, ProcessMachineId, Id, SiteId, ParentId, ItemId, BatchId, ItemGuid, WebId, UserId, Created, BinaryPayload, TextPayload,
            InternalState,
            ProcessingId,
            ProcessMachinePID
            )
        VALUES (
            @DeliveryDate, 
            @Type,
            @SubType,
            @WorkItemId,
            @SiteId,
            @ParentId,
            @ItemId,
            @BatchId,
            @ItemGuid,
            @WebId,
            @UserId,
            @Created,
            @BinaryPayload,
            @TextPayload,
            @InternalStateOnFlags,
            @ProcessingId,
            0
            )
        IF (@@ROWCOUNT = 0 OR @@ERROR <> 0)
        BEGIN
            SET @iRet = 82
            GOTO CLEANUP
        END
        IF (@ProcessingId IS NOT NULL AND @ProcessingId != CONVERT(uniqueidentifier, '00000000-0000-0000-0000-000000000000'))
        BEGIN
            IF NOT EXISTS (SELECT TOP 1
                               Id
                           FROM
                               dbo.ScheduledWorkItems
                           WHERE
                               SiteId = @SiteId AND
                               Id = @ProcessingId AND 
                               Type = CONVERT(uniqueidentifier, 'BDEADF17-C265-11d0-BCED-00A0C90AB50F'))
            BEGIN
                EXEC @iRet = proc_AddFailOver @ProcessingId, NULL, NULL, 20, 0
                IF @iRet <> 0
                  GOTO CLEANUP        
            END
            ELSE
            BEGIN
                EXEC proc_UpdateFailOver @ProcessingId, NULL, 20
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
            IF @ProcessingId IS NULL AND @Type = 'BDEADF09-C265-11d0-BCED-00A0C90AB50F' AND @BatchId IS NOT NULL
            BEGIN
                UPDATE
                    dbo.Workflow
                SET
                    InternalState = InternalState | 1024
                WHERE
                    SiteId = @SiteId AND
                    Id = @BatchId    
            END            
        END
        RETURN @iRet

GO
