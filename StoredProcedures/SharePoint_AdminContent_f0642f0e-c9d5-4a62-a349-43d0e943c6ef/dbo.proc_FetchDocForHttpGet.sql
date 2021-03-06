/****** Object:  StoredProcedure [dbo].[proc_FetchDocForHttpGet]    Script Date: 5/15/2018 12:12:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_FetchDocForHttpGet(
    @DocSiteId uniqueidentifier,
    @DocDirName nvarchar(256),
    @DocLeafName nvarchar(128),
    @LooksLikeAttachmentFile bit,
    @IfModifiedSince datetime,
    @FetchType int,
    @ValidationType int,
    @ClientVersion int,
    @ClientId uniqueidentifier,
    @PageView tinyint,
    @FetchBuildDependencySet bit,
    @SystemID tSystemID,
    @CurrentVirusVendorID int,
    @PrefetchListScope bit,
    @ChunkSize int,
    @DGCacheVersion bigint,
    @MaxCheckinLevel tinyint,
    @HonorLevel bit,
    @CurrentFolderUrl nvarchar(260),
    @Level tinyint OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @SiteFlags int
    DECLARE @SitePortalURL nvarchar(260)
    DECLARE @SitePortalName nvarchar(255)
    DECLARE @UserId int
    DECLARE @SiteSecurityVersion bigint
    DECLARE @SiteHashKey   binary(16)
    DECLARE @UserInfoListId uniqueidentifier
    DECLARE @RootWebId uniqueidentifier
    DECLARE @SiteNextUserOrGroupId int
    DECLARE @SiteGlobalAuditMask int
    DECLARE @SiteLastContentChange datetime
    DECLARE @SiteLastSecurityChange datetime
    SELECT 
        @SiteFlags = Sites.BitFlags,
        @SiteGlobalAuditMask = Sites.AuditFlags,
        @SitePortalURL = Sites.PortalURL,
        @SitePortalName = Sites.PortalName,
        @UserId = UserInfo.tp_Id,
        @SiteSecurityVersion = Sites.SecurityVersion,
        @SiteHashKey = Sites.HashKey,
        @UserInfoListId = Sites.UserInfoListId,
        @RootWebId = Sites.RootWebId,
        @SiteLastContentChange = Sites.LastContentChange,
        @SiteLastSecurityChange = Sites.LastSecurityChange,
        @SiteNextUserOrGroupId = Sites.NextUserOrGroupId
    FROM 
        Sites (NOLOCK)
    LEFT OUTER JOIN
        UserInfo
    ON
        UserInfo.tp_SiteId = Sites.Id AND
        UserInfo.tp_SystemId = @SystemId AND
        UserInfo.tp_Deleted = 0
    WHERE
        Sites.Id = @DocSiteId
    IF @@ROWCOUNT <> 1
    BEGIN
        RETURN 1168
    END
    IF (@SiteNextUserOrGroupId IS NOT NULL AND
        @SiteNextUserOrGroupId > 1000)
    BEGIN
        SET @SiteFlags = @SiteFlags | 4096
    END        
    DECLARE @Docs_Size             int
    DECLARE @Docs_DocFlags         int
    DECLARE @Docs_Type             tinyint
    DECLARE @Webs_FullUrl          nvarchar(260)
    DECLARE @Docs_Dirty            bit
    DECLARE @Docs_HasStream        bit
    DECLARE @Docs_TimeLastWritten  datetime
    DECLARE @Docs_CharSet          int
    DECLARE @Docs_Version          int
    DECLARE @Docs_Id               uniqueidentifier
    DECLARE @Docs_ParentId         uniqueidentifier
    DECLARE @Docs_DirName          nvarchar(256)
    DECLARE @Docs_LeafName         nvarchar(128)
    DECLARE @Docs_SetupPathVersion tinyint
    DECLARE @Docs_SetupPath        nvarchar(255)
    DECLARE @Docs_SetupPathUser    nvarchar(255)
    DECLARE @Docs_DoclibRowId      int
    DECLARE @Webs_Id               uniqueidentifier
    DECLARE @Webs_FirstUniqueWebId uniqueidentifier
    DECLARE @Webs_SecurityProvider uniqueidentifier
    DECLARE @Webs_Collation        smallint
    DECLARE @Webs_NavParentWebId uniqueidentifier
    DECLARE @Docs_InDocLibrary     bit
    DECLARE @IsAttachment          bit
    DECLARE @Docs_LTCheckoutUserId int
    DECLARE @ListIdForPermissionCheck uniqueidentifier
    DECLARE @Docs_VirusVendorID    int
    DECLARE @Docs_VirusStatus      int
    DECLARE @Docs_VirusInfo        nvarchar(255)
    DECLARE @DocScopeId            uniqueidentifier
    DECLARE @Docs_DraftOwnerId     int
    DECLARE @Docs_AuditFlags       int
    DECLARE @Docs_InheritAuditFlags int
    DECLARE @Lists_Flags           bigint
    DECLARE @IsCurrentVersion      bit
    DECLARE @BuildDependencySetLength int
    DECLARE @Docs_ProgId nvarchar(255)
    DECLARE @Webs_Language int
    IF (DATALENGTH(@DocLeafName) = 0) AND NOT (DATALENGTH(@DocDirName) = 0)
    BEGIN
        EXEC proc_SplitUrl
            @DocDirName,
            @DocDirName OUTPUT,
            @DocLeafName OUTPUT
    END
    IF (@HonorLevel = 0)
    BEGIN
        EXEC proc_GetLevel
            @DocSiteId,
            @DocDirName,
            @DocLeafName,
            @UserId,
            @MaxCheckinLevel,
            @Level OUTPUT
    END
    ELSE
    BEGIN
        SET @Level = @MaxCheckinLevel
    END
    IF @Level IS NULL
        SET @Level = 1
    SELECT
        @Docs_Size = Size,
        @Docs_DocFlags = DocFlags,
        @Docs_Type = Type,
        @Webs_FullUrl = Webs.FullUrl,
        @Docs_Dirty = Dirty,
        @Docs_HasStream = HasStream,
        @Docs_TimeLastWritten = TimeLastWritten,
        @Docs_CharSet = CharSet,
        @Docs_ProgId = Docs.ProgId,
        @Docs_Version = Version,
        @Docs_Id = Docs.Id,
        @Docs_ParentId = Docs.ParentId,
        @Docs_DirName = DirName,
        @Docs_LeafName = LeafName,
        @Docs_SetupPathVersion = SetupPathVersion,
        @Docs_SetupPath = SetupPath,
        @Docs_SetupPathUser = SetupPathUser,
        @Docs_DoclibRowId = DoclibRowId,
        @Webs_Id = Webs.Id,
        @Webs_FirstUniqueWebId = Webs.FirstUniqueAncestorWebId,
        @Webs_SecurityProvider = Webs.SecurityProvider,
        @Webs_Collation = Webs.Collation,
        @Webs_NavParentWebId = Webs.NavParentWebId,
        @Docs_InDocLibrary = CASE WHEN 
                DoclibRowId IS NULL AND thicketflag = 0  AND (DocFlags & 2) = 0 
            THEN 0 ELSE 1 END,
        @IsAttachment = 0,
        @Docs_LTCheckoutUserId = Docs.LTCheckoutUserId,
        @ListIdForPermissionCheck = Docs.ListId,
        @DocScopeId = Docs.ScopeId,
        @Docs_VirusVendorID = Docs.VirusVendorID,
        @Docs_VirusStatus = Docs.VirusStatus,
        @Docs_VirusInfo = Docs.VirusInfo,
        @Docs_DraftOwnerId =
            CASE WHEN @HonorLevel=1 AND @Level = 1 THEN NULL
            ELSE Docs.DraftOwnerId END,
        @Lists_Flags = Lists.tp_Flags,
        @IsCurrentVersion = Docs.IsCurrentVersion,
        @BuildDependencySetLength = DATALENGTH(Docs.BuildDependencySet),
        @Webs_Language = Webs.Language
    FROM
        Docs
    INNER JOIN
        Webs WITH (NOLOCK)
    ON
        Webs.Id = Docs.WebId
    LEFT OUTER JOIN 
        Lists WITH (NOLOCK)
    ON
        Lists.tp_ID = Docs.ListId AND
        Lists.tp_WebId = Docs.WebId
    WHERE
        Docs.SiteId = @DocSiteId AND
        Docs.DirName = @DocDirName AND
        Docs.LeafName = @DocLeafName AND
        Docs.Level = @Level
    IF (@@ROWCOUNT <> 1)
        RETURN 2
    DECLARE @NeedManageListRight int
    SET @NeedManageListRight = 0
    DECLARE @IsFolderUrl bit
    SET @IsFolderUrl = CASE WHEN ((@Docs_Type = 1) OR
                                  (@Docs_Type = 2))
                            THEN 1 ELSE 0
                       END
    IF @LooksLikeAttachmentFile = 1
    BEGIN
        DECLARE @UrlFlag tinyint
        SET @UrlFlag = CASE WHEN (@IsFolderUrl = 0)
                            THEN 1 
                            ELSE 2
                       END
        EXEC @IsAttachment = proc_TestAttachmentsFlagReadPerm
            @DocSiteID, 
            @DocDirName, 
            @DocLeafName, 
            @UrlFlag, 
            @UserId,
            @NeedManageListRight OUTPUT
       IF @IsAttachment = 1 AND @IsFolderUrl = 1
        RETURN 2
    END
    DECLARE @RedirectRetval int
    DECLARE @RedirectUrl nvarchar(260)
    DECLARE @RedirectType tinyint
    DECLARE @ContentTypeId tContentTypeId
    IF (@IsFolderUrl = 1)
    BEGIN
        EXEC @RedirectRetval = proc_GetFolderRedirectUrl
            @DocSiteId,
            @DocDirName,
            @DocLeafName,
            @Level,
            @RedirectUrl OUTPUT,
            @RedirectType OUTPUT,
            @ContentTypeId OUTPUT
        IF (@RedirectType = 255)
            RETURN @RedirectRetval
    END
    DECLARE @ContentModifiedSince    bit
    SET @ContentModifiedSince =
        CASE WHEN
            ((@Docs_DocFlags & 1) = 1 OR  
                (@Docs_Dirty = 1) OR
                (@ValidationType = 0) OR
                ((@ValidationType & 1) = 1 AND
                    ((@ClientVersion <> @Docs_Version) OR
                        (@ClientId <> @Docs_Id))) OR
                ((@ValidationType & 2) 
                    = 2 AND
                    @Docs_TimeLastWritten > @IfModifiedSince))
        THEN 1 ELSE 0 END
    SELECT
        @Docs_Size,
        @Docs_DocFlags,
        @Webs_FullUrl,
        @Webs_Id,
        @Webs_FirstUniqueWebId,
        @Webs_SecurityProvider,
        @Docs_Dirty,
        @Docs_TimeLastWritten,
        @Docs_CharSet,
        @Docs_Version,
        @Docs_Id,
        @Docs_LeafName,
        CASE WHEN @ListIdForPermissionCheck IS NULL THEN 0 ELSE @Docs_InDocLibrary END AS InDocLibrary,
        CASE WHEN @ListIdForPermissionCheck IS NULL THEN 0 ELSE @IsAttachment END AS IsAttachment,
        CASE WHEN @ListIdForPermissionCheck IS NULL THEN 0 ELSE @NeedManageListRight END AS NeedManageListRight,
        @SiteFlags,
        Perms.Acl,
        Perms.AnonymousPermMask,
        @ListIdForPermissionCheck,
        0, 
        CASE WHEN @Docs_DraftOwnerId IS NULL THEN 0 ELSE @Docs_DraftOwnerId END AS DraftOwnerId,
        CASE WHEN @Lists_Flags IS NULL THEN 0 ELSE @Lists_Flags END AS ListFlags,
        @Level AS Level,
        @IsCurrentVersion,
        @Docs_Type,
        @Docs_VirusVendorID,
        @Docs_VirusStatus,
        @Docs_VirusInfo,
        @ContentModifiedSince,
        @Docs_ProgId,
        @Docs_DoclibRowId,
        @Webs_Language,
        @Docs_DirName
    FROM
        Perms
    WHERE
        SiteId = @DocSiteId AND
        ScopeId = @DocScopeId
    EXEC proc_SecGetDomainGroupMapData @DocSiteId, @DGCacheVersion
    SELECT
        tp_Id,
        tp_SiteAdmin,
        tp_IsActive,
        tp_Login,
        tp_Email,
        tp_Title,
        tp_Notes,
        tp_ExternalTokenLastUpdated,
        tp_Token,
        WebMembers.UserId,
        SSV.SiteSecurityVersion
    FROM
        (SELECT @SiteSecurityVersion AS SiteSecurityVersion) AS SSV
    LEFT OUTER JOIN
        UserInfo
    ON
        UserInfo.tp_SiteId = @DocSiteId AND
        UserInfo.tp_Id = @UserId
    LEFT OUTER JOIN
        WebMembers
    ON
        WebMembers.WebId = @Webs_FirstUniqueWebId AND
        WebMembers.UserId = @UserId
    IF (@IsFolderUrl = 1)
    BEGIN
        IF @RedirectType = 0
        BEGIN
            SELECT TOP 1
                @RedirectType,
                @RedirectUrl,
                WelcomePageParameters,
                NULL
            FROM
                Docs
            WHERE
                Docs.SiteId = @DocSiteId AND
                Docs.DirName = @DocDirName AND
                Docs.LeafName = @DocLeafName
        END
        ELSE
        BEGIN
            SELECT
                @RedirectType,
                @RedirectUrl,
                NULL,
                @ContentTypeId
        END
        RETURN @RedirectRetval
    END
    DECLARE @RetContentGet int
    SET @RetContentGet = 0
    IF (@FetchType <> 1)
    BEGIN
        IF @Docs_HasStream = 1
        BEGIN
            SELECT
                CASE WHEN DocStreams.Size > @ChunkSize AND DocStreams.Content IS NOT NULL AND (@Docs_DocFlags & 65536) = 0 THEN 0x0 ELSE DocStreams.Content END,
                COALESCE(DocStreams.Size, @Docs_Size),            
                @Docs_SetupPathVersion,
                @Docs_SetupPath,
                @Docs_SetupPathUser,
                @Docs_Dirty,
                @Docs_Version,
                @Docs_Id
            FROM
                DocStreams
            WHERE
                SiteId = @DocSiteId AND
                ParentId = @Docs_ParentId AND
                Id = @Docs_Id AND
                Level = @Level AND
                @Docs_Type = 0 AND
                (@ContentModifiedSince <> 0 OR
                    (@CurrentVirusVendorID IS NOT NULL AND
                        @CurrentVirusVendorID <> @Docs_VirusVendorID))
                IF @@ROWCOUNT <> 1
                BEGIN
                    SET @RetContentGet = 18
                END
        END
        ELSE
        BEGIN
            SELECT
                NULL,
                @Docs_Size,            
                @Docs_SetupPathVersion,
                @Docs_SetupPath,
                @Docs_SetupPathUser,
                @Docs_Dirty,
                @Docs_Version,
                @Docs_Id
            WHERE
                @Docs_Type = 0 AND
                (@ContentModifiedSince <> 0 OR
                    (@CurrentVirusVendorID IS NOT NULL AND
                        @CurrentVirusVendorID <> @Docs_VirusVendorID))
                IF @@ROWCOUNT <> 1
                BEGIN
                    SET @RetContentGet = 18
                END
        END
    END
    SELECT
        @Docs_Id,
        @Docs_AuditFlags,
        @Docs_InheritAuditFlags,
        @SiteGlobalAuditMask
    SELECT TOP 1
        tp_Id, 
        tp_AuditFlags, 
        tp_InheritAuditFlags,
        @SiteGlobalAuditMask,
        CASE WHEN (DATALENGTH(@Webs_FullUrl) = 0) THEN tp_Title WHEN (DATALENGTH(tp_Title) = 0) THEN @Webs_FullUrl ELSE @Webs_FullUrl + N'/' + tp_Title END
    FROM
        Lists
    WHERE
        tp_WebId = @Webs_Id AND
        tp_Id = @ListIdForPermissionCheck
    SET @DGCacheVersion = -2
    IF @FetchBuildDependencySet = 1 AND 
       (@Level IS NOT NULL AND @LEVEL = 1)
    BEGIN
        EXEC proc_GetDocBuildDependencySet
            @DocSiteId,
            @DocDirName,
            @DocLeafName,
            @Level,
            @UserId,
            @BuildDependencySetLength
    END
    IF @PageView IS NOT NULL
    BEGIN
        DECLARE @ret int
        EXEC @ret = proc_ReturnTpWebMetaData @DocSiteId, @Webs_Id,
            @SiteFlags, @SitePortalURL,
            @SitePortalName, @SiteSecurityVersion, @SystemId, @SiteHashKey,
            @UserInfoListId, @RootWebId, @DGCacheVersion,
            @SiteLastContentChange, @SiteLastSecurityChange
        IF (@ret <> 0)
        BEGIN
            RETURN @ret
        END
        EXEC proc_GetEventReceivers @DocSiteId, @Webs_Id, @Webs_Id, 1
        DECLARE @AllUsers bit
        SELECT @AllUsers = CASE WHEN 1 = @PageView THEN 0 ELSE 1 END
        EXEC proc_GetAllWebPartsInternal
            @DocSiteId,
            @AllUsers,            
            @UserId,
            @Docs_Id,
            @ListIdForPermissionCheck, 
            @Webs_Id,
            @Webs_Collation,
            @Level,
            @PrefetchListScope,
            0 
        IF @CurrentFolderUrl IS NULL OR 
            @ListIdForPermissionCheck IS NULL
        BEGIN
            SELECT
                N'',
                NULL
        END
        ELSE IF @CurrentFolderUrl = N''
        BEGIN
            EXEC proc_GetListContentTypeOrder
                @DocSiteId,
                @Webs_Id,
                @ListIdForPermissionCheck
        END
        ELSE
        BEGIN
            EXEC proc_GetFolderContentTypeOrder
                @DocSiteId,
                @CurrentFolderUrl
        END
        IF @CurrentFolderUrl IS NOT NULL AND
           NOT @CurrentFolderUrl = N''
        BEGIN
            DECLARE @FolderScopeId uniqueidentifier
            DECLARE @FolderWebId uniqueidentifier
            DECLARE @FolderId int
            EXEC proc_GetFolderInfo 
                @DocSiteId, 
                @CurrentFolderUrl, 
                @FolderScopeId OUTPUT, 
                @FolderWebId OUTPUT,
                @FolderId OUTPUT
            SELECT @FolderScopeId, @FolderId
        END
        EXEC @ret = proc_ReturnWebFeatures
            @DocSiteId, @Webs_Id
        IF (@ret <> 0)
        BEGIN
            RETURN @ret
        END
        EXEC @ret = proc_ReturnCachedNavAcls
            @DocSiteId, @Webs_Id, @Webs_NavParentWebId
        IF (@ret <> 0)
        BEGIN
            RETURN @ret
        END            
    END
    RETURN @RetContentGet

GO
