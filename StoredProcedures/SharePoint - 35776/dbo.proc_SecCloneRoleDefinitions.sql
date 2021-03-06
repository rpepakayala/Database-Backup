/****** Object:  StoredProcedure [dbo].[proc_SecCloneRoleDefinitions]    Script Date: 5/15/2018 12:12:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecCloneRoleDefinitions(
    @SiteId                 uniqueidentifier,
    @WebId                  uniqueidentifier,
    @CopyRoleAssignments    bit,
    @UserId                 int,
    @NewScopeId             uniqueidentifier OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @WebFullUrl nvarchar(256)
    DECLARE @RoleDefWebId uniqueidentifier
    DECLARE @OldScopeId   uniqueidentifier
    DECLARE @FirstUniqueAncestor uniqueidentifier
    DECLARE @HasUniqueAssignment bit
    DECLARE @OpCode int
    SET @OpCode = 2 + 8
    IF (@CopyRoleAssignments = 1)
        SET @OpCode = @OpCode + 16
    SELECT
        @RoleDefWebId = Perms.RoleDefWebId,
        @OldScopeId   = Webs.ScopeId,
        @WebFullUrl = Webs.FullUrl,
        @FirstUniqueAncestor = Webs.FirstUniqueAncestorWebId
    FROM
        Webs, Perms
    WHERE
        Webs.Id = @WebId AND
        Webs.ScopeId = Perms.ScopeId AND
        Perms.RoleDefWebId <> @WebId
    IF @WebFullUrl IS NULL
    BEGIN
        RETURN 3
    END
    IF @FirstUniqueAncestor = @WebId
        SET @HasUniqueAssignment = 1
    ELSE
        SET @HasUniqueAssignment = 0
    BEGIN TRAN
    UPDATE Webs SET CachedNavDirty = 1 WHERE SiteId = @SiteId
    INSERT INTO Roles 
        (SiteId, WebId,  RoleId, Title, Description, PermMask, PermMaskDeny, Hidden, RoleOrder, Type)
    SELECT 
         SiteId, @WebId, RoleId, Title, Description, PermMask, PermMaskDeny, Hidden, RoleOrder, Type
    FROM 
        Roles
    WHERE 
        WebId = @RoleDefWebId
    UPDATE 
        Webs
    SET
        NextWebGroupId = (SELECT NextWebGroupId FROM Webs WHERE Id = @RoleDefWebId) 
    WHERE
        Id = @WebId
    IF @HasUniqueAssignment = 0
    BEGIN
        SET @NewScopeId = NEWID()
        EXEC proc_SecDupScope @SiteId, @OldScopeId, @NewScopeId, @WebId, @WebFullUrl, @UserId, 1, @CopyRoleAssignments, @WebId
    END
    ELSE    
    BEGIN
        SET @NewScopeId = @OldScopeId
        UPDATE
            Perms
        SET
            RoleDefWebId = @WebId
        WHERE
            SiteId = @SiteId AND
            ScopeId = @OldScopeId
        IF @CopyRoleAssignments = 0
        BEGIN
            DELETE
                RoleAssignment
            WHERE
                SiteId = @SiteId AND
                ScopeId = @NewScopeId
            DECLARE @AdminRoleId int
            SET @AdminRoleId = 1073741824 + 5
            EXEC proc_SecAddPrincipalToRoleCore @SiteId, @WebId, @NewScopeId, @AdminRoleId, @UserId                        
        END
    END
    EXEC proc_SecLogChange @SiteId, @WebId, @NewScopeId, @WebFullUrl, NULL, @UserId, 262144, @OpCode
    DECLARE @UrlLike nvarchar(1024)
    EXEC proc_EscapeForLike @WebFullUrl, @UrlLike OUTPUT
    IF @CopyRoleAssignments = 0
    BEGIN
        EXEC proc_SecResetAllSubwebsWithOldRoleDefs @SiteId, @WebId, @WebFullUrl, @NewScopeId, @RoleDefWebId
    END
    ELSE    
    BEGIN
        IF @HasUniqueAssignment = 0
            EXEC proc_SecResetAllInheritedSubwebs @SiteId, @WebId, @WebFullUrl, @UrlLike, @OldScopeId, @NewScopeId, @UserId
        UPDATE
            Perms
        SET
            RoleDefWebId = @WebId
        WHERE
            SiteId = @SiteId AND
            RoleDefWebId = @RoleDefWebId AND
            ScopeUrl LIKE @UrlLike
    END
    COMMIT TRAN
    EXEC proc_GetWebIdAuditMask @SiteId, @WebId

GO
