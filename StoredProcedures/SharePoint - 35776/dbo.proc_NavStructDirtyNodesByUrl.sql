/****** Object:  StoredProcedure [dbo].[proc_NavStructDirtyNodesByUrl]    Script Date: 5/15/2018 12:12:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_NavStructDirtyNodesByUrl(
    @SiteId uniqueidentifier,
    @UrlDir nvarchar(256),
    @UrlLeaf nvarchar(128),
    @UrlLike nvarchar(1024),
    @Now datetime)
AS
    DECLARE @DirtyEids TABLE ( Eid int, WebId uniqueidentifier, EidParent int, NavCacheMask int, DocId uniqueidentifier NULL, Stage tinyint, UNIQUE(WebId, Eid, Stage))
    DECLARE @InitalRows int
    IF @UrlLike IS NOT NULL
    BEGIN
        DECLARE @UrlDirDir nvarchar(256),
            @UrlDirLeaf nvarchar(128)
        EXEC proc_SplitUrl @UrlDir, @UrlDirDir OUTPUT, @UrlDirLeaf OUTPUT
        INSERT INTO @DirtyEids (
            Eid,
            EidParent,
            NavCacheMask,
            WebId,
            DocId,
            Stage)
            SELECT
                NavNodes.Eid,
                NavNodes.EidParent,
                dbo.fn_NavCacheMask(NavNodes.EidParent),
                NavNodes.WebId,
                NavNodes.DocId,
                1
            FROM
                NavNodes
            INNER JOIN
                Docs
            ON
                Docs.SiteId = NavNodes.SiteId AND
                Docs.Id = NavNodes.DocId
            WHERE
                Docs.SiteId = @SiteId AND
                Docs.Level = 1 AND
                (Docs.DirName = @UrlDir OR
                    (Docs.DirName = @UrlDirDir AND
                        Docs.LeafName = @UrlDirLeaf) OR
                    Docs.DirName LIKE @UrlLike)
        SET @InitalRows = @@ROWCOUNT
    END
    ELSE
    BEGIN
        INSERT INTO @DirtyEids (
            Eid,
            EidParent,
            NavCacheMask,
            WebId,
            DocId,
            Stage)
            SELECT
                NavNodes.Eid,
                NavNodes.EidParent,
                dbo.fn_NavCacheMask(NavNodes.EidParent),
                NavNodes.WebId,
                NavNodes.DocId,
                1
            FROM
                NavNodes
            INNER JOIN
                Docs
            ON
                Docs.SiteId = NavNodes.SiteId AND
                Docs.Id = NavNodes.DocId
            WHERE
                Docs.SiteId = @SiteId AND
                Docs.DirName = @UrlDir AND
                Docs.LeafName = @UrlLeaf AND
                Docs.Level = 1
        SET @InitalRows = @@ROWCOUNT
    END
    IF @InitalRows = 0
    BEGIN
        RETURN 0
    END
    DECLARE @WebCount int SELECT @WebCount = COUNT(*) FROM Webs WITH (UPDLOCK) WHERE Webs.Id IN (SELECT WebId FROM @DirtyEids) OR (Webs.NavParentWebId IN (SELECT WebId FROM @DirtyEids))
    UPDATE
        NavNodes
    SET
        NavNodes.DateLastModified = @Now
    FROM
        NavNodes
    INNER JOIN
        @DirtyEids Eids
    ON
        NavNodes.WebId = Eids.WebId AND
        NavNodes.Eid = Eids.Eid
    WHERE
        NavNodes.SiteId = @SiteId
    DECLARE @DepList table (DocUrl nvarchar(260) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL, Level tinyint DEFAULT 1 NOT NULL, DirName AS ISNULL(CASE WHEN (CHARINDEX(N'/', REVERSE(DocUrl)) > 0) THEN LEFT(DocUrl, DATALENGTH(DocUrl)/2 - CHARINDEX(N'/', REVERSE(DocUrl) COLLATE Latin1_General_BIN)) ELSE N'' END, N''), LeafName AS ISNULL(CASE WHEN (CHARINDEX(N'/', REVERSE(DocUrl) COLLATE Latin1_General_BIN) > 0) THEN RIGHT(DocUrl, CHARINDEX(N'/', REVERSE(DocUrl) COLLATE Latin1_General_BIN) - 1) ELSE DocUrl END, DocUrl), UNIQUE (DocUrl,Level)) INSERT INTO @DepList (DocUrl,Level) SELECT DISTINCT Deps.FullUrl,Deps.Level FROM Deps INNER JOIN @DirtyEids DirtyEids ON Deps.DepDesc = N'P:C|' + CAST(DirtyEids.EidParent AS nvarchar(32)) WHERE Deps.SiteId = @SiteId AND Deps.DeleteTransactionId = '00000000-0000-0000-0000-000000000000' AND Deps.DepType = 4 UPDATE Webs SET CachedNavDirty = 1 WHERE Webs.Id IN (SELECT WebId FROM @DirtyEids) OR (Webs.NavParentWebId IN (SELECT WebId FROM @DirtyEids)) DECLARE @IterCount int SELECT @IterCount = 0 WHILE @IterCount < 32 BEGIN INSERT INTO @DepList (DocUrl, Level) SELECT DISTINCT Deps.FullUrl,Deps.Level FROM @DepList DepList1 INNER JOIN Deps ON Deps.DepType = 1 AND Deps.DepDesc = DepList1.DocUrl AND DepList1.Level = 1 LEFT OUTER JOIN @DepList DepList2 ON DepList2.DocUrl = Deps.FullUrl WHERE Deps.SiteId = @SiteId AND Deps.DeleteTransactionId = 0x AND DepList2.DocUrl IS NULL IF @@RowCount = 0 BREAK SELECT @IterCount = @IterCount + 1 END IF @IterCount >= 32 BEGIN INSERT INTO @DepList (DocUrl,Level) SELECT DISTINCT FullUrl,Level FROM Deps WHERE DepType = 1 AND SiteId = @SiteId AND DeleteTransactionId = 0x AND FullUrl NOT IN (SELECT DocUrl FROM @DepList) END UPDATE Docs SET Docs.Dirty = 1, Docs.CacheParseId = NULL FROM Docs INNER JOIN @DepList DepList1 ON Docs.SiteId = @SiteId AND Docs.DirName = DepList1.DirName AND Docs.LeafName = DepList1.LeafName AND Docs.Level = DepList1.Level
    INSERT INTO @DirtyEids (
        Eid,
        EidParent,
        NavCacheMask,
        WebId,
        DocId,
        Stage)
        SELECT DISTINCT
            NavNodes.Eid,
            NavNodes.EidParent,
            0, 
            NavNodes.WebId,
            NavNodes.DocId,
            0
        FROM
            @DirtyEids DirtyNodes
        INNER JOIN
            NavNodes
        ON
            DirtyNodes.WebId = NavNodes.WebId AND
            DirtyNodes.EidParent = NavNodes.Eid
        LEFT OUTER JOIN
            @DirtyEids ExistingDirtyNodes
        ON
            NavNodes.WebId = ExistingDirtyNodes.WebId AND
            NavNodes.Eid = ExistingDirtyNodes.Eid
        WHERE
            NavNodes.SiteId = @SiteId AND
            NavNodes.DocId IS NOT NULL AND
            ExistingDirtyNodes.Eid IS NULL
    INSERT INTO @DirtyEids (
        Eid,
        EidParent,
        NavCacheMask,
        WebId,
        DocId,
        Stage)
        SELECT
            NavNodes.Eid,
            NavNodes.EidParent,
            0, 
            NavNodes.WebId,
            NavNodes.DocId,
            1
        FROM
            @DirtyEids DirtyNodes
        INNER JOIN
            NavNodes
        ON
            DirtyNodes.WebId = NavNodes.WebId AND
            DirtyNodes.Eid = NavNodes.EidParent
        LEFT OUTER JOIN
            @DirtyEids ExistingDirtyNodes
        ON
            NavNodes.WebId = ExistingDirtyNodes.WebId AND
            NavNodes.Eid = ExistingDirtyNodes.Eid
        WHERE
            NavNodes.SiteId = @SiteId AND
            NavNodes.DocId IS NOT NULL AND
            ExistingDirtyNodes.Eid IS NULL AND
            DirtyNodes.Stage = 0
    INSERT INTO @DirtyEids (
        Eid,
        EidParent,
        NavCacheMask,
        WebId,
        DocId,
        Stage)
        SELECT
            NavNodes.Eid,
            NavNodes.EidParent,
            0, 
            NavNodes.WebId,
            NavNodes.DocId,
            2
        FROM
            @DirtyEids DirtyNodes
        INNER JOIN
            NavNodes
        ON
            DirtyNodes.WebId = NavNodes.WebId AND
            DirtyNodes.Eid = NavNodes.EidParent
        LEFT OUTER JOIN
            @DirtyEids ExistingDirtyNodes
        ON
            NavNodes.WebId = ExistingDirtyNodes.WebId AND
            NavNodes.Eid = ExistingDirtyNodes.Eid
        WHERE
            NavNodes.SiteId = @SiteId AND
            NavNodes.DocId IS NOT NULL AND
            ExistingDirtyNodes.Eid IS NULL AND
            DirtyNodes.Stage = 1
    UPDATE
        Docs
    SET
        Docs.Dirty = 1,
        Docs.CacheParseId = NULL
    FROM
        Docs
    INNER JOIN
        @DirtyEids DirtyNodes
    ON
        Docs.Id = DirtyNodes.DocId
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.HasStream = 1

GO
