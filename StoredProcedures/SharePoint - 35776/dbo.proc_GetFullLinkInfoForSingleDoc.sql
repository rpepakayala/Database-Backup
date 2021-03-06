/****** Object:  StoredProcedure [dbo].[proc_GetFullLinkInfoForSingleDoc]    Script Date: 5/15/2018 12:12:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetFullLinkInfoForSingleDoc(
    @DocSiteId   uniqueidentifier,
    @DocDirName  nvarchar(256),
    @DocLeafName nvarchar(128),
    @UserId int,
    @AttachmentsFlag tinyint,
    @MaxCheckinLevel tinyint,
    @GetWebListForNormalization bit)
AS
    SET NOCOUNT ON
    DECLARE @Type tinyint
    DECLARE @DocFullUrl nvarchar(260)
    DECLARE @Level tinyint
    DECLARE @DocWebId uniqueidentifier
    DECLARE @DocSetupPath nvarchar(255)
    SET @DocFullUrl = CASE WHEN (DATALENGTH(@DocDirName) = 0) THEN @DocLeafName WHEN (DATALENGTH(@DocLeafName) = 0) THEN @DocDirName ELSE @DocDirName + N'/' + @DocLeafName END
    SET @Level = NULL
    SELECT TOP 1
        @Type = Docs.Type,
        @DocWebId = Docs.WebId,
        @DocSetupPath = CASE
                WHEN Docs.DocFlags & 64 <> 0
                THEN NULL
                ELSE Docs.SetupPath
            END
    FROM
        Docs
    WHERE
        Docs.SiteId = @DocSiteId AND
        Docs.DirName = @DocDirName AND
        Docs.LeafName = @DocLeafName
    IF @Type <> 0
        RETURN 2
    IF @GetWebListForNormalization = 1
    BEGIN
        SELECT
            FullUrl
        FROM
            Webs
        WHERE
            SiteId = @DocSiteId AND
            ParentWebId = @DocWebId
    END
    EXEC proc_GetLevel  
            @DocSiteId, 
            @DocDirName, 
            @DocLeafName, 
            @UserId,
            1,
            @Level OUTPUT    
    EXEC proc_SecGetIndividualUrlSecurity @DocSiteId, @DocWebId,
        @DocFullUrl, @DocDirName, @DocLeafName, @UserId, @AttachmentsFlag,
        0, 0,
        0, 0, @Level
    SELECT
        Links.TargetDirName AS LinkDirName,
        Links.TargetLeafName AS LinkLeafName, Links.Type AS LinkType,
        Links.Security AS LinkSecurity, Links.Dynamic AS LinkDynamic,
        Links.ServerRel AS LinkServerRel, Docs.Type AS LinkStatus,
        PointsToDir AS PointsToDir, NULL AS WebPartId, NULL AS LinkNumber,
        Docs.WebId AS WebId, Links.Search AS Search, Links.FieldId AS FieldId
    FROM
        Links LEFT OUTER JOIN Docs
    ON
        Links.ServerRel = 1 AND
        Docs.SiteId = Links.SiteId AND
        Docs.DirName = Links.TargetDirName AND
        Docs.LeafName = Links.TargetLeafName
    WHERE
        Links.SiteId = @DocSiteId AND
        Links.DirName = @DocDirName AND
        Links.LeafName = @DocLeafName AND
        Links.Level = @Level
    UNION ALL
    SELECT
        Links.DirName AS LinkDirName,
        Links.LeafName AS LinkLeafName, Links.Type AS LinkType, 
        Links.Security AS LinkSecurity, Links.Dynamic AS LinkDynamic,
        Links.ServerRel AS LinkServerRel,
        CAST(128 AS tinyint) AS LinkStatus,
        PointsToDir AS PointsToDir, NULL AS WebPartId, NULL AS LinkNumber,
        Docs.WebId AS WebId, Links.Search AS Search, Links.FieldId AS FieldId
    FROM
        Docs
    INNER JOIN
        AllLinks AS Links WITH (INDEX=Links_Backward)
    ON
        Links.SiteId = Docs.SiteId AND
        Links.DirName = Docs.DirName AND
        Links.LeafName = Docs.LeafName
    WHERE
        Links.SiteId = @DocSiteId AND
        Links.DeleteTransactionId = 0x AND
        Links.TargetDirName = @DocDirName AND
        Links.TargetLeafName = @DocLeafName
    SELECT @DocSetupPath

GO
