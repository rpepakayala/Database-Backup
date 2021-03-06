/****** Object:  StoredProcedure [dbo].[proc_SecGetGroupSecurityScopes]    Script Date: 5/15/2018 12:12:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetGroupSecurityScopes(
	@SiteId uniqueidentifier,
	@PrincipalId int)
AS
    SET NOCOUNT ON
    SELECT 
        Perms.ScopeUrl, Roles.Title
    FROM 
        Roles 
    INNER JOIN 
        RoleAssignment
    ON
        RoleAssignment.SiteId = Roles.SiteId AND
        RoleAssignment.RoleId = Roles.RoleId
    INNER JOIN
        Perms
    ON 
        Perms.RoleDefWebId = Roles.WebId AND
        Perms.SiteId = RoleAssignment.SiteId AND
        Perms.ScopeId = RoleAssignment.ScopeId
    WHERE
        RoleAssignment.SiteId = @SiteId AND
        RoleAssignment.PrincipalId = @PrincipalId AND 
        Perms.SiteId = @SiteId AND
        Perms.DelTransId = 0x        
    ORDER BY
        Perms.ScopeUrl, Roles.RoleOrder asc, Roles.Type desc

GO
