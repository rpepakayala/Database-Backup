/****** Object:  StoredProcedure [dbo].[proc_SecListAllSiteMembers]    Script Date: 5/15/2018 12:12:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecListAllSiteMembers(
    @SiteId uniqueidentifier)
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
    WHERE
        tp_SiteId = @SiteId AND
        tp_Deleted = 0

GO
