/****** Object:  StoredProcedure [dbo].[proc_SecGetAllGroupsAndMembershipInfo]    Script Date: 5/15/2018 12:12:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetAllGroupsAndMembershipInfo(
	@SiteId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        ID,
        Title,
        Description,
        Owner,
        OwnerIsUser
    FROM
        Groups
    WHERE
        SiteId = @SiteId
    ORDER BY
        ID ASC
    SELECT
        GroupMembership.GroupId,
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
        GroupMembership
    ON
        UserInfo.tp_SiteId = GroupMembership.SiteId AND
        UserInfo.tp_ID = GroupMembership.MemberId
    WHERE
        UserInfo.tp_SiteId = @SiteId AND
        GroupMembership.SiteId = @SiteId
    ORDER BY
        GroupMembership.GroupId ASC

GO
