/****** Object:  StoredProcedure [dbo].[proc_DetectSecurityCorruption]    Script Date: 5/15/2018 12:11:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DetectSecurityCorruption
AS
    SET NOCOUNT ON
    SELECT
        Webs.Id,
        Webs.Title,
        Webs.FullUrl
    FROM
        Webs 
    WHERE 
        Id = FirstUniqueAncestorWebId AND
        NOT EXISTS (
            SELECT * FROM Perms 
            WHERE 
                Perms.SiteId = Webs.SiteId AND 
                Perms.ScopeUrl = Webs.FullUrl AND 
                Perms.ScopeId = Webs.ScopeId)
    SELECT
        Webs.Id,
        Webs.Title,
        Webs.FullUrl
    FROM 
        Webs, Docs
    WHERE 
        Webs.SiteId = Docs.SiteId AND
        Webs.FullUrl = dbo.fn_GetFullUrl(Docs.DirName, Docs.LeafName) AND
        Webs.ScopeId <> Docs.ScopeId

GO
