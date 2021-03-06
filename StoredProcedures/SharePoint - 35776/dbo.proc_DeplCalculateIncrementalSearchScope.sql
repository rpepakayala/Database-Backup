/****** Object:  StoredProcedure [dbo].[proc_DeplCalculateIncrementalSearchScope]    Script Date: 5/15/2018 12:11:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplCalculateIncrementalSearchScope(
    @SiteId uniqueidentifier)
AS
    SET NOCOUNT ON
    IF @SiteId IS NULL
        RETURN 87
    DECLARE @Level int
    SET @Level = 0
    DECLARE @DeletedEventTypeMask int    
    SET @DeletedEventTypeMask = 4 |
                                64 |
                                16384
    WHILE EXISTS(
        SELECT
            TOP 1 Id
        FROM #IncrementalSearchScope
        WHERE
            Level = @Level AND
            IncludeDescendants = 2)
    BEGIN
        INSERT INTO #IncrementalSearchScope(
            Id,
            Level,
            DirName,
            LeafName,
            Type,
            ParentId,
            ParentWebId,
            IncludeDescendants,
            FullUrl,
            ChangeTime,
            ChangeNumber)
        SELECT
            Webs.Id,
            @Level + 1,
            Docs.DirName,
            Docs.LeafName,
            1,
            Webs.ParentWebId,
            Webs.Id,
            e.IncludeDescendants,
            Webs.FullUrl,
            e.ChangeTime,
            e.ChangeNumber
        FROM
            Webs
        INNER JOIN #IncrementalSearchScope e
        ON
            Webs.SiteId = @SiteId AND
            Webs.ParentWebId = e.Id AND
            e.Type = 1 AND
            e.IncludeDescendants = 2 AND
            e.Level = @Level
        INNER JOIN
            Docs
        ON
            Docs.WebId = Webs.Id AND
            Docs.Type = 2 AND
            Webs.ProductVersion >= 3
        WHERE
            NOT EXISTS (
                SELECT 1
                FROM #IncrementalSearchScope existing
                WHERE
                    Webs.Id = existing.Id)
        INSERT INTO #IncrementalSearchScope(
            Id,
            Level,
            Type,
            ParentId,
            ParentWebId,
            IncludeDescendants,
            FullUrl,
            ChangeTime,
            ChangeNumber)
        SELECT
            ev.WebId,
            @Level + 1,
            1,
            ev.WebId,
            ev.WebId,
            e.IncludeDescendants,
            ev.ItemFullUrl,
            e.ChangeTime,
            e.ChangeNumber
        FROM
            #IncrementalSearchScope e
        INNER JOIN EventCache ev
        ON
            ev.SiteId = @SiteId AND
            ev.ItemFullUrl LIKE e.FullUrl + '/%' AND
            e.Type = 1 AND
            e.IncludeDescendants = 2 AND
            e.Level = @Level AND
            (ev.ObjectType & 4) != 0 AND
            ev.EventTime >= e.ChangeTime AND
            ev.Id > e.ChangeNumber AND
           (ev.EventType & @DeletedEventTypeMask) != 0 
        WHERE
            NOT EXISTS (
                SELECT 1
                FROM #IncrementalSearchScope existing
                WHERE
                    ev.WebId = existing.Id)
        SET @Level = @Level + 1
    END
    RETURN 0

GO
