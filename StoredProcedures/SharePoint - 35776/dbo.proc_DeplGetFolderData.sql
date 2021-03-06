/****** Object:  StoredProcedure [dbo].[proc_DeplGetFolderData]    Script Date: 5/15/2018 12:11:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetFolderData(
    @SiteId         uniqueidentifier,
    @LastOrdinal int,
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
        e.Id,
        e.FullUrl as ExportObjectUrl,
        e.Ordinal,
        e.ParentWebId,
        folders.LeafName,
        folders.ListId,
        folders.DocLibRowId,
        folders.WelcomePageUrl,
        folders.WelcomePageParameters,
        CASE
            WHEN folders.Type = 2 THEN 1
            ELSE 0
        END as IsWebRootFolder,
        Perms.Acl,
        folders.MetaInfo,
        folders.TimeCreated,
        folders.TimeLastModified
    FROM (
        SELECT TOP 200
            e.*
        FROM #ExportObjects e
        WHERE
            e.Ordinal > @LastOrdinal AND
            (e.Type = 2 OR
             e.Type = 6) AND
            e.IsDeleted = 0 
         ORDER BY e.Ordinal) e
    INNER JOIN
        Docs folders
    ON
        e.DirName = folders.DirName AND
        e.LeafName = folders.LeafName AND
        folders.SiteId = @SiteId AND
        ((@IsMajorFileOnly = 1 AND folders.Level = 1 ) OR
         (@IsMajorFileOnly = 0 AND folders.Level IN
            (SELECT TOP 1
                d2.Level
             FROM Docs d2
             WHERE
                 d2.SiteId = @SiteId AND
                 d2.DirName = folders.DirName AND
                 d2.LeafName = folders.LeafName AND
                 d2.Level <> 255 )))
    INNER JOIN Perms
    ON
        folders.SiteId = Perms.SiteId AND
        folders.ScopeId = Perms.ScopeId
    ORDER BY e.Ordinal        

GO
