/****** Object:  StoredProcedure [dbo].[proc_GetUniqueScopesInWeb]    Script Date: 5/15/2018 12:12:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetUniqueScopesInWeb(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @SelectSubWebs bit,
    @SelectDoclibs bit)
AS
    SET NOCOUNT ON
    IF (@SelectSubWebs = 1)
    BEGIN
        SELECT
            Perms.ScopeId,
            Perms.Acl,
            Perms.AnonymousPermMask
        FROM
            Perms
        WHERE
            Perms.SiteId = @SiteId AND
            Perms.ScopeId IN (SELECT DISTINCT ScopeId FROM Webs WHERE SiteId = @SiteId AND ParentWebId = @WebId)
    END
    ELSE
    BEGIN
        SELECT
            Perms.ScopeId,
            Perms.Acl,
            Perms.AnonymousPermMask
        FROM
            Perms
        WHERE
            Perms.SiteId = @SiteId AND
            Perms.ScopeId IN 
                (SELECT 
                    DISTINCT tp_ScopeId 
                 FROM 
                    Lists 
                 WHERE tp_WebId = @WebId AND 
                    (@SelectDoclibs <> 1 OR tp_BaseType = 1))
    END    

GO
