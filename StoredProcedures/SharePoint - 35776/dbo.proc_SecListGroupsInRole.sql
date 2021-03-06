/****** Object:  StoredProcedure [dbo].[proc_SecListGroupsInRole]    Script Date: 5/15/2018 12:12:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecListGroupsInRole(
    @SiteId   uniqueidentifier,
    @ScopeId  uniqueidentifier,
    @RoleId   int)
AS
    SET NOCOUNT ON
    SELECT
        V.*
    FROM
        Sec_SiteGroupsView V
    INNER JOIN
        RoleAssignment
    ON
        RoleAssignment.PrincipalId = V.ID
    WHERE
        RoleAssignment.SiteId = @SiteId AND
        RoleAssignment.ScopeId = @ScopeId AND
        RoleAssignment.RoleId  = @RoleId AND
        V.SiteID = @SiteId

GO
