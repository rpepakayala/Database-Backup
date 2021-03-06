/****** Object:  StoredProcedure [dbo].[proc_DeplExportUserX]    Script Date: 5/15/2018 12:11:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplExportUserX(
    @SiteId uniqueidentifier,
    @EventTime datetime,
    @ChangeLogId bigint)
AS
    SET NOCOUNT ON
    SELECT
        EventCache.EventType,
        UserInfo.tp_Id,
        UserInfo.tp_Title,
        UserInfo.tp_Login,
        UserInfo.tp_Email,
        UserInfo.tp_Notes,
        UserInfo.tp_DomainGroup,
        UserInfo.tp_SiteAdmin,
        UserInfo.tp_SystemId
    FROM
        EventCache
    INNER JOIN
        UserInfo
    ON
        UserInfo.tp_SiteId = EventCache.SiteId AND
        UserInfo.tp_Id = EventCache.int0
    WHERE
        UserInfo.tp_Id <> 1073741823 AND
        EventCache.EventTime = @EventTime AND
        EventCache.Id = @ChangeLogId AND
        EventCache.ObjectType = 128 AND
        EventCache.SiteId = @SiteId

GO
