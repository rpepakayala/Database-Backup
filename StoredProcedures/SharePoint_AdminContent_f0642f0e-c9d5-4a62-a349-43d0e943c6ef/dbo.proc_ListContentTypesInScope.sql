/****** Object:  StoredProcedure [dbo].[proc_ListContentTypesInScope]    Script Date: 5/15/2018 12:12:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ListContentTypesInScope(
    @SiteId uniqueidentifier,
    @Class tinyint,
    @Scope nvarchar(256))
AS
    SET NOCOUNT ON
    DECLARE @WebId uniqueidentifier,
        @ScopeDir nvarchar(256),
        @ScopeLeaf nvarchar(128)
    DECLARE @Scopes table (
        Scope nvarchar(256) COLLATE Latin1_General_CI_AS_KS_WS)
    EXEC proc_SplitUrl @Scope, @ScopeDir OUTPUT, @ScopeLeaf OUTPUT
    SELECT
        @WebId = Docs.WebId
    FROM
        Docs
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @ScopeDir AND
        Docs.LeafName = @ScopeLeaf AND
        Docs.Type = 2
    IF @WebId IS NULL
        RETURN 144
    WHILE @WebId IS NOT NULL
    BEGIN
        SELECT
            @WebId = Webs.ParentWebId,
            @Scope = Webs.FullUrl
        FROM
            Webs
        WHERE
            Webs.Id = @WebId
        INSERT INTO @Scopes (
            Scope)
        VALUES (
            @Scope)
    END
    SELECT
        ContentTypes.ContentTypeId,
        ContentTypes.Scope,
        ContentTypes.Definition,
        ContentTypes.NextChildByte,
        ContentTypes.Version,
        ContentTypes.ResourceDir
    FROM
        ContentTypes
    INNER JOIN
        @Scopes AS Scopes
    ON
        ContentTypes.Scope = Scopes.Scope
    WHERE
        ContentTypes.SiteId = @SiteId AND
        ContentTypes.Class = @Class
    ORDER BY
        ContentTypes.ContentTypeId
    RETURN 0

GO
