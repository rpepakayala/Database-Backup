/****** Object:  StoredProcedure [dbo].[proc_GetListMetaData]    Script Date: 5/15/2018 12:12:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetListMetaData(
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @PrefetchListScope bit = 0)
AS
    SET NOCOUNT ON
    DECLARE @SiteId uniqueidentifier        
    DECLARE @WebFullUrl nvarchar(256)
    DECLARE @WebTitle nvarchar(255)
    DECLARE @WebFlags int
    DECLARE @WebTemplate int
    DECLARE @WebLanguage int
    DECLARE @WebCollation smallint
    SELECT
       @SiteId = SiteId,
       @WebFullUrl = Webs.FullUrl,
       @WebTitle = Webs.Title,
       @WebFlags = Webs.Flags,
       @WebTemplate = Webs.WebTemplate,
       @WebLanguage = Webs.Language,
       @WebCollation = Webs.Collation
    FROM
       Webs WITH (NOLOCK)
    WHERE
       Webs.Id = @WebId
    SET @WebFullUrl = N'/' + @WebFullUrl
    SELECT
        tp_ID,
        tp_Title,
        tp_Modified,
        tp_Created,
        tp_LastDeleted,
        tp_Version,
        tp_BaseType,
        tp_FeatureId,
        tp_ServerTemplate,
        Docs1.DirName,        
        Docs1.LeafName,
        Docs2.DirName,        
        Docs2.LeafName,
        tp_ReadSecurity,
        tp_WriteSecurity,
        tp_Description,
        CASE WHEN @WebFlags & 0x200 = 0x200 OR
                  tp_Flags & 0x200000000 = 0x200000000
        THEN
             NULL
        ELSE
             tp_Fields
        END,
        tp_Direction,
        Perms.AnonymousPermMask,
        tp_Flags,
        tp_ThumbnailSize,
        tp_WebImageWidth,
        tp_WebImageHeight,
        tp_ImageUrl,
        tp_ItemCount,
        tp_Author,
        tp_HasInternalFGP,
        tp_ScopeId,
        Perms.Acl,
        tp_EventSinkAssembly,
        tp_EventSinkClass,
        tp_EventSinkData,
        tp_EmailInsertsFolder,
        tp_EmailInsertsLastSyncTime,
        tp_EmailAlias,
        @WebFullUrl AS tp_WebFullUrl,
        @WebId AS tp_WebId,
        @WebTitle AS tp_WebTitle,
        @WebTemplate AS tp_WebTemplate,
        @WebLanguage AS tp_WebLanguage,
        @WebCollation AS tp_WebCollation,
        tp_SendToLocation,
        ISNULL(Lists.tp_MaxMajorVersionCount, 0),
        ISNULL(Lists.tp_MaxMajorwithMinorVersionCount, 0),       
        tp_MaxRowOrdinal,
        tp_ListDataDirty,
        tp_DefaultWorkflowId,
        Lists.tp_ContentTypes,
        Lists.tp_Subscribed
    FROM
        Lists INNER JOIN Docs AS Docs1
    ON
        Docs1.Id = Lists.tp_RootFolder AND
        Docs1.Level = 1
        LEFT OUTER JOIN Docs AS Docs2
    ON
        Docs2.Id = Lists.tp_Template AND
        Docs2.Level = 1
        INNER JOIN Perms 
    ON
        Perms.SiteId = @SiteId AND
        Perms.ScopeId = Lists.tp_ScopeId
    WHERE
        Lists.tp_Id = @ListId AND
        Lists.tp_WebId = @WebId
    IF (@PrefetchListScope <> 0)
    BEGIN
        EXEC proc_GetUniqueScopesInList @SiteId, @WebId, @ListId, 0
    END

GO
