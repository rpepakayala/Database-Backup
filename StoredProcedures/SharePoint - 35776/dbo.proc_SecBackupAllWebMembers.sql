/****** Object:  StoredProcedure [dbo].[proc_SecBackupAllWebMembers]    Script Date: 5/15/2018 12:12:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecBackupAllWebMembers(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        tp_ID,
        tp_Title,
        tp_Login,
        tp_Email,
        tp_Notes,
        tp_Deleted
    FROM
        UserInfo
    INNER JOIN
        WebMembers
    ON
        UserInfo.tp_SiteId = @SiteId AND
        UserInfo.tp_ID = WebMembers.UserId AND
        WebMembers.WebId = @WebId
    WHERE
        UserInfo.tp_DomainGroup = 0

GO
