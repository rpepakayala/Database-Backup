/****** Object:  StoredProcedure [dbo].[proc_GetChanges]    Script Date: 5/15/2018 12:12:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetChanges(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @ChangeTime datetime,
    @ChangeNumber bigint,
    @ChangeTimeEnd datetime,
    @ChangeNumberEnd bigint,
    @ObjectTypeMask int,
    @EventTypeMask int)
AS
    SET NOCOUNT ON
    DECLARE @SiteIdEmpty uniqueidentifier
    SET @SiteIdEmpty = '00000000-0000-0000-0000-000000000000'
    IF (@ChangeNumber IS NULL)
    BEGIN
        IF (@ChangeTime IS NULL)
        BEGIN
            SET @ChangeNumber = 0
        END
        ELSE
        BEGIN
            SELECT TOP 1 @ChangeNumber = Id FROM EventCache WHERE EventTime < @ChangeTime ORDER BY Id DESC
            IF (@ChangeNumber IS NULL)
            BEGIN
                SET @ChangeNumber = 0
            END
        END    
    END
    IF (@ChangeNumberEnd IS NULL)
    BEGIN
        IF (@ChangeTimeEnd IS NULL)
        BEGIN
            SET @ChangeNumberEnd = IDENT_CURRENT('EventCache')
        END
        ELSE
        BEGIN
            SELECT TOP 1 @ChangeNumberEnd = Id FROM EventCache WHERE EventTime >= @ChangeTimeEnd ORDER BY Id
            IF (@ChangeNumberEnd IS NULL)
            BEGIN
                SET @ChangeNumberEnd = IDENT_CURRENT('EventCache')
            END
        END
    END
    SELECT TOP 1 
        EventTime,
        Id 
    FROM
        EventCache 
    ORDER BY Id
    IF (@SiteId IS NULL)
    BEGIN
        SELECT TOP 1000
            EventTime,
            Id,
            CASE WHEN (ObjectType = 2048 AND @SiteId IS NOT NULL) THEN @SiteId ELSE SiteId END AS SiteId,
            WebId,
            ListId,
            ItemId,
            DocId,
            Guid0,
            Int0,
            ContentTypeId,
            ItemFullUrl,
            EventType,
            ObjectType,
            TimeLastModified,
            Int1
        FROM
            EventCache
        WHERE
            (Id > @ChangeNumber) AND
            (Id <= @ChangeNumberEnd) AND
            (EventType & @EventTypeMask) != 0 AND
            (ObjectType & @ObjectTypeMask) != 0
        ORDER BY Id
    END
    ELSE IF (@ListId IS NULL)
    BEGIN
        SELECT TOP 1000 * FROM
            (SELECT TOP 1000
                EventTime,
                Id,
                CASE WHEN (ObjectType = 2048 AND @SiteId IS NOT NULL) THEN @SiteId ELSE SiteId END AS SiteId,
                WebId,
                ListId,
                ItemId,
                DocId,
                Guid0,
                Int0,
                ContentTypeId,
                ItemFullUrl,
                EventType,
                ObjectType,
                TimeLastModified,
                Int1
            FROM
                EventCache WITH (INDEX = EventCache_SiteId)
            WHERE
                (Id > @ChangeNumber) AND
                (Id <= @ChangeNumberEnd) AND
                (SiteId = @SiteIdEmpty) AND
                (@WebId IS NULL OR WebId = @WebId) AND
                (EventType & @EventTypeMask) != 0 AND
                (ObjectType & @ObjectTypeMask) != 0
            ORDER BY Id
            UNION
            SELECT TOP 1000
                EventTime,
                Id,
                CASE WHEN (ObjectType = 2048 AND @SiteId IS NOT NULL) THEN @SiteId ELSE SiteId END AS SiteId,
                WebId,
                ListId,
                ItemId,
                DocId,
                Guid0,
                Int0,
                ContentTypeId,
                ItemFullUrl,
                EventType,
                ObjectType,
                TimeLastModified,
                Int1
            FROM
                EventCache WITH (INDEX = EventCache_SiteId)
            WHERE
                (Id > @ChangeNumber) AND
                (Id <= @ChangeNumberEnd) AND
                (SiteId = @SiteId) AND
                (@WebId IS NULL OR WebId = @WebId) AND
                (EventType & @EventTypeMask) != 0 AND
                (ObjectType & @ObjectTypeMask) != 0
            ORDER BY Id)
        AS EVENTCACHEUNION ORDER BY EVENTCACHEUNION.Id
    END
    ELSE
    BEGIN
        SELECT TOP 1000
            EventTime,
            Id,
            CASE WHEN (ObjectType = 2048 AND @SiteId IS NOT NULL) THEN @SiteId ELSE SiteId END AS SiteId,
            WebId,
            ListId,
            ItemId,
            DocId,
            Guid0,
            Int0,
            ContentTypeId,
            ItemFullUrl,
            EventType,
            ObjectType,
            TimeLastModified,
            Int1
        FROM
            EventCache WITH (INDEX = EventCache_ListId)
        WHERE
            (Id > @ChangeNumber) AND
            (Id <= @ChangeNumberEnd) AND
            (ListId = @ListId) AND
            (EventType & @EventTypeMask) != 0 AND
            (ObjectType & @ObjectTypeMask) != 0
        ORDER BY Id
    END

GO
