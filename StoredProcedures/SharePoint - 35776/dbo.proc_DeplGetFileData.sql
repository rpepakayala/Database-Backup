/****** Object:  StoredProcedure [dbo].[proc_DeplGetFileData]    Script Date: 5/15/2018 12:11:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetFileData(
    @SiteId         uniqueidentifier,
    @LastOrdinal    int,
    @VersionSetting int)
AS
    SET NOCOUNT ON
    DECLARE @IsMajorFileOnly int
    IF (@VersionSetting = 1)
    BEGIN
        SET @IsMajorFileOnly = 1
    END
    ELSE
    BEGIN
        SET @IsMajorFileOnly = 0
    END
    SELECT
        E.Id,
        E.FullUrl as ExportObjectUrl,
        E.Ordinal,
        d.WebId,  -- Same as E.ParentWebId
        d.ListId,
        E.ParentId,
        d.ScopeId,
        d.DocLibRowId,
        d.MetaInfo,
        d.UIVersion,
        d.UIVersionString,
        CASE -- 1 if ghosted; else 0
            WHEN (d.DocFlags & 64) = 0 THEN 1
            ELSE 0
        END AS IsGhosted,
        d.TimeCreated,
        d.TimeLastModified,
        d.DirName,
        d.LeafName,
        d.SetupPath,
        d.SetupPathUser,
        d.SetupPathVersion,
        d.UnVersionedMetaInfo,
        d.CheckinComment,
        d.AuditFlags,
        d.InheritAuditFlags,
        d.Level,
        d.HasStream,
        d.Size,
        Perms.Acl
    FROM
        (SELECT TOP 200
            E.*
        FROM #ExportObjects E
        WHERE
            E.Ordinal > @LastOrdinal AND
            (E.Type = 5 OR E.Type = 7) AND
            E.IsDeleted = 0 
        ORDER BY
            E.Ordinal ) E
    INNER JOIN
        Docs d
    ON
        E.DirName = d.DirName AND
        E.LeafName = d.LeafName AND
        d.SiteId = @SiteId AND
        ((@IsMajorFileOnly = 1 AND d.Level = 1 ) OR
         (@IsMajorFileOnly = 0 AND d.Level IN
            (SELECT TOP 1
                d2.Level
             FROM Docs d2
             WHERE
                 d2.SiteId = @SiteId AND
                 d2.DirName = d.DirName AND
                 d2.LeafName = d.LeafName AND
                 d2.Level <> 255 )))
    INNER JOIN
        Perms
    ON
        Perms.SiteId = @SiteId AND
        d.ScopeId = Perms.ScopeId
    ORDER BY E.Ordinal
    EXEC proc_DeplGetFileVersions @LastOrdinal, @VersionSetting, @SiteId
    EXEC proc_DeplGetFileWebParts @LastOrdinal, @VersionSetting, @SiteId
    EXEC proc_DeplGetFileLinks @LastOrdinal, @IsMajorFileOnly, @VersionSetting, @SiteId
    EXEC proc_DeplGetFileEventReceivers @LastOrdinal, @SiteId

GO
