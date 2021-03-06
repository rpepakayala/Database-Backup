/****** Object:  StoredProcedure [dbo].[proc_DeplGetFileLinks]    Script Date: 5/15/2018 12:12:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE Procedure dbo.proc_DeplGetFileLinks(
    @LastOrdinal int,
    @IsMajorFileOnly int,
    @VersionSetting int,
    @SiteId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        e.Id,
        isnull(TargetDocs.Id, newid()),
        '/' + CASE WHEN (DATALENGTH(Links.TargetDirName) = 0) THEN Links.TargetLeafName WHEN (DATALENGTH(Links.TargetLeafName) = 0) THEN Links.TargetDirName ELSE Links.TargetDirName + N'/' + Links.TargetLeafName END as TargetUrl,
        Links.WebPartId,
        Links.LinkNumber,
        Links.Type,
        Links.Security,
        Links.Dynamic,
        Links.ServerRel,
        Links.Level,
        Links.Search
    FROM (
        SELECT TOP 200
            E.Id,
            E.DirName,
            E.LeafName
        FROM #ExportObjects e
        WHERE
            e.Ordinal > @LastOrdinal AND
            e.IsDeleted = 0 AND
            (e.Type = 5 OR
             e.Type = 7)
        ORDER BY e.Ordinal) e
    INNER JOIN
        Docs d
    ON
        d.SiteId = @SiteId AND
        d.DirName = e.DirName AND
        d.LeafName = e.LeafName AND
        ((@VersionSetting = 1 AND d.Level = 1 ) OR
         (@VersionSetting <> 1 AND d.Level IN
             (SELECT TOP 1
                  d2.Level
              FROM Docs d2
              WHERE
                  d2.SiteId = @SiteId AND
                  d2.DirName = e.DirName AND
                  d2.LeafName = e.LeafName AND
                  d2.Level <> 255 )))
    INNER JOIN
        Links
    ON
        Links.SiteId = @SiteId AND
        Links.DirName = e.DirName AND
        Links.LeafName = e.LeafName AND
        Links.ServerRel = 1 AND
        NOT (Links.DirName  = Links.TargetDirName AND
             Links.LeafName = Links.TargetLeafName) AND
        ((@IsMajorFileOnly = 1 AND Links.Level = 1 ) OR
        (@IsMajorFileOnly = 0 AND Links.Level <> 255))
    LEFT JOIN
        Docs TargetDocs
    ON
        Links.SiteId = TargetDocs.SiteId AND
        Links.TargetDirName = TargetDocs.DirName AND
        Links.TargetLeafName = TargetDocs.LeafName AND
        ((@IsMajorFileOnly = 1 AND TargetDocs.Level = 1 ) OR
        (@IsMajorFileOnly = 0 AND TargetDocs.Level <> 255))

GO
