/****** Object:  StoredProcedure [dbo].[proc_SecAddPrincipalToRoleCore]    Script Date: 5/15/2018 12:12:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecAddPrincipalToRoleCore(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ScopeId uniqueidentifier,
    @RoleId int,
    @UserId int)
AS
    SET NOCOUNT ON
    IF NOT EXISTS (
        SELECT
            *
        FROM
            RoleAssignment
        WHERE
            SiteId  = @SiteId AND
            ScopeId = @ScopeId AND 
            RoleId  = @RoleId AND
            PrincipalId = @UserId)
    BEGIN
        DECLARE @SiteIdT uniqueidentifier
        SELECT 
            @SiteIdT = SiteId
        FROM
            RoleAssignment WITH (XLOCK)
        WHERE
            SiteId  = @SiteId AND
            ScopeId = @ScopeId
        INSERT INTO RoleAssignment(
            SiteId,
            ScopeId,
            RoleId,
            PrincipalId)
        VALUES(
            @SiteId,
            @ScopeId,
            @RoleId,
            @UserId)
        EXEC proc_SecUpdateAclForScope @SiteId, @ScopeId
    END 
    DECLARE @DomainGroup bit
    SELECT
        @DomainGroup = tp_DomainGroup
    FROM
        UserInfo
    WHERE
        tp_SiteID = @SiteId AND
        tp_ID = @UserId
    IF @DomainGroup = 0
    BEGIN
        EXEC proc_SecAddWebMembership @SiteId, @WebId, @UserId
    END
    RETURN 0

GO
