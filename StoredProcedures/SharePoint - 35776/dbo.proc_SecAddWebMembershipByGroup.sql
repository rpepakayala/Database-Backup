/****** Object:  StoredProcedure [dbo].[proc_SecAddWebMembershipByGroup]    Script Date: 5/15/2018 12:12:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecAddWebMembershipByGroup(
    @SiteId uniqueidentifier,
    @GroupId int,
    @UserId int)
AS
    INSERT INTO 
        WebMembers
    SELECT 
        P.WebId,
        @UserId
    FROM
        RoleAssignment AS RA
    JOIN
        Perms AS P
    ON
        RA.SiteId = P.SiteId AND
        RA.ScopeId = P.ScopeId
    WHERE
        RA.SiteId = @SiteId AND
        RA.PrincipalId = @GroupId AND
        NOT EXISTS 
            (SELECT 1 FROM WebMembers WHERE WebId = P.WebId AND UserId = @UserId)        
    RETURN 0

GO
