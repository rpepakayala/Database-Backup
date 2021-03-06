/****** Object:  StoredProcedure [dbo].[proc_GetWorkItems]    Script Date: 5/15/2018 12:12:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetWorkItems (
        @SiteId                uniqueidentifier,
        @ParentId              uniqueidentifier,
        @WorkItemType          uniqueidentifier,
        @BatchId               uniqueidentifier,
        @WorkItemId            uniqueidentifier
        )
AS
    SET NOCOUNT ON
    IF (@WorkItemId IS NOT NULL)
        BEGIN
            SELECT TOP 1
                DeliveryDate, Type, ProcessMachineId as SubType, Id, SiteId, ParentId, ItemId, BatchId, ItemGuid, WebId, UserId, Created, BinaryPayload, TextPayload,
                InternalState
            FROM
                dbo.ScheduledWorkItems
            WHERE
                SiteId = @SiteId AND
                Id = @WorkItemId
        END
    ELSE
        BEGIN
            SELECT ALL
                DeliveryDate, Type, ProcessMachineId as SubType, Id, SiteId, ParentId, ItemId, BatchId, ItemGuid, WebId, UserId, Created, BinaryPayload, TextPayload,
                InternalState
            FROM
                dbo.ScheduledWorkItems
            WHERE
                Type = @WorkItemType AND
                SiteId = @SiteId AND
                (@ParentId IS NULL OR
                    ParentId = @ParentId) AND
                (@BatchId IS NULL OR
                    BatchId = @BatchId)
        END

GO
