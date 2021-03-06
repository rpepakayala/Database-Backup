/****** Object:  StoredProcedure [dbo].[proc_DeplGetListItemMvlVersionsFields]    Script Date: 5/15/2018 12:12:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetListItemMvlVersionsFields(
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
       SET @VersionTable = N' UserDataJunctionsVersioned '
    END
    ELSE
    BEGIN
       SET @VersionTable = N' UserDataJunctions'
    END
    SET @SelectSql = N'
SELECT
    E.Id AS Id,
    Docs.Id AS DocId,
    UD.tp_FieldId,
    UD.tp_ID AS IntId,
    UD.tp_UIVersion,
    UD.tp_Level,
    UD.tp_Ordinal
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
    UD.tp_SiteId = @SiteId AND
    UD.tp_Level <> 255
LEFT JOIN Docs ON
    Docs.SiteId = @SiteId AND
    UD.tp_Level = Docs.Level AND
    UD.tp_DirName = Docs.DirName AND
    UD.tp_LeafName = Docs.LeafName
ORDER BY
    E.Ordinal, UD.tp_FieldId, UD.tp_Ordinal ASC
'
    EXEC sp_executesql @SelectSql, N'@LastOrdinal int, @SiteId uniqueidentifier, @ListId uniqueidentifier, @VersionSetting int', @LastOrdinal, @SiteId, @ListId, @VersionSetting

GO
