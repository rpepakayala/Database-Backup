/****** Object:  StoredProcedure [dbo].[proc_DeplAddListItemDependencies]    Script Date: 5/15/2018 12:12:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplAddListItemDependencies(
    @SiteId uniqueidentifier,
    @IsMajorFileOnly int,
    @LinksOnly tinyint)
AS
    SET NOCOUNT ON
    DECLARE @Level int
    SET @Level = 0
    IF NOT EXISTS
        (SELECT TOP 1 Id FROM #ExportObjects
         WHERE Type = 4)
        RETURN 0
    DECLARE @ContentTypes TABLE(
        NewId uniqueidentifier,
        NewLevel int,
        NewParentId uniqueidentifier,
        NewParentWebId uniqueidentifier,
        NewDirName nvarchar(256),
        NewContentTypeId varbinary(512),
        NewContentTypeListId uniqueidentifier)
    INSERT INTO @ContentTypes(
        NewId,
        NewLevel,
        NewDirName,
        NewParentId,
        NewParentWebId,
        NewContentTYpeId,
        NewCOntentTypeListId)
    SELECT DISTINCT
        CAST(SUBSTRING(tp_ContentTypeId, len(tp_contenttypeid)- 15, 16 ) as uniqueidentifier),
        @Level + 1,
        UserData.tp_DirName,
        UserData.tp_ListId,
        e.ParentWebId,
        UserData.tp_ContentTypeId,
        UserData.tp_ListId
    FROM #ExportObjects e
    INNER JOIN
        UserData
    ON
        e.DirName = UserData.tp_DirName AND
        e.LeafName = UserData.tp_LeafName AND
        e.Type = 4 AND
        e.IsDeleted = 0 AND
        e.IsLink = @LinksOnly AND
        UserData.tp_RowOrdinal = 0 AND
        UserData.tp_ContentType IS NOT NULL AND
        ((@IsMajorFileOnly = 1 AND UserData.tp_Level=1) OR
         (@IsMajorFileOnly = 0 AND UserData.tp_Level IN
            (SELECT TOP 1 d2.tp_Level FROM UserData d2
             WHERE
               d2.tp_Id = UserData.tp_Id AND
               d2.tp_ListId = UserData.tp_ListId AND
               d2.tp_Level <> 255))) AND
        UserData.tp_SiteId = @SiteId
    WHERE
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects existing
            WHERE
                UserData.tp_ContentTypeId = existing.ContentTypeId) AND
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects existing
            WHERE
                UserData.tp_ListId = existing.Id)
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        DirName,
        LeafName,
        ParentId,
        ParentWebId,
        IncludeDescendants,
        FullUrl,
        ContentTypeId,
        ContentTypeListId,
        ParseContentType,
        IsLink)
   SELECT
        NewId,
        8,
        NewLevel,
        NewDirName,
        '',
        NewParentId,
        NewParentWebId,
        0,
        NewDirName,
        NewContentTypeId,
        NewContentTypeListId,
        1, 
        @LinksOnly
    FROM @ContentTypes
    WHERE
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects existing
            WHERE
                NewId = existing.Id)
    INSERT INTO #ExportObjects(
        Id,
        Level,
        DirName,
        LeafName,
        Type,
        ParentId,
        ParentWebId,
        IncludeDescendants,
        IsLink,
        FullUrl)
    SELECT
        Docs.Id,
        @Level + 1,
        Docs.DirName,
        Docs.LeafName,
        CASE
            WHEN Docs.Type = 1 AND Docs.DocLibRowId IS NOT NULL THEN 6
            WHEN Docs.Type = 1 THEN 2
            WHEN Docs.DocLibRowId IS NOT NULL THEN 7
            ELSE 5
        END,
        Docs.ParentId,
        Docs.WebId,
        e.IncludeDescendants,
        @LinksOnly, 
        CASE
            WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName
            WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName
            ELSE Docs.DirName + N'/' + Docs.LeafName
        END
    FROM #ExportObjects e
    INNER JOIN
        Docs
    ON
        e.DirName = Docs.DirName AND
        e.LeafName = Docs.LeafName AND
        e.Type = 4 AND
        e.IsDeleted = 0 AND
        e.IsLink = @LinksOnly AND
        ((@IsMajorFileOnly = 1 AND Docs.Level=1) OR
         (@IsMajorFileOnly = 0 AND Docs.Level IN
            (SELECT TOP 1 d2.Level FROM Docs d2
             WHERE d2.Id=Docs.Id AND d2.Level <> 255))) AND
        Docs.SiteId = @SiteId
    WHERE
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects existing
            WHERE
                Docs.Id = existing.Id) AND
        NOT EXISTS (
            SELECT 1
            FROM #ExportObjects existing
            WHERE
                Docs.ListId = existing.Id AND
                existing.IncludeDescendants > 0)

GO
