/****** Object:  StoredProcedure [dbo].[proc_SecListUsersInRole]    Script Date: 5/15/2018 12:12:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecListUsersInRole(
    @SiteId     uniqueidentifier,
    @ScopeId    uniqueidentifier,
    @RoleId     int)
AS
    SET NOCOUNT ON
    SELECT
        tp_ID,
        tp_SystemID,
        tp_Title,
        tp_Login,
        tp_Email,
        tp_Notes,
        tp_SiteAdmin,
        tp_DomainGroup
    FROM
        UserInfo
    INNER JOIN
        RoleAssignment
    ON
        UserInfo.tp_SiteId = @SiteId AND
        UserInfo.tp_ID = RoleAssignment.PrincipalId
    WHERE
        UserInfo.tp_Deleted    = 0 AND
        RoleAssignment.SiteId  = @SiteId AND
        RoleAssignment.ScopeId = @ScopeId AND
        RoleAssignment.RoleId  = @RoleId

GO
