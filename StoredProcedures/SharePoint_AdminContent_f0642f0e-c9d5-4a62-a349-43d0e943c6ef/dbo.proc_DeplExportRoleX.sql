/****** Object:  StoredProcedure [dbo].[proc_DeplExportRoleX]    Script Date: 5/15/2018 12:12:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplExportRoleX(
    @SiteId uniqueidentifier,
    @EventTime datetime,
    @ChangeLogId bigint)
AS
    SET NOCOUNT ON
    SELECT
        EventCache.EventType, 
        CASE WHEN EventCache.Int1 >= 1073741824 THEN 0 ELSE EventCache.Int1 END,    
        EventCache.Guid0,     
        EventCache.Int0,      
        EventCache.WebId,     
        Webs.FullUrl,         
        Roles.RoleId,
        Roles.Title,
	EventCache.ItemName,  
        Roles.Description,
        Roles.PermMask,
        Roles.Hidden,
        Roles.RoleOrder,
        Roles.Type,
        UserInfo.tp_Id,
        UserInfo.tp_Login
    FROM
        EventCache
    INNER JOIN
        Webs
    ON
        Webs.SiteId = EventCache.SiteId AND
        Webs.Id = EventCache.WebId
    LEFT OUTER JOIN
        Roles
    ON
        Roles.SiteId = EventCache.SiteId AND
        Roles.RoleId = EventCache.Int1 AND
        Roles.WebId = EventCache.WebId
    LEFT OUTER JOIN
        UserInfo
    ON
        UserInfo.tp_SiteId = EventCache.SiteId AND
        UserInfo.tp_Id = EventCache.int0
    WHERE
        EventCache.EventTime = @EventTime AND
        EventCache.Id = @ChangeLogId AND
        EventCache.SiteId = @SiteId

GO
