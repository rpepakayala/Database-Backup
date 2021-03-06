/****** Object:  StoredProcedure [dbo].[proc_ReturnTpWebMetaData]    Script Date: 5/15/2018 12:12:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ReturnTpWebMetaData(
    @WebSiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @SiteFlags int,
    @SitePortalURL nvarchar(260),
    @SitePortalName nvarchar(255),
    @SiteSecurityVersion bigint,
    @SystemId tSystemId,
    @SiteHashKey binary(16),
    @UserInfoListId uniqueidentifier,
    @RootWebId uniqueidentifier,
    @DGCacheVersion bigint,
    @SiteLastContentChange datetime,
    @SiteLastSecurityChange datetime )
AS
    SET NOCOUNT ON
    DECLARE @RequestAccessEmail nvarchar(255) 
    DECLARE @FirstUniqueAncestorWebId uniqueidentifier
    DECLARE @bHasAncestry bit
    SELECT
        @FirstUniqueAncestorWebId = FirstUniqueAncestorWebId,
        @bHasAncestry = CASE
            WHEN ParentWebId IS NOT NULL AND Ancestry IS NULL THEN 0
            ELSE 1
            END
    FROM
        Webs
    WHERE
        Webs.Id = @WebId
    SELECT
        @RequestAccessEmail = RequestAccessEmail
    FROM
        Webs
    WHERE
        Id = @FirstUniqueAncestorWebId
    IF (@bHasAncestry <> 1)
    BEGIN
        EXEC proc_GenerateWebAncestry @WebId
    END
    DECLARE @UserId int
    SELECT 
        @UserId = tp_ID
    FROM
        UserInfo
    WHERE
           (UserInfo.tp_SiteID = @WebSiteId AND
            UserInfo.tp_SystemID = @SystemId AND
            UserInfo.tp_Deleted = 0)
    EXEC proc_SecGetDomainGroupMapData @WebSiteId, @DGCacheVersion
    SELECT
        Webs.Id,
        Webs.Title,
        Webs.Description,
        Webs.MetaInfoVersion,
        Webs.WebTemplate,
        Webs.Language,
        Webs.Locale,
        Webs.Collation,
        Webs.TimeZone,
        Webs.Time24,
        Webs.CalendarType,
        Webs.AdjustHijriDays,
        Webs.AltCalendarType,
        Webs.CalendarViewOptions,
        Webs.WorkDays,
        Webs.WorkDayStartHour,
        Webs.WorkDayEndHour,
        Webs.ProvisionConfig,
        Webs.Flags,
        Webs.Author,
        Webs.AlternateCSSUrl,
        Webs.CustomizedCss,
        Webs.CustomJSUrl,
        Webs.AlternateHeaderUrl,
        Webs.SecurityProvider,
        Webs.MasterUrl,
        Webs.CustomMasterUrl,
        dbo.fn_GetSiteLogoUrl(Webs.SiteLogoUrl,@RootWebId),
        dbo.fn_GetSiteLogoDescription(Webs.SiteLogoDescription,@RootWebId),
        Perms.AnonymousPermMask,
        @SiteFlags,
        @SitePortalURL,
        @SitePortalName,
        Webs.MeetingCount,
        Webs.DefTheme,
        Webs.CachedNav,
        Webs.CachedInheritedNav,
        Webs.CachedNavDirty,
        Webs.CachedDataVersion,
        Webs.NavParentWebId,
        Webs.FirstUniqueAncestorWebId,
        Webs.ScopeId,
        GETUTCDATE() as DbNow,
        Perms.Acl,
        @RequestAccessEmail,
        Webs.Ancestry,
        Webs.ProductVersion,
        UserInfo.tp_Id,
        UserInfo.tp_SiteAdmin,
        UserInfo.tp_IsActive,
        UserInfo.tp_Login,
        UserInfo.tp_Email,
        UserInfo.tp_Title,
        UserInfo.tp_Notes,
        UserInfo.tp_ExternalTokenLastUpdated,
        UserInfo.tp_Token,
        WebMembers.UserId,
        @SiteSecurityVersion,
        UserInfo.tp_Locale,
        UserInfo.tp_TimeZone,
        UserInfo.tp_Time24,
        UserInfo.tp_CalendarType,
        UserInfo.tp_AdjustHijriDays,
        UserInfo.tp_AltCalendarType,
        UserInfo.tp_CalendarViewOptions,
        UserInfo.tp_WorkDays,
        UserInfo.tp_WorkDayStartHour,
        UserInfo.tp_WorkDayEndHour,
        @SiteHashKey,
        @UserInfoListId,
        @RootWebId,
        @SiteLastContentChange,
        @SiteLastSecurityChange
    FROM
        Webs
    INNER JOIN Perms 
    ON
        Webs.SiteId = Perms.SiteId AND
        Webs.ScopeId = Perms.ScopeId
    LEFT OUTER JOIN
        UserInfo
    ON
        UserInfo.tp_SiteID = @WebSiteId AND
        UserInfo.tp_Id = @UserId
    LEFT OUTER JOIN
        WebMembers
    ON
        WebMembers.WebId = @FirstUniqueAncestorWebId AND
        WebMembers.UserId = @UserId
    WHERE
        Webs.Id = @WebId
    DECLARE @status int
    SELECT
        @status = CASE
            WHEN (@SiteFlags & 2 = 2) THEN 1271 
            ELSE 0
        END
    RETURN @status

GO
