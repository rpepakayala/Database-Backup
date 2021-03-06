/****** Object:  StoredProcedure [dbo].[proc_GetLinkInfo]    Script Date: 5/15/2018 12:12:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetLinkInfo(
    @DirSiteId uniqueidentifier,
    @DirFullUrl nvarchar(260),
    @ClientTimeStamp datetime,
    @IncludeListItems bit,
    @UserId int)
AS
    SET NOCOUNT ON
    SELECT
        Docs.Id AS DocId, Links.TargetDirName AS LinkDirName,
        Links.TargetLeafName AS LinkLeafName, Links.Type AS LinkType,
        Links.Security AS LinkSecurity, Links.Dynamic AS LinkDynamic,
        Links.ServerRel AS LinkServerRel, Docs2.Type AS LinkStatus,
        PointsToDir AS PointsToDir, NULL AS WebPartId, NULL AS LinkNumber,
        NULL AS WebId, NULL AS Search, NULL AS FieldId
    FROM
        Links INNER JOIN Docs
    ON
        Docs.SiteId = Links.SiteId AND
        Docs.DirName = Links.DirName AND
        Docs.LeafName = Links.LeafName
        LEFT OUTER JOIN Docs Docs2
    ON
        Links.ServerRel = 1 AND
        Docs2.SiteId = Links.SiteId AND
        Docs2.DirName = Links.TargetDirName AND
        Docs2.LeafName = Links.TargetLeafName
    WHERE
        Docs.SiteId = @DirSiteId AND Docs.DirName = @DirFullUrl AND
        Docs.MetaInfoTimeLastModified > @ClientTimeStamp AND
        (Docs.Type <> 0 OR
         @IncludeListItems = 1 OR
         Docs.DocFlags & 2048 = 0 OR
         Docs.DocFlags & 256 <> 0) AND
        (Docs.Level = 255 AND 
            Docs.LTCheckoutUserId = @UserId OR
         ((Docs.Level = 1 AND 
          Docs.DraftOwnerId IS NULL OR 
          Docs.Level = 2)  AND
        (Docs.LTCheckoutUserId IS NULL OR 
            Docs.LTCheckoutUserId <> @UserId)))
    UNION ALL
    SELECT DISTINCT
        Docs.Id AS DocId, Links.DirName AS LinkDirName,
        Links.LeafName AS LinkLeafName, Links.Type AS LinkType, 
        NULL AS LinkSecurity, NULL AS LinkDynamic, NULL AS LinkServerRel,
        CAST(128 AS tinyint) AS LinkStatus,
        NULL AS PointsToDir,
        NULL AS WebPartId, NULL AS LinkNumber, NULL As WebId,
        NULL AS Search, NULL AS FieldId
    FROM
        Docs
    INNER JOIN
        AllLinks AS Links WITH (INDEX=Links_Backward)
    ON
        Docs.SiteId = Links.SiteId AND
        Links.DeleteTransactionId = 0x AND
        Docs.DirName = Links.TargetDirName AND
        Docs.LeafName = Links.TargetLeafName
    WHERE
        Docs.SiteId = @DirSiteId AND Docs.DirName = @DirFullUrl AND
        Docs.MetaInfoTimeLastModified > @ClientTimeStamp AND
        (Docs.Type <> 0 OR
         @IncludeListItems = 1 OR
         Docs.DocFlags & 2048 = 0 OR
         Docs.DocFlags & 256 <> 0)
    ORDER BY
        DocId
    RETURN 0

GO
