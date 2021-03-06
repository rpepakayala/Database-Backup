/****** Object:  StoredProcedure [dbo].[proc_NavStructDeleteNodeByIds]    Script Date: 5/15/2018 12:12:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_NavStructDeleteNodeByIds(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @Eid int,
    @DateModified datetime,
    @@DateModifiedReally datetime OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @EidParent int
    DECLARE @RankChild int
    DECLARE @DocId uniqueidentifier
    SELECT
        @EidParent = EidParent,
        @RankChild = RankChild,
        @@DateModifiedReally = DateLastModified,
        @DocId = DocId
    FROM
        NavNodes
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        Eid = @Eid
    IF @EidParent IS NULL
    BEGIN
        RETURN 0
    END
    IF @DateModified <> @@DateModifiedReally AND
        @DateModified IS NOT NULL
    BEGIN
        RETURN 10004
    END
    DECLARE @DeletedEids TABLE ( Eid int, WebId uniqueidentifier, EidParent int, NavCacheMask int, DocId uniqueidentifier NULL, Stage tinyint, UNIQUE(WebId, Eid, Stage))
    INSERT @DeletedEids (Eid, EidParent, NavCacheMask, WebId, DocId, Stage)
        VALUES (@Eid, @EidParent, dbo.fn_NavCacheMask(@EidParent), @WebId,
            @DocId, 0)
    WHILE @@RowCount > 0
    BEGIN
        INSERT INTO @DeletedEids (
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
            @WebId,
            NavNodes.DocId,
            0
        FROM
            NavNodes
        INNER JOIN
            @DeletedEids Deleted
        ON
            NavNodes.EidParent = Deleted.Eid
        LEFT OUTER JOIN
            @DeletedEids Deleted2
        ON
            NavNodes.Eid = Deleted2.Eid
        WHERE
            NavNodes.SiteId = @SiteId AND
            NavNodes.WebId = @WebId AND
            Deleted2.Eid IS NULL
    END
    DECLARE @WebCount int SELECT @WebCount = COUNT(*) FROM Webs WITH (UPDLOCK) WHERE Webs.Id IN (SELECT WebId FROM @DeletedEids) OR (Webs.NavParentWebId IN (SELECT WebId FROM @DeletedEids))
    DELETE
        NavNodes
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        (Eid IN (
            SELECT
                Eid
            FROM
                @DeletedEids))
    IF EXISTS(
        SELECT
            *
        FROM
            NavNodes
        INNER JOIN
            @DeletedEids Deleted
        ON
            Deleted.Eid = NavNodes.EidParent
        WHERE
            NavNodes.SiteId = @SiteId AND
            NavNodes.WebId = @WebId
        )
    BEGIN
        SET @@DateModifiedReally = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
        RETURN 10004
    END
    UPDATE
        NavNodes
    SET
        NumChildren = NumChildren - 1
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        Eid = @EidParent
    UPDATE
        NavNodes
    SET
        RankChild = RankChild - 1
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        EidParent = @EidParent AND
        RankChild > @RankChild
    DECLARE @DepList table (DocUrl nvarchar(260) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL, Level tinyint DEFAULT 1 NOT NULL, DirName AS ISNULL(CASE WHEN (CHARINDEX(N'/', REVERSE(DocUrl)) > 0) THEN LEFT(DocUrl, DATALENGTH(DocUrl)/2 - CHARINDEX(N'/', REVERSE(DocUrl) COLLATE Latin1_General_BIN)) ELSE N'' END, N''), LeafName AS ISNULL(CASE WHEN (CHARINDEX(N'/', REVERSE(DocUrl) COLLATE Latin1_General_BIN) > 0) THEN RIGHT(DocUrl, CHARINDEX(N'/', REVERSE(DocUrl) COLLATE Latin1_General_BIN) - 1) ELSE DocUrl END, DocUrl), UNIQUE (DocUrl,Level)) INSERT INTO @DepList (DocUrl,Level) SELECT DISTINCT Deps.FullUrl,Deps.Level FROM Deps INNER JOIN @DeletedEids DeletedEids ON Deps.DepDesc = N'P:C|' + CAST(DeletedEids.EidParent AS nvarchar(32)) WHERE Deps.SiteId = @SiteId AND Deps.DeleteTransactionId = '00000000-0000-0000-0000-000000000000' AND Deps.DepType = 4 UPDATE Webs SET CachedNavDirty = 1 WHERE Webs.Id IN (SELECT WebId FROM @DeletedEids) OR (Webs.NavParentWebId IN (SELECT WebId FROM @DeletedEids)) DECLARE @IterCount int SELECT @IterCount = 0 WHILE @IterCount < 32 BEGIN INSERT INTO @DepList (DocUrl, Level) SELECT DISTINCT Deps.FullUrl,Deps.Level FROM @DepList DepList1 INNER JOIN Deps ON Deps.DepType = 1 AND Deps.DepDesc = DepList1.DocUrl AND DepList1.Level = 1 LEFT OUTER JOIN @DepList DepList2 ON DepList2.DocUrl = Deps.FullUrl WHERE Deps.SiteId = @SiteId AND Deps.DeleteTransactionId = 0x AND DepList2.DocUrl IS NULL IF @@RowCount = 0 BREAK SELECT @IterCount = @IterCount + 1 END IF @IterCount >= 32 BEGIN INSERT INTO @DepList (DocUrl,Level) SELECT DISTINCT FullUrl,Level FROM Deps WHERE DepType = 1 AND SiteId = @SiteId AND DeleteTransactionId = 0x AND FullUrl NOT IN (SELECT DocUrl FROM @DepList) END UPDATE Docs SET Docs.Dirty = 1, Docs.CacheParseId = NULL FROM Docs INNER JOIN @DepList DepList1 ON Docs.SiteId = @SiteId AND Docs.DirName = DepList1.DirName AND Docs.LeafName = DepList1.LeafName AND Docs.Level = DepList1.Level
    DELETE Deps FROM Deps, @DeletedEids DeletedEids WHERE SiteId = @SiteId AND DeleteTransactionId = '00000000-0000-0000-0000-000000000000' AND DepType = 4 AND Deps.DepDesc = N'P:C|' + CAST(DeletedEids.Eid AS nvarchar(32))
    UPDATE
        Docs
    SET
        Docs.Dirty = 1,
        Docs.CacheParseId = NULL
    FROM
        Docs
    INNER JOIN
        @DeletedEids DeletedEids
    ON
        Docs.Id = DeletedEids.DocId
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.HasStream = 1
    UPDATE
        Docs
    SET
        Docs.Dirty = 1,
        Docs.CacheParseId = NULL
    FROM
        Docs
    INNER JOIN
        NavNodes
    ON
        Docs.Id = NavNodes.DocId AND
        Docs.SiteId = NavNodes.SiteId
    WHERE
        NavNodes.SiteId = @SiteId AND
        NavNodes.WebId = @WebId AND
        NavNodes.Eid = @EidParent AND
        Docs.HasStream = 1
    UPDATE
        Docs
    SET
        Docs.Dirty = 1,
        Docs.CacheParseId = NULL
    FROM
        Docs
    INNER JOIN
        NavNodes
    ON
        Docs.Id = NavNodes.DocId AND
        Docs.SiteId = NavNodes.SiteId
    WHERE
        NavNodes.SiteId = @SiteId AND
        NavNodes.WebId = @WebId AND
        NavNodes.EidParent = @EidParent AND
        Docs.HasStream = 1

GO
