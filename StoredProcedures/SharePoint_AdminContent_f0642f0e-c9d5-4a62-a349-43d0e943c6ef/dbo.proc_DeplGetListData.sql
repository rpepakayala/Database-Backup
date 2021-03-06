/****** Object:  StoredProcedure [dbo].[proc_DeplGetListData]    Script Date: 5/15/2018 12:12:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetListData(
    @LastOrdinal int,
    @SiteId uniqueidentifier,
    @IsIncremental bit,
    @ChangeTimeStart datetime = null,
    @ChangeNumberStart int = null,
    @ChangeTimeEnd datetime = null,
    @ChangeNumberEnd int = null
)
AS
    SET NOCOUNT ON
    SELECT
        lists.Id,
        lists.FullUrl as ExportObjectUrl,
        lists.Ordinal,
        lists.tp_Title,
        lists.tp_Description,
        lists.tp_Modified,
        lists.tp_Created,
        lists.tp_Version,
        lists.tp_BaseType,
        lists.tp_FeatureId,
        lists.tp_ServerTemplate,
        lists.tp_RootFolder,
        lists.tp_Template,
        lists.tp_ReadSecurity,
        lists.tp_WriteSecurity,
        lists.tp_Fields,
        lists.tp_Direction,
        lists.tp_Flags,
        lists.tp_ThumbnailSize,
        lists.tp_WebImageWidth,
        lists.tp_WebImageHeight,
        lists.tp_ImageUrl,
        lists.tp_Author,
        lists.tp_EventSinkAssembly,
        lists.tp_EventSinkClass,
        lists.tp_EventSinkData,
        lists.tp_EmailInsertsFolder,
        lists.tp_EmailAlias,
        CASE WHEN DocTemplate.DirName = N'' THEN
            N'/' + DocTemplate.LeafName
        ELSE
            N'/' + DocTemplate.DirName + N'/' + DocTemplate.LeafName
        END AS tp_DocTemplateUrl,
        lists.tp_ContentTypes,
        Perms.Acl,
        lists.tp_MaxMajorVersionCount,
        lists.tp_MaxMajorwithMinorVersionCount,
        lists.tp_SendToLocation
   FROM (
        SELECT TOP 50
            e.Id,
            e.FullUrl,
            e.Ordinal,
            Lists.tp_Title,
            Lists.tp_Description,
            Lists.tp_Modified,
            Lists.tp_Created,
            Lists.tp_Version,
            Lists.tp_BaseType,
            Lists.tp_FeatureId,
            Lists.tp_ServerTemplate,
            Lists.tp_RootFolder,
            Lists.tp_Template,
            Lists.tp_ReadSecurity,
            Lists.tp_WriteSecurity,
            Lists.tp_Fields,
            Lists.tp_Direction,
            Lists.tp_Flags,
            Lists.tp_ThumbnailSize,
            Lists.tp_WebImageWidth,
            Lists.tp_WebImageHeight,
            Lists.tp_ImageUrl,
            Lists.tp_Author,
            Lists.tp_EventSinkAssembly,
            Lists.tp_EventSinkClass,
            Lists.tp_EventSinkData,
            Lists.tp_EmailInsertsFolder,
            Lists.tp_EmailAlias,
            Lists.tp_ContentTypes,
            Lists.tp_ScopeId,
            Lists.tp_MaxMajorVersionCount,
            Lists.tp_MaxMajorwithMinorVersionCount,
            Lists.tp_SendToLocation
        FROM #ExportObjects e
        INNER JOIN
            Lists
        ON
            e.Id = Lists.tp_ID AND
            e.ParentWebId = Lists.tp_WebId AND
            e.Ordinal > @LastOrdinal AND
            e.Type = 3 AND
            e.IsDeleted = 0
        ORDER BY e.Ordinal) lists
    INNER JOIN Perms
    ON
        Perms.SiteId = @SiteId AND
        lists.tp_ScopeId = Perms.ScopeId
    LEFT OUTER JOIN Docs AS DocTemplate
    ON
            DocTemplate.Id = lists.tp_Template AND
            DocTemplate.Level = 1
    ORDER BY lists.Ordinal
    EXEC proc_DeplGetListWebParts @LastOrdinal, @SiteId
    EXEC proc_DeplGetListEventReceivers @LastOrdinal, @SiteId
    IF @IsIncremental = 1
        EXEC proc_DeplGetListDeletedFields @LastOrdinal, @SiteId, @ChangeTimeStart, @ChangeNumberStart, @ChangeTimeEnd, @ChangeNumberEnd
    ELSE
        SELECT cast(NULL as uniqueidentifier) as ListId        

GO
