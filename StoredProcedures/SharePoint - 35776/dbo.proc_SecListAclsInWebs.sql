/****** Object:  StoredProcedure [dbo].[proc_SecListAclsInWebs]    Script Date: 5/15/2018 12:12:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecListAclsInWebs(
    @SiteId uniqueidentifier,
    @WebId  uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        Lists.tp_WebId,
        Lists.tp_Id,
        Perms.Acl,
        Perms.AnonymousPermMask
    FROM
        Lists
    INNER JOIN
        Webs
    ON
        Lists.tp_WebId = Webs.Id
    INNER JOIN
        Perms
    ON  
        Perms.SiteId = @SiteId AND
        Perms.ScopeId = Lists.tp_ScopeId
    WHERE
        Webs.SiteId = @SiteId AND
        Webs.FirstUniqueAncestorWebId = @WebId AND
        Perms.Acl IS NOT NULL AND
        Perms.AnonymousPermMask IS NOT NULL

GO
