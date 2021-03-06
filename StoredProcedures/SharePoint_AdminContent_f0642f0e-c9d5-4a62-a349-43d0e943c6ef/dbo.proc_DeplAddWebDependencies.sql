/****** Object:  StoredProcedure [dbo].[proc_DeplAddWebDependencies]    Script Date: 5/15/2018 12:12:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplAddWebDependencies(
    @SiteId uniqueidentifier,
    @FullSiteExport tinyint,
    @IsMajorFileOnly int)
AS
    SET NOCOUNT ON
    DECLARE @Level int
    SET @Level = 0
    IF NOT EXISTS
        (SELECT TOP 1 Id FROM #ExportObjects
         WHERE Type = 1)
        RETURN 0
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        DirName,
        LeafName,
        ParentId,
        ParentWebId,
        IncludeDescendants,
        FullUrl)
    SELECT
        Docs.Id,
        CASE
            WHEN Docs.DocLibRowId IS NOT NULL THEN 6
            ELSE 2
        END,
        @Level,
        Docs.DirName,
        Docs.LeafName,
        Docs.ParentId,
        Docs.WebId,
        CASE
            WHEN e.IncludeDescendants = 1 THEN
            2
            ELSE e.IncludeDescendants
        END,
        CASE
            WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName
            WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName
            ELSE Docs.DirName + N'/' + Docs.LeafName
        END
    FROM
        Docs
    INNER JOIN #ExportObjects e
    ON
        SiteId = @SiteId AND
        e.DirName = Docs.DirName AND
        e.LeafName = Docs.LeafName AND
        e.IsDeleted = 0 AND
        Docs.Type = 2 AND
        e.Type = 1
    WHERE  NOT EXISTS (
        SELECT 1
        FROM #ExportObjects existing
        WHERE
            Docs.Id = existing.Id)
    IF @FullSiteExport = 1
        RETURN 0
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        DirName,
        LeafName,
        ParentId,
        ParentWebId,
        IncludeDescendants,
        FullUrl)
    SELECT
        Docs.Id,
        CASE
            WHEN Docs.DocLibRowId IS NOT NULL THEN 6
            ELSE 2
        END,
        @Level + 1,
        Docs.DirName,
        Docs.LeafName,
        Docs.ParentId,
        Docs.WebId,
        CASE
            WHEN Docs.LeafName = '_cts' OR
                 Docs.LeafName = '_catalogs'
            THEN 2 
            ELSE e.IncludeDescendants
        END as IncludeDescendants,
        CASE
            WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName
            WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName
            ELSE Docs.DirName + N'/' + Docs.LeafName
        END
    FROM
        Docs
    INNER JOIN #ExportObjects e
    ON
        SiteId = @SiteId AND
        Docs.ParentId = e.Id AND
        e.IncludeDescendants = 0 AND
        e.IsDeleted = 0 AND
        e.IsIncremental = 0
    WHERE
        Docs.LeafName IN
            ('_catalogs',
             'Lists',
             '_private',
             '_cts') AND
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects existing
            WHERE
                Docs.Id = existing.Id)
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        DirName,
        LeafName,
        ParentId,
        ParentWebId,
        IncludeDescendants,
        FullUrl)
    SELECT
        Lists.tp_ID,
        3,
        @Level + 1,
        Docs.DirName,
        Docs.LeafName,
        Lists.tp_WebId,
        Lists.tp_WebId,
        2,
        CASE
            WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName
            WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName
            ELSE Docs.DirName + N'/' + Docs.LeafName
        END
    FROM
        Lists
    INNER JOIN #ExportObjects e
    ON
        Lists.tp_WebId = e.Id AND
        e.IncludeDescendants = 0 AND
        e.IsDeleted = 0 AND
        e.IsIncremental = 0 AND
        (Lists.tp_Flags & 16) <> 0
    INNER JOIN
        Docs
    ON
        Lists.tp_RootFolder = Docs.Id
    WHERE NOT EXISTS (
        SELECT 1
        FROM #ExportObjects existing
        WHERE
            Lists.tp_ID = existing.Id)
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        DirName,
        LeafName,
        ParentId,
        ParentWebId,
        IncludeDescendants,
        FullUrl,
        ContentTypeId)
    SELECT
        CASE
            WHEN ct.Class = 1 THEN NEWID()
            ELSE ct.ContentTypeId
        END,
        CASE
            WHEN ct.Class = 1 THEN 8
            ELSE 10
        END,
        @Level + 1,
        ct.Scope,
        '',
        Webs.Id,
        Webs.Id,
        0,
        ct.Scope,
        ct.ContentTypeId
    FROM
        ContentTypes ct
    INNER JOIN
        Webs
    ON
        ct.Scope = Webs.FullUrl AND
        ct.SiteId = @SiteId
    INNER JOIN #ExportObjects e
    ON
        Webs.Id = e.Id AND
        e.IncludeDescendants = 0 AND
        e.IsDeleted = 0 AND
        e.IsIncremental = 0
    WHERE NOT EXISTS (
        SELECT 1
        FROM #ExportObjects existing
        WHERE
            ct.ContentTypeId = existing.ContentTypeId)
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        DirName,
        LeafName,
        ParentId,
        ParentWebId,
        IncludeDescendants,
        FullUrl)
    SELECT
        Docs.Id,
        5,
        @Level + 1,
        Docs.DirName,
        Docs.LeafName,
        Docs.ParentId,
        Docs.WebId,
        0,
        CASE
            WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName
            WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName
            ELSE Docs.DirName + N'/' + Docs.LeafName
        END
    FROM Docs
    WHERE
        Docs.Id IN (
            SELECT TOP 1
                d2.Id
            FROM
                WelcomeNames INNER JOIN Docs d2
            ON
                d2.SiteId = @SiteId AND
                d2.LeafName = WelcomeNames.LeafName AND
                d2.Type = 0 AND
                d2.DirName = Docs.DirName AND
                d2.LeafName = Docs.LeafName
            INNER JOIN #ExportObjects e
            ON
                e.IsDeleted = 0 AND
                e.Type = 1 AND
                e.IncludeDescendants = 0 AND
                e.IsIncremental = 0 AND
                d2.DirName = e.FullUrl
            ORDER BY
                WelcomeNames.Rank ASC) AND
            ((@IsMajorFileOnly = 1 AND Docs.Level=1) OR
            (@IsMajorFileOnly = 0 AND Docs.Level IN
                (SELECT TOP 1 d3.Level FROM Docs d3
                WHERE d3.Id=Docs.Id AND d3.Level <> 255))) AND                
        NOT EXISTS(
            SELECT 1
            FROM #ExportObjects existing
            WHERE
                Docs.Id = existing.Id)
    OPTION (FORCE ORDER)
    INSERT INTO #ExportObjects(
        Id,
        Level,
        Type,
        ParentId,
        ParentWebId)
    SELECT
        NEWID(),
        @Level + 1,
        9,
        e.Id,
        e.Id
    FROM #ExportObjects e
    WHERE
        e.Type = 1 AND
        e.IsDeleted = 0 AND
        e.IncludeDescendants = 0 AND
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects existing
            WHERE
                existing.Type = 9 AND
                existing.ParentId = e.Id)
    INSERT INTO #ExportObjects(
        Id,
        Level,
        Type,
        ParentId,
        ParentWebId)
    SELECT
        NEWID(),
        @Level+1,
        15,
        e.Id,
        e.Id
    FROM #ExportObjects e
    WHERE
        e.Type = 1 AND
        e.IsDeleted = 0 AND
        e.IsIncremental = 0 AND
        e.IncludeDescendants = 0 AND
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects existing
            WHERE
                existing.Type = 15 AND
                existing.ParentId = e.Id)
    INSERT INTO #ExportObjects(
        Id,
        Level,
        Type,
        ParentId,
        ParentWebId)
    SELECT
        NEWID(),
        @Level+1,
        17,
        e.Id,
        e.Id
    FROM #ExportObjects e
    WHERE
        e.Type = 1 AND
        e.IsDeleted = 0 AND
        e.IsIncremental = 0 AND
        e.IncludeDescendants = 0 AND
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects existing
            WHERE
                existing.Type = 17 AND
                existing.ParentId = e.Id)

GO
