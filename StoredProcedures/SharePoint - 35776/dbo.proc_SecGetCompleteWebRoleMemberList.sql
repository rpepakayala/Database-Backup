/****** Object:  StoredProcedure [dbo].[proc_SecGetCompleteWebRoleMemberList]    Script Date: 5/15/2018 12:12:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetCompleteWebRoleMemberList(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @LatestSecurityVersion bigint OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @ScopeId uniqueidentifier
    SELECT
        @ScopeId = ScopeId
    FROM
        Webs
    WHERE
        Webs.Id = @WebId
    SELECT
        RoleAssignment.RoleId,
        UserInfo.tp_Id,
        UserInfo.tp_SystemID,
        UserInfo.tp_DomainGroup
    FROM
        RoleAssignment
    INNER JOIN
        UserInfo
    ON
        UserInfo.tp_SiteId = @SiteId AND
        UserInfo.tp_Id = RoleAssignment.PrincipalId
    WHERE
        RoleAssignment.SiteId = @SiteId AND
        RoleAssignment.ScopeId = @ScopeId AND
        UserInfo.tp_Deleted = 0
    SELECT @LatestSecurityVersion = SecurityVersion
    FROM
        Sites
    WHERE
        Id = @SiteId
    RETURN 0

GO
