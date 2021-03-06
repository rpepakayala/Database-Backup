/****** Object:  StoredProcedure [dbo].[proc_SecRemoveRoleDef]    Script Date: 5/15/2018 12:12:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecRemoveRoleDef(
    @SiteId       uniqueidentifier,
    @WebId        uniqueidentifier,
    @RoleId       int)
AS
    SET NOCOUNT ON
    DECLARE @RoleName nvarchar(255) 
    SELECT 
        @RoleName = Title
        FROM
        Roles
    WHERE
        SiteId = @SiteId AND
        WebId  = @WebId  AND
        RoleId = @RoleId
    DELETE FROM 
        Roles
    WHERE
        SiteId = @SiteId AND
        WebId  = @WebId  AND
        RoleId = @RoleId
    DELETE 
        RoleAssignment
    FROM    
        RoleAssignment INNER JOIN Perms
    ON
        RoleAssignment.SiteId = Perms.SiteId AND
        RoleAssignment.ScopeId = Perms.ScopeId
    WHERE
        RoleAssignment.RoleId = @RoleId AND
        Perms.RoleDefWebId = @WebId
    EXEC proc_SecUpdateAcl @SiteId, @WebId
    EXEC proc_SecUpdateSiteLevelSecurityMetadata @SiteId, 1, 0
    DECLARE @ScopeId uniqueidentifier
    SELECT 
        @ScopeId = ScopeId
    FROM
        Perms
    WHERE
        SiteId = @SiteId AND
        RoleDefWebId = @WebId
    EXEC proc_SecLogChange @SiteId, @WebId, @ScopeId, NULL, @RoleId, NULL, 8388608, NULL, @RoleName
    EXEC proc_GetWebIdAuditMask @SiteId, @WebId        
    RETURN 0

GO
