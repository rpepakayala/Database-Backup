/****** Object:  StoredProcedure [dbo].[proc_DeplGetIncrementalChangesForScope]    Script Date: 5/15/2018 12:12:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetIncrementalChangesForScope(
    @SiteId uniqueidentifier,
    @ChangeTimeEnd datetime,
    @ChangeNumberEnd int,
    @IncludeUsers tinyint,
    @IncludeGroups tinyint,
    @IsMajorFileOnly tinyint,
    @MinChangeTime datetime out,
    @MinChangeNumber int out)
AS
    SET NOCOUNT ON
    DECLARE @ObjectTypeMask int
    DECLARE @EventTypeMask int
    DECLARE @DeletedEventTypeMask int
    SELECT TOP 1
        @MinChangeTime = EventTime,
        @MinChangeNumber = Id
    FROM
        EventCache
    ORDER BY EventTime, Id
    IF @@ROWCOUNT = 0
        RETURN 30000    
    IF EXISTS(
        SELECT 1 FROM #IncrementalSearchScope
         WHERE
            ChangeTime IS NULL OR
            ChangeNumber IS NULL)
        RETURN 30000
    IF EXISTS(
        SELECT 1 FROM #IncrementalSearchScope
        WHERE
            ChangeTime <= @MinChangeTime AND
            ChangeNumber < @MinChangeNumber)
        RETURN 30000
    SET @EventTypeMask = 268431360   &
        ~262144               &
        ~8388608            &
        ~16777216            &
        ~524288         &
        ~33554432      &
        ~4                  &
        ~64                  &
        ~16384
    SET @DeletedEventTypeMask = 4 |
                         64 |
                         16384
    DECLARE @RoleEvents int
    SET @RoleEvents = 262144 | 8388608 | 16777216
    DECLARE @RoleAssignmentEvents int
    SET @RoleAssignmentEvents =524288 | 33554432
    SET @ObjectTypeMask = 4 | 16 | 32 | 2 |  1
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        ParentId,
        ParentWebId,
        EventTime,
        ChangeLogId,
        IsIncremental)
    SELECT
        NEWID(),
        CASE
            WHEN (ev.EventType & @RoleEvents) != 0 THEN 16
            WHEN (ev.EventType & @RoleAssignmentEvents) != 0 THEN 18
            ELSE 9999
        END,
        0,
        ev.WebId,
        ev.WebId,
        ev.EventTime,
        ev.Id,
        1
    FROM
        EventCache ev
    INNER JOIN #IncrementalSearchScope e
    ON
        ev.SiteId = @SiteId AND
        ev.WebId = e.Id AND
        e.Type = 1 AND
        e.IncludeDescendants > 0 AND
        ev.EventTime >= e.ChangeTime AND
        ev.Id > e.ChangeNumber AND
        ev.EventTime <= @ChangeTimeEnd AND
        ev.Id <= @ChangeNumberEnd
    WHERE
        ((EventType & @RoleEvents) != 0 OR (EventType & @RoleAssignmentEvents) != 0) AND
        (ObjectType & @ObjectTypeMask) != 0 
    SET @ObjectTypeMask =
        4 |
        16 |
        32
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        ParentWebId,
        FullUrl,
        IsDeleted,
        IsSelected,
        IsIncremental)
    SELECT DISTINCT
        CASE
            WHEN (ev.ObjectType & 4) != 0 THEN ev.WebId
            ELSE ev.DocId
        END,
        CASE
            WHEN (ev.ObjectType & 4) != 0 THEN 1
            WHEN (ev.ObjectType & 32) != 0 THEN 2
            ELSE 5
        END,
        0,
        ev.WebId,
        ev.ItemFullUrl,
        1,
        e.IsSelected,
        1
    FROM
        EventCache ev
    INNER JOIN #IncrementalSearchScope e
    ON
        ev.SiteId = @SiteId AND
        ev.WebId = e.Id AND
        e.Type = 1 AND
        (e.IncludeDescendants > 0 OR  (ev.ObjectType & 4) != 0) AND
        ev.EventTime >= e.ChangeTime AND
        ev.Id > e.ChangeNumber AND
        ev.EventTime <= @ChangeTimeEnd AND
        ev.Id <= @ChangeNumberEnd
    WHERE
        (EventType & @DeletedEventTypeMask) != 0 AND
        (ObjectType & @ObjectTypeMask) != 0 AND
        NOT EXISTS (
            SELECT 1
            FROM EventCache ev2
            WHERE
                ev2.SiteId = @SiteId AND
                ev.ItemFullUrl LIKE ev2.ItemFullUrl + '/%' AND
                ev2.WebId = e.Id AND
                e.Type = 1 AND
                ev2.EventTime >= e.ChangeTime AND
                ev2.Id > e.ChangeNumber AND
                ev2.EventTime <= @ChangeTimeEnd AND
                ev2.Id <= @ChangeNumberEnd AND
                (ev2.EventType & @DeletedEventTypeMask) != 0 AND
                (ev2.ObjectType & @ObjectTypeMask) != 0 AND
                (ev.ObjectType & 4) = 0 ) 
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        DirName,
        LeafName,
        ParentId,
        ParentWebId,
        FullUrl,
        IsDeleted,
        IsSelected,
        IsIncremental)
    SELECT DISTINCT
        CASE
            WHEN (ev.ObjectType & 4) != 0 THEN ev.WebId
            ELSE ev.DocId
        END,
        CASE
            WHEN (ev.ObjectType & 4) != 0 THEN 1
            WHEN (ev.ObjectType & 32) != 0 THEN 2
            ELSE 5
        END,
        0,
        Docs.DirName,
        Docs.LeafName,
        Docs.ParentId,
        ev.WebId,
        ISNULL(CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END, ev.ItemFullUrl),
        CASE
            WHEN (ev.EventType & @DeletedEventTypeMask) != 0 THEN 1
            ELSE 0
        END,
        e.IsSelected,
        1
    FROM
        EventCache ev
    INNER JOIN #IncrementalSearchScope e
    ON
        ev.SiteId = @SiteId AND
        ev.WebId = e.Id AND
        e.Type = 1 AND
        (e.IncludeDescendants > 0 OR  (ev.ObjectType & 4) != 0) AND
        ev.EventTime >= e.ChangeTime AND
        ev.Id > e.ChangeNumber AND
        ev.EventTime <= @ChangeTimeEnd AND
        ev.Id <= @ChangeNumberEnd
    INNER JOIN
        Docs
    LEFT JOIN
        Webs
    ON
        Docs.Type = 2 AND
        Docs.WebId = Webs.Id
    ON
        ev.SiteId = @SiteId AND
        Docs.SiteId = @SiteId AND
        ((ev.ObjectType & 4) != 0 AND
          ev.WebId = Docs.WebId AND
          Docs.Type = 2) OR
        ( (ev.ObjectType & 32) != 0 AND
          ev.DocId = Docs.Id) OR
        ( (ev.ObjectType & 16) != 0 AND
          ev.DocId = Docs.Id AND
          ((@IsMajorFileOnly = 1 AND Docs.Level=1) OR
          (@IsMajorFileOnly = 0 AND Docs.Level IN
            (SELECT TOP 1 d2.Level FROM Docs d2
             WHERE d2.Id=Docs.Id AND d2.Level <> 255)))
          )
    WHERE
        (EventType & @EventTypeMask) != 0 AND
        (ObjectType & @ObjectTypeMask) != 0 AND
         NOT (Docs.Type = 1 AND
                 Docs.LeafName = '_vti_pvt' ) AND
        NOT EXISTS (                                
            SELECT 1 FROM #ExportObjects e
            WHERE
                 e.Id = ev.WebId AND
                 e.IsDeleted = 1
        ) AND
        (ev.DocId IS NULL OR
            (ev.DocId IS NOT NULL AND
            NOT EXISTS (
                SELECT 1 FROM #ExportObjects e2
                WHERE
                    e2.Id = ev.DocId)  AND         
            NOT EXISTS (
                SELECT 1
                FROM EventCache ev2
                WHERE
                    ev2.SiteId = @SiteId AND
                    ev.ItemFullUrl LIKE ev2.ItemFullUrl + '/%' AND
                    ev2.WebId = e.Id AND
                    e.Type = 1 AND
                    ev2.EventTime >= e.ChangeTime AND
                    ev2.Id > e.ChangeNumber AND
                    ev2.EventTime <= @ChangeTimeEnd AND
                    ev2.Id <= @ChangeNumberEnd AND
                    (ev2.EventType & @DeletedEventTypeMask) != 0 AND
                    (ev2.ObjectType & 32) != 0)        
            )
        ) AND
        ISNULL(Webs.ProductVersion, 3) >= 3
    SET @ObjectTypeMask = 2
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        ParentId,
        ParentWebId,
        FullUrl,
        IsDeleted,
        IsSelected,
        IsIncremental)
    SELECT DISTINCT
        ev.ListId,
        3,
        0,
        ev.WebId,
        ev.WebId,
        ev.ItemFullUrl,
        1,
        e.IsSelected,
        1
    FROM
        EventCache ev
    INNER JOIN #IncrementalSearchScope e
    ON
        ev.SiteId = @SiteId AND
        ev.WebId = e.Id AND
        e.Type = 1 AND
        e.IncludeDescendants > 0 AND
        ev.EventTime >= e.ChangeTime AND
        ev.Id > e.ChangeNumber AND
        ev.EventTime <= @ChangeTimeEnd AND
        ev.Id <= @ChangeNumberEnd
    WHERE
        (ev.ObjectType & @ObjectTypeMask) != 0 AND
        (ev.EventType & @DeletedEventTypeMask) != 0 AND
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects e
            WHERE
                e.Id = ev.WebId AND
                e.IsDeleted = 1) 
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        DirName,
        LeafName,
        ParentId,
        ParentWebId,
        FullUrl,
        IsSelected,
        IsIncremental)
    SELECT DISTINCT
        ev.ListId,
        3,
        0,
        Docs.DirName,
        Docs.LeafName,
        Lists.tp_WebId,
        Lists.tp_WebId,
        CASE
            WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName
            WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName
            ELSE Docs.DirName + N'/' + Docs.LeafName
        END,
        e.IsSelected,
        1  
    FROM
        EventCache ev
    INNER JOIN #IncrementalSearchScope e
    ON
        ev.SiteId = @SiteId AND
        ev.WebId = e.Id AND
        e.Type = 1 AND
        e.IncludeDescendants > 0 AND
        ev.EventTime >= e.ChangeTime AND
        ev.Id > e.ChangeNumber AND
        ev.EventTime <= @ChangeTimeEnd AND
        ev.Id <= @ChangeNumberEnd
    INNER JOIN
        Lists
    ON
        ev.SiteId = @SiteId AND
        ev.ListId = Lists.tp_ID AND
        (ev.ObjectType & @ObjectTypeMask) != 0 AND
        (ev.EventType & @EventTypeMask) != 0
    INNER JOIN
        Docs
    ON
        Lists.tp_RootFolder IS NOT NULL AND
        Lists.tp_RootFolder = Docs.Id AND
        Docs.SiteId = @SiteId
    WHERE
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects e
            WHERE
                e.Id = ev.WebId AND
                e.IsDeleted = 1) AND 
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects e
            WHERE
                e.Id = ev.ListId AND
                    e.IsDeleted = 1)    
    SET @ObjectTypeMask = 1
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        ParentId,
        ParentWebId,
        FullUrl,
        IsDeleted,
        IsSelected,
        IsIncremental)
    SELECT DISTINCT
        ev.DocId,
        4,
        0,
        ev.ListId,
        ev.WebId,
        ev.ItemFullUrl,
        1,
        e.IsSelected,
        1
    FROM
        EventCache ev
    INNER JOIN #IncrementalSearchScope e
    ON
        ev.SiteId = @SiteId AND
        ev.WebId = e.Id AND
        e.Type = 1 AND
        e.IncludeDescendants > 0 AND
        ev.EventTime >= e.ChangeTime AND
        ev.Id > e.ChangeNumber AND
        ev.EventTime <= @ChangeTimeEnd AND
        ev.Id <= @ChangeNumberEnd
    WHERE
        (ev.ObjectType & @ObjectTypeMask) != 0 AND
        (ev.EventType & @DeletedEventTypeMask) != 0 AND
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects e
            WHERE
                e.Id = ev.WebId AND
                e.IsDeleted = 1) AND
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects e
            WHERE
                e.Id = ev.ListId AND
                e.IsDeleted = 1) 
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        DirName,
        LeafName,
        ParentId,
        ParentWebId,
        FullUrl,
        IsSelected,
        IsIncremental)
    SELECT
        NEWID(),
        4,
        0,
        ud.tp_DirName,
        ud.tp_LeafName,
        ud.tp_ListId,
        ud.WebId,
        CASE
            WHEN (DATALENGTH(ud.tp_DirName) = 0) THEN ud.tp_LeafName
            WHEN (DATALENGTH(ud.tp_LeafName) = 0) THEN ud.tp_DirName
            ELSE ud.tp_DirName + N'/' + ud.tp_LeafName
        END,
        ud.IsSelected,
        1          
    FROM
    (
        SELECT DISTINCT
            UserData.tp_DirName,
            UserData.tp_LeafName,
            UserData.tp_ListId,
            ev.WebId,
            e.IsSelected
        FROM
            EventCache ev
        INNER JOIN #IncrementalSearchScope e
        ON
            ev.SiteId = @SiteId AND
            ev.WebId = e.Id AND
            e.Type = 1 AND
            e.IncludeDescendants > 0 AND
            ev.EventTime >= e.ChangeTime AND
            ev.Id > e.ChangeNumber AND
            ev.EventTime <= @ChangeTimeEnd AND
            ev.Id <= @ChangeNumberEnd
        INNER JOIN
            UserData
        ON
            ev.SiteId = @SiteId AND
            UserData.tp_SiteId = @SiteId AND
            ev.ListId = UserData.tp_ListId AND
            ev.ItemId = UserData.tp_ID AND
            (ev.ObjectType & @ObjectTypeMask) != 0 AND
            (ev.EventType & @EventTypeMask) != 0
        WHERE
            ((@IsMajorFileOnly = 1 AND UserData.tp_Level=1) OR
            (@IsMajorFileOnly = 0 AND UserData.tp_Level IN
                (SELECT TOP 1 d2.tp_Level FROM UserData d2
                WHERE
                d2.tp_Id = UserData.tp_Id AND
                d2.tp_ListId = UserData.tp_ListId AND
                d2.tp_Level <> 255))) AND
            NOT EXISTS (
                SELECT 1
                FROM #ExportObjects e
                WHERE
                    e.Id = ev.WebId AND
                    e.IsDeleted = 1) AND    
            NOT EXISTS (
                SELECT 1
                FROM #ExportObjects e
                WHERE
                    e.Id = ev.ListId AND
                    e.IsDeleted = 1)          
    ) as ud
    SET @ObjectTypeMask = 512 | 1024
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        ParentWebId,
        ContentTypeId,
        IsDeleted,
        IsSelected,
        IsIncremental)
    SELECT
        CASE
            WHEN (ev2.ObjectType & 512) != 0 THEN NEWID()
            ELSE ev2.ContentTypeId
        END,
        CASE
            WHEN (ev2.ObjectType & 512) != 0 THEN 8
            ELSE 10
        END,
        0,
        ev2.WebId,
        ev2.ContentTypeId,
        1,
        ev2.IsSelected,
        1
    FROM
    (
        SELECT DISTINCT
            ev.WebId,
            ev.ContentTypeId,
            ev.ObjectType,
            e.IsSelected
        FROM
            EventCache ev
        INNER JOIN #IncrementalSearchScope e
        ON
            ev.SiteId = @SiteId AND
            ev.WebId = e.Id AND
            e.Type = 1 AND
            e.IncludeDescendants > 0 AND
            ev.EventTime >= e.ChangeTime AND
            ev.Id > e.ChangeNumber AND
            ev.EventTime <= @ChangeTimeEnd AND
            ev.Id <= @ChangeNumberEnd
        WHERE
            (EventType & @DeletedEventTypeMask) != 0 AND
            (ObjectType & @ObjectTypeMask) != 0 AND
            NOT EXISTS (
                SELECT 1
                FROM #ExportObjects e
                WHERE
                    e.Id = ev.WebId AND
                    e.IsDeleted = 1)
    ) as ev2
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        DirName,
        LeafName,
        ParentId,
        ParentWebId,
        FullUrl,
        ContentTypeId,
        ParseContentType,
        IsSelected,
        IsIncremental)
    SELECT
        CASE
            WHEN res.Class = 1 THEN NEWID()
            ELSE res.ContentTypeId
        END,
        CASE
            WHEN res.Class = 1 THEN 8
            ELSE 10
        END,
        0,
        res.Scope,
        '',
        res.WebId,
        res.WebId,
        res.Scope,
        res.ContentTypeId,
        CASE
            WHEN res.Class = 1 THEN 1
            ELSE 0
        END,
        res.IsSelected,
        1
    FROM (
        SELECT DISTINCT
            ct.Class,
            ct.Scope,
            ev.WebId,
            ct.ContentTypeId,
            e.IsSelected
        FROM
            EventCache ev
        INNER JOIN #IncrementalSearchScope e
        ON
            ev.SiteId = @SiteId AND
            ev.WebId = e.Id AND
            e.Type = 1 AND
            e.IncludeDescendants > 0 AND
            ev.EventTime >= e.ChangeTime AND
            ev.Id > e.ChangeNumber AND
            ev.EventTime <= @ChangeTimeEnd AND
            ev.Id <= @ChangeNumberEnd
        INNER JOIN
            Webs
        ON
            ev.SiteId = @SiteId AND
            Webs.SiteId =  @SiteId AND
            ev.WebId = Webs.Id
        INNER JOIN
            ContentTypes ct
        ON
            ev.SiteId = @SiteId AND
            ct.SiteId = @SiteId AND
            ct.Scope = Webs.FullUrl AND
            ev.ContentTypeId = ct.ContentTypeId
        WHERE
            (ev.EventType & @EventTypeMask) != 0 AND
            (ev.ObjectType & @ObjectTypeMask) != 0 AND
            NOT EXISTS (
                SELECT 1
                FROM #ExportObjects e
                WHERE
                    e.Id = ev.WebId AND
                    e.IsDeleted = 1) AND
            NOT EXISTS (
                SELECT 1
                FROM #ExportObjects e
                WHERE
                    ev.ContentTypeId = e.ContentTypeId AND
                    e.IsDeleted = 1) ) as res
    RETURN 0

GO
