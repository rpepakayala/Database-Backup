/****** Object:  StoredProcedure [dbo].[proc_NavStructDirtyPageDependents]    Script Date: 5/15/2018 12:12:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_NavStructDirtyPageDependents(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @EidParent int)
AS
    DECLARE @DepDesc nvarchar(260)
    SET @DepDesc = N'P:C|' + CAST(@EidParent AS nvarchar(32))
    EXEC proc_DirtyDependents @SiteId, 4, @DepDesc
    UPDATE
        Webs
    SET
        CachedNavDirty = 1
    WHERE
        Id = @WebId OR
        NavParentWebId = @WebId
    UPDATE
        Docs
    SET
        Docs.Dirty = 1,
        Docs.CacheParseId = NULL
    FROM
        NavNodes ParentNavNode WITH (NOLOCK)
    INNER JOIN
        Docs
    ON
        Docs.Id = ParentNavNode.DocId
    WHERE
        ParentNavNode.SiteId = @SiteId AND
        ParentNavNode.WebId = @WebId AND
        ParentNavNode.Eid = @EidParent AND
        Docs.HasStream = 1
    UPDATE
        Docs
    SET
        Docs.Dirty = 1,
        Docs.CacheParseId = NULL
    FROM
        NavNodes SiblingNavNode WITH (NOLOCK)
    INNER JOIN
        Docs
    ON
        Docs.Id = SiblingNavNode.DocId
    WHERE
        SiblingNavNode.SiteId = @SiteId AND
        SiblingNavNode.WebId = @WebId AND
        SiblingNavNode.EidParent = @EidParent AND
        Docs.HasStream = 1
    UPDATE
        Docs
    SET
        Docs.Dirty = 1,
        Docs.CacheParseId = NULL
    FROM
        NavNodes SiblingNavNode WITH (NOLOCK)
    INNER JOIN
        NavNodes ChildNavNodes
    ON
        SiblingNavNode.Siteid = ChildNavNodes.SiteId AND
        SiblingNavNode.WebId = ChildNavNodes.WebId AND
        SiblingNavNode.Eid = ChildNavNodes.EidParent
    INNER JOIN
        Docs
    ON
        Docs.Id = ChildNavNodes.DocId
    WHERE
        SiblingNavNode.SiteId = @SiteId AND
        SiblingNavNode.WebId = @WebId AND
        SiblingNavNode.EidParent = @EidParent AND
        Docs.HasStream = 1

GO
