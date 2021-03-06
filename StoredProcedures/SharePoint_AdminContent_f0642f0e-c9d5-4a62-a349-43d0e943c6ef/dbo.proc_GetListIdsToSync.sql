/****** Object:  StoredProcedure [dbo].[proc_GetListIdsToSync]    Script Date: 5/15/2018 12:12:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_GetListIdsToSync(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @Scope nvarchar(256))
AS
    SET NOCOUNT ON
    DECLARE @Scopes table (
        Scope nvarchar(256) COLLATE Latin1_General_CI_AS_KS_WS)
    DECLARE @WebIdT uniqueidentifier
    SET @WebIdT = @WebId
    WHILE @WebIdT IS NOT NULL
    BEGIN
        SELECT
            @WebIdT = Webs.ParentWebId,
            @Scope = Webs.FullUrl
        FROM
            Webs
        WHERE
            Webs.Id = @WebIdT
        INSERT INTO @Scopes (
            Scope)
        VALUES (
            @Scope)
    END
    SELECT
        DISTINCT cu.ListId
    FROM
        ContentTypeUsage AS cu
    INNER JOIN
        ContentTypes AS c
    ON
        c.SiteId = cu.SiteId AND
        c.Class = cast(0 as bit) AND
        cu.ContentTypeId = c.ContentTypeId AND
        c.Definition IS NOT NULL
    INNER JOIN
        @Scopes AS s
    ON
        c.Scope = s.Scope
    WHERE
        cu.SiteId = @SiteId AND
        cu.Class = cast(0 as bit) AND               
        cu.WebId = @WebId AND
        cu.IsFieldId = 0
    UNION
    SELECT
        DISTINCT cu.ListId
    FROM
        ContentTypeUsage AS cu
    INNER JOIN
        ContentTypes AS c
    ON
        c.SiteId = cu.SiteId AND
        c.Class = cast(1 as bit) AND
        cu.ContentTypeId >= c.ContentTypeId AND
        cu.ContentTypeId <= (c.ContentTypeId + 0xff) AND
        c.Definition IS NOT NULL
    INNER JOIN
        @Scopes AS s
    ON
        c.Scope = s.Scope
    WHERE
        cu.SiteId = @SiteId AND
        cu.Class = cast(1 as bit) AND
        cu.WebId = @WebId AND
        cu.IsFieldId = 0    

GO
