/****** Object:  StoredProcedure [dbo].[proc_SecResetAllSubwebsWithOldRoleDefs]    Script Date: 5/15/2018 12:12:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecResetAllSubwebsWithOldRoleDefs(
    @SiteId             uniqueidentifier,
    @WebId              uniqueidentifier,
    @WebUrl             nvarchar(256), 
    @NewScopeId         uniqueidentifier,
    @OldRoleDefWebId    uniqueidentifier)
AS
    DECLARE @UrlLike nvarchar(1024)
    EXEC proc_EscapeForLike @WebUrl, @UrlLike OUTPUT
    UPDATE
        Webs
    SET
        ScopeId = @NewScopeId,
        FirstUniqueAncestorWebId = @WebId
    FROM
        Webs, Perms
    WHERE
        Webs.SiteId = @SiteId AND
        Webs.ScopeId = Perms.ScopeId AND
        Perms.SiteId = @SiteId AND
        Perms.RoleDefWebId = @OldRoleDefWebId AND
        (Webs.FullUrl = @WebUrl OR Webs.FullUrl LIKE @UrlLike)
    UPDATE
        Docs
    SET
        ScopeId = @NewScopeId
    FROM
        Docs, Webs
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.WebId  = Webs.Id AND
        Webs.SiteId = @SiteId AND
        Webs.ScopeId = @NewScopeId
    UPDATE Lists
    SET 
        tp_ScopeId = @NewScopeId
    FROM
        Lists, Webs
    WHERE
        tp_WebId = Webs.Id AND
        Webs.SiteId = @SiteId AND
        Webs.ScopeId = @NewScopeId
    DELETE
        RoleAssignment
    FROM
        RoleAssignment, Perms, Webs
    WHERE
        RoleAssignment.SiteId = @SiteId AND
        RoleAssignment.ScopeId = Perms.ScopeId AND
        RoleAssignment.ScopeId <> @NewScopeId AND
        Perms.SiteId = @SiteId AND
        Perms.RoleDefWebId = @OldRoleDefWebId AND
        Perms.WebId = Webs.Id AND
        Webs.ScopeId = @NewScopeId
    DELETE
        Perms
    FROM
        Perms, Webs
    WHERE
        Perms.SiteId = @SiteId AND
        Perms.ScopeId <> @NewScopeId AND
        Perms.RoleDefWebId = @OldRoleDefWebId AND
        Perms.WebId = Webs.Id AND
        Webs.ScopeId = @NewScopeId

GO
