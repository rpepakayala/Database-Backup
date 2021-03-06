/****** Object:  StoredProcedure [dbo].[proc_DeplGetListItemVersionsFields]    Script Date: 5/15/2018 12:12:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetListItemVersionsFields(
    @LastOrdinal int,
    @VersionSetting int,
    @SiteId uniqueidentifier,
    @ListId uniqueidentifier,
    @Columns nvarchar(1700))
AS
    SET NOCOUNT ON
    DECLARE @SelectSql nvarchar(4000)
    DECLARE @VersionTable nvarchar(20)
    IF (@VersionSetting = 4)
    BEGIN
        SET @VersionTable = N' UserDataVersioned '
    END
    ELSE
    BEGIN
        SET @VersionTable = N' UserData '
    END
    SET @SelectSql = N'
SELECT
    E.Id AS Id,
    UD.tp_ID AS IntId,
    Docs.Id AS DocId,
    UD.tp_UIVersion,
    UD.tp_UIVersionString,
    UD.tp_RowOrdinal, ' + @Columns + N'
    UD.tp_Level
FROM ' + @VersionTable + N' UD
INNER JOIN
    (SELECT TOP 200
        E2.Id,
        E2.DirName,
        E2.LeafName,
        E2.Ordinal
     FROM #ExportObjects E2
     WHERE
        E2.Ordinal > @LastOrdinal AND
        E2.Type = 4 AND
        E2.ParentId = @ListId AND
        E2.IsDeleted = 0
     ORDER BY E2.Ordinal ) AS E
ON
    E.DirName = UD.tp_DirName AND
    E.LeafName = UD.tp_LeafName AND
    UD.tp_ListId = @ListId AND
    UD.tp_SiteId = @SiteId AND
    UD.tp_Level <> 255
LEFT JOIN Docs ON
    Docs.SiteId = @SiteId AND
    UD.tp_ID = Docs.DocLibRowId AND
    UD.tp_ListId = Docs.ListId AND
    UD.tp_Level = Docs.Level AND
    UD.tp_DirName = Docs.DirName AND
    UD.tp_LeafName = Docs.LeafName
ORDER BY
    E.Ordinal, UD.tp_UIVersion ASC
'
    EXEC sp_executesql @SelectSql, N'@LastOrdinal int, @SiteId uniqueidentifier, @ListId uniqueidentifier, @VersionSetting int', @LastOrdinal, @SiteId, @ListId, @VersionSetting

GO
