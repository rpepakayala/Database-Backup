/****** Object:  StoredProcedure [dbo].[proc_SecDupScope]    Script Date: 5/15/2018 12:12:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecDupScope(
    @SiteId     uniqueidentifier,
    @ScopeId    uniqueidentifier,
    @NewScopeId uniqueidentifier,
    @WebId      uniqueidentifier,
    @NewUrl     nvarchar(256),
    @UserId     int,
    @CopyAnonymousMask bit,
    @CopyRoleAssignments bit,
    @RoleDefWebId uniqueidentifier = NULL,
    @ReturnAuditMask bit = 1)
AS
    SET NOCOUNT ON
    DECLARE @ListId uniqueidentifier
    BEGIN TRAN
    EXEC proc_GetContainingListOutput @SiteId, @WebId, @NewUrl, @ListId OUTPUT
    EXEC proc_DirtyListFGPData @SiteId, @WebId, @ListId
    INSERT INTO Perms
        SELECT 
            @SiteId, @NewScopeId, COALESCE(@RoleDefWebId, RoleDefWebId), @WebId, 0x, @NewUrl, 
            CASE WHEN @CopyAnonymousMask = 1 THEN AnonymousPermMask ELSE 0 END, 
            Acl
        FROM 
            Perms
        WHERE
            SiteId = @SiteId AND
            ScopeId = @ScopeId
    IF @CopyRoleAssignments = 1
    BEGIN
        INSERT INTO RoleAssignment
            SELECT
                SiteId, @NewScopeId, RoleId, PrincipalId
            FROM
                RoleAssignment
            WHERE
                SiteId = @SiteId AND
                ScopeId = @ScopeId
    END
    ELSE
    BEGIN
        DECLARE @AdminRoleId int
        SET @AdminRoleId = 1073741824 + 5
        EXEC proc_SecAddPrincipalToRole @SiteId, @WebId, @NewScopeId, @AdminRoleId, @UserId, 0, @ReturnAuditMask
    END
    EXEC proc_DirtyListFGPData @SiteId, @WebId, @ListId
    COMMIT TRAN

GO
