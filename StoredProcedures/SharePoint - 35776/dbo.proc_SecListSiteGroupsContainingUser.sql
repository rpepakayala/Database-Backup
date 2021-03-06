/****** Object:  StoredProcedure [dbo].[proc_SecListSiteGroupsContainingUser]    Script Date: 5/15/2018 12:12:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecListSiteGroupsContainingUser(
    @SiteId uniqueidentifier,
    @UserId int)
AS
    SET NOCOUNT ON
    SELECT
        V.*
    FROM
        Sec_SiteGroupsView V
    INNER JOIN
        GroupMembership
    ON
        V.SiteID = GroupMembership.SiteID AND
        V.ID = GroupMembership.GroupID
    WHERE
        GroupMembership.SiteId = @SiteId AND
        GroupMembership.MemberId = @UserId

GO
