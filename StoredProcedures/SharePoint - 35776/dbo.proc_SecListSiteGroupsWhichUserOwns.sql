/****** Object:  StoredProcedure [dbo].[proc_SecListSiteGroupsWhichUserOwns]    Script Date: 5/15/2018 12:12:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecListSiteGroupsWhichUserOwns(
    @SiteId uniqueidentifier,
    @UserId int)
AS
    SET NOCOUNT ON
    SELECT
        V.*
    FROM
        Sec_SiteGroupsView V
    WHERE
        V.SiteID = @SiteId AND
        (V.Owner = @UserID OR (V.Owner IN (SELECT GroupID FROM GroupMembership WHERE MemberID = @UserID AND SiteID = @SiteID)))         

GO
