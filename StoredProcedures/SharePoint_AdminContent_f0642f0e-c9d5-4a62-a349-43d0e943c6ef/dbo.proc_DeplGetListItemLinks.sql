/****** Object:  StoredProcedure [dbo].[proc_DeplGetListItemLinks]    Script Date: 5/15/2018 12:12:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE Procedure dbo.proc_DeplGetListItemLinks(
    @LastOrdinal int,
    @IsMajorFileOnly int,
    @SiteId uniqueidentifier,
    @ListId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT DISTINCT
        e.Id,
        isnull(TargetDocs.Id, newid()),
        '/' + CASE WHEN (DATALENGTH(Links.TargetDirName) = 0) THEN Links.TargetLeafName WHEN (DATALENGTH(Links.TargetLeafName) = 0) THEN Links.TargetDirName ELSE Links.TargetDirName + N'/' + Links.TargetLeafName END as TargetUrl
    FROM
        (SELECT TOP 200
            E2.Id,
            E2.DirName,
            E2.LeafName
        FROM #ExportObjects E2
        WHERE
            E2.Ordinal > @LastOrdinal AND
            E2.Type = 4 AND
            E2.ParentId = @ListId AND
            E2.IsDeleted = 0
        ORDER BY E2.Ordinal ) AS e
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
