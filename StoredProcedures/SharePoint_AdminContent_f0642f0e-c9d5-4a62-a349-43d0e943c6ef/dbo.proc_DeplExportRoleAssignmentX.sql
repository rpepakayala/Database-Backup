/****** Object:  StoredProcedure [dbo].[proc_DeplExportRoleAssignmentX]    Script Date: 5/15/2018 12:12:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplExportRoleAssignmentX(
    @SiteId uniqueidentifier,
    @EventTime datetime,
    @ChangeLogId bigint)
AS
    SET NOCOUNT ON
    DECLARE @EventType int
    DECLARE @ObjectType int
    DECLARE @RoleId int
    DECLARE @OpCode int
    DECLARE @ScopeId uniqueidentifier
    DECLARE @Int0 int
    DECLARE @WebId uniqueidentifier
    DECLARE @GroupId int
    DECLARE @GroupTitle nvarchar(255)
    DECLARE @UserId int
    DECLARE @UserLogin nvarchar(255)
    DECLARE @Id uniqueidentifier
    DECLARE @ListId uniqueidentifier
    DECLARE @Type tinyint
    DECLARE @ScopeUrl nvarchar(256)
    DECLARE @ScopeObjectId uniqueidentifier
    DECLARE @ScopeObjectType int
    DECLARE @RoleDefWebId uniqueidentifier
    DECLARE @RoleDefWebFullUrl nvarchar(256)
    DECLARE @AnonymousPermMask tPermMask
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    DECLARE @RoleTitle nvarchar(255)
    SELECT
        @EventType = EventCache.EventType,      
        @ObjectType = EventCache.ObjectType,    
        @OpCode = CASE WHEN EventCache.Int1 >= 1073741824 THEN 0 ELSE COALESCE(EventCache.Int1, 0) END, 
        @RoleId = CASE WHEN EventCache.Int1 < 1073741824 THEN 0 ELSE EventCache.Int1 END,  
        @ScopeId = EventCache.Guid0,              
        @Int0 = EventCache.Int0,                
        @WebId = EventCache.WebId,              
        @RoleTitle = Roles.Title,
        @GroupId = Groups.Id,
        @GroupTitle = Groups.Title,
        @UserId = UserInfo.tp_Id,
        @UserLogin = UserInfo.tp_Login
    FROM
        EventCache
    LEFT OUTER JOIN
        Roles
    ON
        Roles.SiteId = EventCache.SiteId AND
        Roles.RoleId = EventCache.Int1
    LEFT OUTER JOIN
        Groups
    ON
        Groups.SiteId = EventCache.SiteId AND
        Groups.Id = EventCache.int0
    LEFT OUTER JOIN
        UserInfo
    ON
        UserInfo.tp_SiteId = EventCache.SiteId AND
        UserInfo.tp_Id = EventCache.int0
    WHERE
        EventCache.EventTime = @EventTime AND
        EventCache.Id = @ChangeLogId AND
        EventCache.SiteId = @SiteId
    SELECT
        @ScopeUrl = P.ScopeUrl,
        @RoleDefWebId = P.RoleDefWebId,
        @RoleDefWebFullUrl = W.FullUrl,
        @AnonymousPermMask = P.AnonymousPermMask
    FROM
        Perms AS P
    INNER JOIN
        Webs AS W
    ON
        W.SiteId = P.SiteId AND
        W.Id = P.RoleDefWebId
    WHERE
        P.SiteId = @SiteId AND
        P.WebId = @WebId AND
        P.ScopeId = @ScopeId
    EXEC proc_SplitUrl @ScopeUrl, @DirName OUTPUT, @LeafName OUTPUT
    SELECT
        @Id = Id,
        @ListId = ListId,
        @Type = Type
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        LeafName = @LeafName AND
        DirName = @DirName
    EXEC proc_DeplScopeTypeFromDocType @SiteId, @WebId, @ListId, @Id, @Type,
                @ScopeObjectType OUTPUT, @ScopeObjectId OUTPUT
    IF (@ScopeUrl IS NOT NULL)
    BEGIN
    SELECT
        @EventType,         
        @OpCode,            
        @WebId,             
        @ScopeId,           
        @RoleDefWebId,
        @RoleDefWebFullUrl,
        @ScopeObjectId,
        @ScopeObjectType,
        @ScopeUrl,
        @AnonymousPermMask,
        @RoleTitle,
        @GroupId,
        @GroupTitle,
        @UserId,
        @UserLogin
    END

GO
