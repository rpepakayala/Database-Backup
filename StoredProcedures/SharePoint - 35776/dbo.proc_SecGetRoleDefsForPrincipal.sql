/****** Object:  StoredProcedure [dbo].[proc_SecGetRoleDefsForPrincipal]    Script Date: 5/15/2018 12:12:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetRoleDefsForPrincipal(
    @SiteId         uniqueidentifier,
    @ScopeId        uniqueidentifier,
    @PrincipalId    int)
AS
    DECLARE @RoleDefWebId uniqueidentifier
    SET NOCOUNT ON
    SELECT
        @RoleDefWebId = RoleDefWebId
    FROM
        Perms
    WHERE
        SiteId = @SiteId AND
        ScopeId = @ScopeId
    SELECT
        Roles.RoleId,
        Roles.Title,
        Roles.Description,
        Roles.Hidden,
        Roles.Type,
        dbo.fn_GetHighBytes(Roles.PermMask),
        dbo.fn_GetLowBytes(Roles.PermMask),
        RoleAssignment.PrincipalId
    FROM
        Roles
    INNER JOIN
        RoleAssignment
    ON
        RoleAssignment.RoleID = Roles.RoleID
    WHERE
        Roles.SiteId = @SiteId AND
        Roles.WebId  = @RoleDefWebId AND
        RoleAssignment.SiteId = @SiteId AND
        RoleAssignment.ScopeId = @ScopeId AND
        RoleAssignment.PrincipalId = @PrincipalId

GO
