/****** Object:  StoredProcedure [dbo].[proc_DeplGetFileWebParts]    Script Date: 5/15/2018 12:12:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetFileWebParts(
    @LastOrdinal int,
    @VersionSetting int,
    @SiteId uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @FileWebParts TABLE (
        tp_ID uniqueidentifier,
        tp_ListID uniqueidentifier,
        tp_Type tinyint,
        tp_Flags int,
        tp_Hidden int,
        tp_Threaded int,
        tp_FPModified int,
        tp_ReadOnly int,
        tp_Scope nvarchar(16),
        tp_RecurrenceRowset int,
        tp_ModerationType nvarchar(16),
        tp_Personal int,
        tp_Ordered int,
        tp_DisplayName nvarchar(255),
        tp_ContentTypeId varbinary(512),
        tp_PageUrl nvarchar(1024),
        tp_BaseViewId tinyint,
        tp_View ntext,
        tp_Level tinyint,
        tp_IsDefault bit,
        tp_ZoneID nvarchar(64),
        tp_IsIncluded bit,
        tp_PartOrder int,
        tp_FrameState tinyint,
        tp_Version int,
        tp_WebPartTypeId uniqueidentifier,
        tp_AllUsersProperties image,
        tp_PerUserProperties image,
        tp_UserID int,
        tp_Source ntext,
        tp_CreationTime DateTime,
        DocId uniqueidentifier,
        tp_ListRootFolderUrl nvarchar(260)
    )
    DECLARE @FullSiteExport bit
    SET @FullSiteExport = 0
    IF EXISTS(
        SELECT 1
        FROM #ExportObjects
        WHERE
            Type = 1 AND
            ParentId = '00000000-0000-0000-0000-000000000000' AND
            IncludeDescendants =
            2)
        SET @FullSiteExport = 1
    INSERT INTO @FileWebParts
    SELECT
        wp.tp_ID,
        wp.tp_ListID,
        wp.tp_Type,
        wp.tp_Flags,
        CASE
            WHEN tp_Flags & 8 <> 0 THEN 1
            ELSE 0
        END as tp_Hidden,
        CASE
            WHEN tp_Flags & 65536 <> 0 THEN 1
            ELSE 0
        END as tp_Threaded,
        CASE
            WHEN tp_Flags & 2 <> 0 THEN 1
            ELSE 0
        END as tp_FPModified,
        CASE
            WHEN tp_Flags & 32 <> 0 THEN 1
            ELSE 0
        END as tp_ReadOnly,
        CASE
            WHEN tp_Flags & 4096 <> 0 AND
            tp_Flags & 2097152 <> 0
                THEN 'Recursive'
            WHEN tp_Flags & 4096 <> 0 AND
                tp_Flags & 2097152 = 0
                THEN 'RecursiveAll'
             WHEN tp_Flags & 4096 = 0 AND
                tp_Flags & 2097152 <> 0
                THEN 'FilesOnly'
            ELSE ''
        END as tp_Scope,
        CASE
            WHEN tp_Flags & 8192 <> 0 THEN 1
            ELSE 0
        END as tp_RecurrenceRowset,
        CASE
            WHEN tp_Flags & 16384 <> 0
            THEN 'Contributor'
            WHEN tp_Flags & 32768 <> 0
            THEN 'Moderator'
            ELSE ''
        END as tp_ModerationType,
        CASE
            WHEN tp_Flags & 262144 <> 0 THEN 1
            ELSE 0
        END as tp_Personal,
        CASE
            WHEN tp_Flags & 4194304 <> 0 THEN 1
            ELSE 0
        END as tp_Ordered,
        wp.tp_DisplayName,
        wp.tp_ContentTypeId,
        '/' + CASE WHEN (DATALENGTH(d.DirName) = 0) THEN d.LeafName WHEN (DATALENGTH(d.LeafName) = 0) THEN d.DirName ELSE d.DirName + N'/' + d.LeafName END as tp_PageUrl,
        wp.tp_BaseViewId,
        wp.tp_View,
        wp.tp_Level,
        CASE
           WHEN tp_Flags & 1048576 <> 0 THEN 1
           ELSE 0
        END as tp_IsDefault,
        wp.tp_ZoneID,
        wp.tp_IsIncluded,
        wp.tp_PartOrder,
        wp.tp_FrameState,
        wp.tp_Version,
        wp.tp_WebPartTypeId,
        wp.tp_AllUsersProperties,
        wp.tp_PerUserProperties,
        wp.tp_UserID,
        wp.tp_Source,
        wp.tp_CreationTime,
        d.Id,
        NULL
    FROM (
        SELECT TOP 200
            e.DirName,
            e.LeafName
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
        WebParts wp
    ON
        wp.tp_SiteId = @SiteId AND
        (wp.tp_Flags IS NULL OR wp.tp_Flags & 262144 = 0) AND
        d.SiteId = wp.tp_SiteID AND
        d.Id = wp.tp_PageUrlID AND
        ((@VersionSetting = 1 AND wp.tp_Level = 1) OR
         (@VersionSetting <> 1 AND wp.tp_Level <> 255)) AND
        wp.tp_Deleted = 0
    IF @FullSiteExport = 0
    BEGIN
        UPDATE @FileWebParts
        SET tp_ListRootFolderUrl = '/' + CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
        FROM 
            @FileWebParts tmp
        INNER JOIN 
            Lists
        ON 
            tmp.tp_ListID = Lists.tp_ID
        INNER JOIN 
            Docs
        ON 
            Lists.tp_RootFolder = Docs.Id
    END
    -- WebParts
    SELECT * FROM @FileWebParts
    -- Personalization
    SELECT
        P.tp_WebPartID as tp_Id,
        P.tp_PageUrlID as tp_DocId,
        P.tp_UserID,
        P.tp_PartOrder,
        P.tp_ZoneID,
        P.tp_IsIncluded,
        P.tp_FrameState,
        P.tp_PerUserProperties
    FROM
        Personalization P
    INNER JOIN
        @FileWebParts FWP
    ON
        FWP.tp_Id = tp_WebPartID
    WHERE
        P.tp_SiteId = @SiteId AND
        P.tp_Deleted = 0

GO
