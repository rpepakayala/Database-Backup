/****** Object:  StoredProcedure [dbo].[proc_FetchOldDoc]    Script Date: 5/15/2018 12:12:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_FetchOldDoc(
    @DocSiteId uniqueidentifier,
    @DocDirName nvarchar(256),
    @DocLeafName nvarchar(128),
    @IfModifiedSince datetime,
    @FetchType int,
    @ValidationType int,
    @ClientVersion int,
    @ClientId uniqueidentifier,
    @SystemID tSystemID,
    @VirusVendorID int,
    @ChunkSize int,
    @DGCacheVersion bigint)
AS
    SET NOCOUNT ON
    DECLARE @SiteFlags int
    DECLARE @SiteSecurityVersion bigint
    DECLARE @SiteNextUserOrGroupId int
    DECLARE @WebId uniqueidentifier
    DECLARE @ListId uniqueidentifier
    DECLARE @InDoclib bit
    DECLARE @DocId uniqueidentifier
    DECLARE @DocScopeId uniqueidentifier
    DECLARE @Size int
    DECLARE @ProgId nvarchar(255)
    DECLARE @Docs_DirName nvarchar(256)
    DECLARE @Docs_LeafName nvarchar(128)
    DECLARE @Docs_Type tinyint
    EXEC proc_SecGetDomainGroupMapData @DocSiteId, @DGCacheVersion
    SELECT 
        @SiteFlags = Sites.BitFlags,
        @SiteSecurityVersion = Sites.SecurityVersion,
        @SiteNextUserOrGroupId = Sites.NextUserOrGroupId,
        @WebId = Docs.WebId,
        @ListId = Docs.ListId,
        @InDoclib = CASE
            WHEN Docs.DoclibRowId IS NULL
            THEN 0
            ELSE 1
        END,
        @DocScopeId = Docs.ScopeId,
        @DocId = Docs.Id,        
        @ProgId = Docs.ProgId,
        @Docs_DirName = Docs.DirName,
        @Docs_LeafName = Docs.LeafName,
        @Docs_Type = Docs.Type
    FROM 
        Sites (NOLOCK)
    INNER JOIN
        Docs
    ON
        Sites.Id = Docs.SiteId
    WHERE
        Docs.SiteId = @DocSiteId AND
        Docs.DirName = @DocDirName AND
        Docs.LeafName = @DocLeafName AND
        Docs.IsCurrentVersion = 1
    IF @@ROWCOUNT <> 1
        RETURN 3
    IF (@SiteNextUserOrGroupId IS NOT NULL AND
        @SiteNextUserOrGroupId > 1000)
    BEGIN
        SET @SiteFlags = @SiteFlags | 4096
    END
    SELECT
        DocVersions.Size,
        DocVersions.DocFlags,
        DocVersions.TimeCreated,
        Webs.FullUrl,
        @WebId,
        Webs.FirstUniqueAncestorWebId,
        Webs.SecurityProvider,
        @InDoclib,
        @DocId,
        @SiteFlags,
        Perms.Acl,
        Perms.AnonymousPermMask,
        Lists.tp_ID,
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
        0, 
        DocVersions.DraftOwnerId,
        Lists.tp_Flags,
        DocVersions.Level,        
        DocVersions.VirusVendorID,
        DocVersions.VirusStatus,
        DocVersions.VirusInfo,
        CASE WHEN 
        ((DocVersions.DocFlags & 1) = 1 OR
            (NOT (((@ValidationType & 1) = 1) AND
                (@ClientId = DocVersions.Id))) OR
            (NOT (((@ValidationType & 2) = 
                2) AND
                @IfModifiedSince <> DocVersions.TimeCreated)))
        THEN 1 ELSE 0 END,
        @ProgId,
        @Docs_DirName,
        @Docs_LeafName,
        @Docs_Type 
    FROM
        DocVersions
    INNER JOIN
        Webs
    ON
        DocVersions.SiteId = Webs.SiteId
    LEFT OUTER JOIN
        Lists WITH (NOLOCK)
    ON
        Webs.Id = Lists.tp_WebId AND
        @ListId = Lists.tp_ID
    INNER JOIN
        Perms
    ON
        DocVersions.SiteId = Perms.SiteId AND
        Perms.ScopeId = @DocScopeId
    INNER JOIN
        Webs AS FirstUniqueWeb
    ON
        Webs.FirstUniqueAncestorWebId = FirstUniqueWeb.Id AND
        DocVersions.SiteId = FirstUniqueWeb.SiteId
    LEFT OUTER JOIN
        UserInfo
    ON
        DocVersions.SiteId = UserInfo.tp_SiteId AND
        UserInfo.tp_SystemId = @SystemID AND
        UserInfo.tp_Deleted = 0
    LEFT OUTER JOIN
        WebMembers
    ON
        WebMembers.WebId = FirstUniqueWeb.Id AND
        WebMembers.UserId = UserInfo.tp_Id
    WHERE
        DocVersions.SiteId = @DocSiteId AND
        DocVersions.Id = @DocId AND
        DocVersions.Version = @ClientVersion AND
        Webs.Id = @WebId
    UNION ALL
    SELECT
        COALESCE(DocStreams.Size, Docs.Size),
        Docs.DocFlags,
        Docs.TimeLastModified,
        Webs.FullUrl,
        @WebId,
        Webs.FirstUniqueAncestorWebId,
        Webs.SecurityProvider,
        @InDoclib,
        @DocId,
        @SiteFlags,
        Perms.Acl,
        Perms.AnonymousPermMask,
        Lists.tp_ID,
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
        0, 
        Docs.DraftOwnerId,
        Lists.tp_Flags,
        Docs.Level,
        Docs.VirusVendorID,
        Docs.VirusStatus,
        Docs.VirusInfo,
        CASE WHEN 
        ((Docs.DocFlags & 1) = 1 OR
            (NOT (((@ValidationType & 1) = 1) AND
                (@ClientId = Docs.Id))) OR
            (NOT (((@ValidationType & 2) = 
                2) AND
                @IfModifiedSince <> Docs.TimeCreated)))
        THEN 1 ELSE 0 END,
        @ProgId,
        @Docs_DirName,
        @Docs_LeafName,
        @Docs_Type 
    FROM
        Docs
    LEFT OUTER JOIN DocStreams
    ON
        Docs.SiteId = DocStreams.SiteId AND
        Docs.ParentId = DocStreams.ParentId AND
        Docs.Id = DocStreams.Id AND
        Docs.Level = DocStreams.Level
    INNER JOIN
        Webs
    ON
        Docs.SiteId = Webs.SiteId
    LEFT OUTER JOIN
        Lists WITH (NOLOCK)
    ON
        Webs.Id = Lists.tp_WebId AND
        @ListId = Lists.tp_ID
    INNER JOIN
        Perms
    ON
        Docs.SiteId = Perms.SiteId AND
        Perms.ScopeId = @DocScopeId
    INNER JOIN
        Webs AS FirstUniqueWeb
    ON
        Webs.FirstUniqueAncestorWebId = FirstUniqueWeb.Id AND
        Docs.SiteId = FirstUniqueWeb.SiteId
    LEFT OUTER JOIN
        UserInfo
    ON
        Docs.SiteId = UserInfo.tp_SiteId AND
        UserInfo.tp_SystemId = @SystemID AND
        UserInfo.tp_Deleted = 0
    LEFT OUTER JOIN
        WebMembers
    ON
        WebMembers.WebId = FirstUniqueWeb.Id AND
        WebMembers.UserId = UserInfo.tp_Id
    WHERE
        Docs.SiteId = @DocSiteId AND
        Docs.Id = @DocId AND
        Docs.UIVersion = @ClientVersion AND
        Docs.IsCurrentVersion = 0 AND 
        Webs.Id = @WebId
    IF @@ROWCOUNT <> 1
        RETURN 3
    IF @FetchType = 1
        RETURN 0
    SELECT
        @Size = Size
    FROM
        DocVersions
    WHERE
        DocVersions.SiteId = @DocSiteId AND
        DocVersions.Id = @DocId AND
        DocVersions.Version = @ClientVersion AND
        ((DocVersions.DocFlags & 1) = 1 OR
            (NOT (((@ValidationType & 1) = 1) AND
                (@ClientId = DocVersions.Id))) OR
            (NOT (((@ValidationType & 2) = 
                2) AND
                @IfModifiedSince <> DocVersions.TimeCreated)) OR
            (@VirusVendorID IS NOT NULL AND
                @VirusVendorID <> VirusVendorID AND
                (VirusStatus IS NULL OR VirusStatus = 0)))
    IF @@ROWCOUNT = 1
    BEGIN
        SELECT
            CASE WHEN @Size > @ChunkSize AND DocVersions.Content IS NOT NULL AND (DocFlags & 65536) = 0 THEN 0x0 ELSE DocVersions.Content END,
            @Size,
            @ClientVersion,
            @DocId
        FROM
            DocVersions
        WHERE
            SiteId = @DocSiteId AND
            Id = @DocId AND
            Version = @ClientVersion
    END
    ELSE
    BEGIN
        SELECT
            @Size = Size
        FROM
            Docs
        WHERE
            Docs.SiteId = @DocSiteId AND
            Docs.Id = @DocId AND
            Docs.UIVersion = @ClientVersion AND
            ((Docs.DocFlags & 1) = 1 OR
                (NOT (((@ValidationType & 1) = 1) AND
                    (@ClientId = Docs.Id))) OR
                (NOT (((@ValidationType & 2) = 
                    2) AND
                    @IfModifiedSince <> Docs.TimeLastModified)) OR
                (@VirusVendorID IS NOT NULL AND
                    @VirusVendorID <> VirusVendorID AND
                    (VirusStatus IS NULL OR VirusStatus = 0)))
         IF @@ROWCOUNT = 1
         BEGIN
             SELECT
                 CASE WHEN DocStreams.Size > @ChunkSize AND DocStreams.Content IS NOT NULL AND (DocFlags & 65536) = 0 THEN 0x0 ELSE DocStreams.Content END,
                 @Size,
                 @ClientVersion,
                 @DocId
             FROM
                Docs LEFT OUTER JOIN DocStreams
             ON
                 Docs.SiteId = DocStreams.SiteId AND
                 Docs.ParentId = DocStreams.ParentId AND
                 Docs.Id = DocStreams.Id AND
                 Docs.Level = DocStreams.Level
             WHERE
                 Docs.SiteId = @DocSiteId AND
                 Docs.Id = @DocId AND
                 Docs.UIVersion = @ClientVersion
         END
    END    
    IF @@ROWCOUNT <> 1
    BEGIN
        RETURN 18 
    END
    RETURN 0

GO
