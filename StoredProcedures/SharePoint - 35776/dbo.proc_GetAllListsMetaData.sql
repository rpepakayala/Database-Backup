/****** Object:  StoredProcedure [dbo].[proc_GetAllListsMetaData]    Script Date: 5/15/2018 12:12:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetAllListsMetaData(
    @WebId uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @SiteId uniqueidentifier        
    DECLARE @WebFullUrl nvarchar(256)
    DECLARE @WebTitle nvarchar(255)
    DECLARE @WebFlags int
    SELECT
       @SiteId = SiteId,
       @WebFullUrl = Webs.FullUrl,
       @WebTitle = Webs.Title,
       @WebFlags = Webs.Flags
    FROM
       Webs
    WHERE
       Webs.Id = @WebId
    SET @WebFullUrl = N'/' + @WebFullUrl
    SELECT
        Lists.tp_ID,
        Lists.tp_Title,
        Lists.tp_Modified,
        Lists.tp_Created,
        Lists.tp_LastDeleted,
        Lists.tp_Version,
        Lists.tp_BaseType,
        Lists.tp_FeatureId,
        Lists.tp_ServerTemplate,
        AllDocs1.DirName,        
        AllDocs1.LeafName,
        AllDocs2.DirName,        
        AllDocs2.LeafName,
        Lists.tp_ReadSecurity,
        Lists.tp_WriteSecurity,
        Lists.tp_Description,
        CASE WHEN @WebFlags & 0x200 = 0x200 OR
                  Lists.tp_Flags & 0x200000000 = 0x200000000
        THEN
             NULL
        ELSE
             Lists.tp_Fields
        END,
        Lists.tp_Direction,
        Perms.AnonymousPermMask,
        Lists.tp_Flags,
        Lists.tp_ThumbnailSize,
        Lists.tp_WebImageWidth,
        Lists.tp_WebImageHeight,
        Lists.tp_ImageUrl,
        Lists.tp_ItemCount,
        Lists.tp_Author,
        Lists.tp_HasInternalFGP,
        Lists.tp_ScopeId,
        Perms.Acl,
        Lists.tp_EventSinkAssembly,
        Lists.tp_EventSinkClass,
        Lists.tp_EventSinkData,
        Lists.tp_EmailInsertsFolder,
        Lists.tp_EmailInsertsLastSyncTime,
        Lists.tp_EmailAlias,
        @WebFullUrl AS tp_WebFullUrl,
        @WebId AS tp_WebId,
        @WebTitle AS tp_WebTitle,
        Lists.tp_SendToLocation,
        ISNULL(Lists.tp_MaxMajorVersionCount, 0),
        ISNULL(Lists.tp_MaxMajorwithMinorVersionCount, 0),
        Lists.tp_MaxRowOrdinal,
        Lists.tp_ListDataDirty,
        Lists.tp_DefaultWorkflowId,
        Lists.tp_ContentTypes,
        Lists.tp_Subscribed
    FROM
        Lists
    INNER JOIN
        AllDocs AS AllDocs1
    ON
        AllDocs1.Id = Lists.tp_RootFolder AND
        AllDocs1.Level = 1
    LEFT OUTER JOIN
        AllDocs AS AllDocs2
    ON
        AllDocs2.Id = Lists.tp_Template AND
        AllDocs2.Level = 1
    INNER JOIN Perms 
    ON
        Perms.SiteId = @SiteId AND
        Perms.ScopeId = Lists.tp_ScopeId
    WHERE
        Lists.tp_WebId = @WebId
    ORDER BY
        Lists.tp_ID
    EXEC proc_GetAllListsWebParts @WebID
    RETURN 0

GO
