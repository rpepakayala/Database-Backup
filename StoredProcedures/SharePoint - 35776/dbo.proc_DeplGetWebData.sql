/****** Object:  StoredProcedure [dbo].[proc_DeplGetWebData]    Script Date: 5/15/2018 12:11:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetWebData(
    @LastOrdinal int)
AS
    SET NOCOUNT ON
    SELECT TOP 100
    Webs.Id,
    e.FullUrl as ExportObjectUrl,
    e.Ordinal,
    ParentWeb.FullUrl as ParentUrl,
    Webs.FullUrl,
    Webs.AlternateHeaderUrl,
    Webs.ProvisionConfig,
    Webs.Locale,
    Webs.Description,
    Webs.Flags,
    Webs.ParentWebId,
    Webs.Language,
    Webs.Title,
    Webs.DefTheme,
    Webs.TimeCreated,
    (SELECT MAX(tp_Modified) FROM Lists WITH (NOLOCK) WHERE Lists.tp_WebId = Webs.Id),
    Webs.Author,
    Webs.WebTemplate,
    Perms.Acl
    FROM
        Webs
    INNER JOIN Perms
    ON
        Webs.SiteId = Perms.SiteId AND
        Webs.ScopeId = Perms.ScopeId
    INNER JOIN #ExportObjects e
    ON
        e.Id = Webs.Id
    LEFT JOIN
        Webs as ParentWeb
    ON
        Webs.ParentWebId = ParentWeb.Id
    WHERE e.Ordinal > @LastOrdinal AND e.Type = 1
    ORDER BY e.Ordinal

GO
