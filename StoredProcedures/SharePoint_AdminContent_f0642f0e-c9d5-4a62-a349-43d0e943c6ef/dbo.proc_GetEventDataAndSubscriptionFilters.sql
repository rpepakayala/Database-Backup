/****** Object:  StoredProcedure [dbo].[proc_GetEventDataAndSubscriptionFilters]    Script Date: 5/15/2018 12:12:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetEventDataAndSubscriptionFilters
AS
    BEGIN TRAN
    DECLARE @dtLast datetime
    DECLARE @EventBatch TABLE (
    EventTime           datetime                             NOT NULL,
    Id                  bigint                               NOT NULL,
    SiteId              uniqueidentifier                     NOT NULL,
    WebId               uniqueidentifier                     NULL,
    ListId              uniqueidentifier                     NULL,
    ItemId              int                                  NULL,
    ItemName            nvarchar(255)       NULL,
    ItemFullUrl         nvarchar(260)        NULL,
    EventType           int                                  NOT NULL,
    ModifiedBy          nvarchar(255)     NULL,
    TimeLastModified    datetime                             NOT NULL,
    EventData           image                                NULL,
    ACL                 image                                NULL)
    DECLARE @EventBatchLists TABLE (
    SiteId              uniqueidentifier                     NOT NULL,
    ListId              uniqueidentifier                     NULL)
    SET @dtLast = GETUTCDATE()
    DECLARE @IdStart bigint
    DECLARE @IdCurrentEnd bigint
    SELECT
        @IdStart = Id
    FROM
        EventBatches
    SELECT @IdCurrentEnd = IDENT_CURRENT('EventCache')
    IF (@IdStart IS NULL)
    BEGIN
        INSERT INTO @EventBatch
            (ListId, Id, EventData, EventType, ItemId, 
             ItemName, ItemFullUrl, ModifiedBy, TimeLastModified, ACL,
             SiteId, EventTime)
        SELECT TOP 10000
             ListId, Id, EventData, EventType & ~268431360 as EventType, ItemId, 
             ItemName, ItemFullUrl, ModifiedBy, TimeLastModified, ACL,
             SiteId, EventTime
        FROM EventCache WITH(XLOCK)
        WHERE
            Id <= @IdCurrentEnd AND
            (EventType & ~268431360 > 0)
        ORDER BY Id 
    END
    ELSE
    BEGIN
        INSERT INTO @EventBatch
            (ListId, Id, EventData, EventType, ItemId, 
             ItemName, ItemFullUrl, ModifiedBy, TimeLastModified, ACL,
             SiteId, EventTime)
        SELECT TOP 10000
             ListId, Id, EventData, EventType & ~268431360 as EventType, ItemId, 
             ItemName, ItemFullUrl, ModifiedBy, TimeLastModified, ACL,
             SiteId, EventTime
        FROM EventCache WITH(XLOCK)
        WHERE
            Id > @IdStart AND 
            Id <= @IdCurrentEnd AND
            (EventType & ~268431360 > 0)
        ORDER BY Id 
    END
    INSERT INTO EventLog(
        Id,
        SiteId,
        EventTime,
        ListId,
        ItemId,
        ItemName,
        ItemFullUrl,
        EventType,
        ModifiedBy,
        TimeLastModified,
        EventData)
    SELECT 
        EB.Id,
        EB.SiteId,
        EB.EventTime,
        EB.ListId,
        EB.ItemId,
        EB.ItemName,
        EB.ItemFullUrl,
        EB.EventType,
        EB.ModifiedBy,
        EB.TimeLastModified,
        EB.EventData
    FROM
        @EventBatch as EB
    SELECT 
        ListId, Id, EventData, EventType, ItemId, 
        ItemName, ItemFullUrl, ModifiedBy, TimeLastModified, ACL, SiteId
    FROM 
        @EventBatch 
    ORDER BY SiteId, ListId
    INSERT INTO @EventBatchLists
        (SiteId, ListId)
    SELECT DISTINCT
        SiteId, ListId
    FROM 
        @EventBatch
    SELECT 
        Id, BinaryFilter, I.ListId AS ListId, ItemId, AlertType, EventType, 0, WebTimeZone, WebId, UserId, I.SiteId AS SiteId, SiteUrl, WebUrl, Properties
    FROM 
        ImmedSubscriptions AS I WITH(NOLOCK)
    INNER JOIN 
        @EventBatchLists AS EBL
    ON
        EBL.SiteId = I.SiteId AND
        EBL.ListId = I.ListId
    WHERE 
        Status = 0 AND
        (
            Deleted = 0
        ) OR (
            Deleted = 1 AND
            AlertType & 15 = 1 AND
            EventType & 4 <> 0
        )
    UNION ALL
    SELECT 
        Id, BinaryFilter, S.ListId AS ListId, ItemId, AlertType, EventType, NotifyFreq, WebTimeZone, WebId, UserId, S.SiteId AS SiteId, SiteUrl, WebUrl, Properties
    FROM 
        SchedSubscriptions AS S WITH(NOLOCK)
    INNER JOIN 
        @EventBatchLists AS EBL
    ON
        EBL.SiteId = S.SiteId AND
        EBL.ListId = S.ListId
    WHERE 
        Status = 0 AND
        (
            Deleted = 0
        ) OR (
            Deleted = 1 AND
            AlertType & 15 = 1 AND
            EventType & 4 <> 0
        )
    ORDER BY SiteId, ListId
    SELECT @dtLast 
    DECLARE @EventTimeEnd datetime
    DECLARE @IdEndBatch bigint
    SELECT TOP 1
         @EventTimeEnd = EventTime,
         @IdEndBatch = Id
    FROM
        @EventBatch
    ORDER BY
        Id DESC 
    IF (@IdEndBatch IS NOT NULL)
    BEGIN
        IF  (@IdStart IS NULL)
        BEGIN
            UPDATE
                EventCache
            Set    
                EventData = NULL,
                ACL = NULL
            WHERE
                Id <= @IdEndBatch
            INSERT INTO EventBatches( 
                EventTime,
                Id)
            VALUES( 
                @EventTimeEnd,
                @IdEndBatch)
        END
        ELSE
        BEGIN
            UPDATE
                EventCache
            Set    
                EventData = NULL,
                ACL = NULL
             WHERE
                Id <= @IdEndBatch AND
                Id > @IdStart
            UPDATE
                EventBatches
            SET
                EventTime = @EventTimeEnd,
                Id = @IdEndBatch
        END
    END
    COMMIT TRAN
    RETURN 0

GO
