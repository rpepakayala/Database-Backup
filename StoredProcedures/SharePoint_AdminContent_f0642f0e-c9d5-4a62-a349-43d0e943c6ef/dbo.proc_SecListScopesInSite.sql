/****** Object:  StoredProcedure [dbo].[proc_SecListScopesInSite]    Script Date: 5/15/2018 12:12:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecListScopesInSite(
    @SiteId uniqueidentifier,
    @WebId  uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT 
        ScopeId, AnonymousPermMask, Acl
    FROM 
        Perms
    WHERE 
        SiteId = @SiteId AND
        ScopeId IN
            (SELECT 
                DISTINCT ScopeId 
            FROM
                Docs
            WHERE 
                SiteId = @SiteId)

GO
