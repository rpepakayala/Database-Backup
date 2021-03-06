/****** Object:  StoredProcedure [dbo].[proc_GetLinkInfoSingleDocForFixup]    Script Date: 5/15/2018 12:12:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetLinkInfoSingleDocForFixup(
    @DocSiteId uniqueidentifier,
    @DocDirName nvarchar(256),
    @DocLeafName nvarchar(128),
    @Level tinyint)
AS
    SET NOCOUNT ON
    SELECT DISTINCT
        Links.TargetDirName AS LinkDirName,
        Links.TargetLeafName AS LinkLeafName, Links.Type AS LinkType,
        Links.Security AS LinkSecurity, Links.Dynamic AS LinkDynamic,
        Links.ServerRel AS LinkServerRel, Docs.Type AS LinkStatus,
        Links.PointsToDir AS PointsToDir, Links.WebPartId AS WebPartId,
        Links.LinkNumber AS LinkNumber, NULL AS WebId, NULL AS Search,
        FieldId AS FieldId
    FROM
        Links LEFT OUTER JOIN Docs
    ON
        Docs.SiteId = Links.SiteId AND
        Docs.DirName = Links.TargetDirName AND
        Docs.LeafName = Links.TargetLeafName
    WHERE
        Links.SiteId = @DocSiteId AND Links.DirName = @DocDirName AND
        Links.LeafName = @DocLeafName AND Links.Level = @Level
    ORDER BY
        WebPartId, LinkNumber

GO
