/****** Object:  StoredProcedure [dbo].[proc_DeplGetListItemAttachments]    Script Date: 5/15/2018 12:12:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE Procedure dbo.proc_DeplGetListItemAttachments(
    @LastOrdinal int,
    @SiteId uniqueidentifier,
    @ListId uniqueidentifier)
AS
    SET NOCOUNT ON
    -- Get list root url
    DECLARE @ListRootUrl nvarchar(260)
    SELECT @ListRootUrl = CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
    FROM Docs, Lists
    WHERE
        Lists.tp_ID         = @ListID AND
        Lists.tp_RootFolder = Docs.Id
    IF @ListRootUrl IS NOT NULL
    BEGIN
    SELECT
        E.Id as ListItemId,
        Docs.Id as DocId,
        Docs.WebId,  -- Same as E.ParentWebId
        Docs.ListId, -- Same as E.ParentId in this case
        Docs.ScopeId,
        Docs.MetaInfo,
        Docs.TimeCreated,
        Docs.TimeLastModified,
        Docs.Size,
        Docs.DirName,
        Docs.LeafName,
        Docs.DirName + '/' + Docs.LeafName AS Url
    FROM UserData UD
    INNER JOIN
        (SELECT TOP 200
            E2.Id,
            E2.ParentId,
            E2.FullUrl,
            E2.Ordinal,
            E2.DirName,
            E2.LeafName
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
        UD.tp_ListId = @ListId
    INNER JOIN Docs
    ON
        Docs.DirName = @ListRootUrl + '/' + N'Attachments' + '/' + CONVERT(nvarchar(10), UD.tp_ID)
    WHERE
        Docs.Level = 1 AND
        Docs.SiteId = @SiteId AND
        Docs.ListId = E.ParentId AND
        UD.tp_SiteId = @SiteId AND
        UD.tp_RowOrdinal = 0 AND
        UD.tp_Level <> 255 AND
        UD.tp_HasAttachment = 1
    ORDER BY E.Ordinal
    END
    ELSE
    BEGIN
        SELECT TOP 0
            Docs.Id, -- Bogus value
            Docs.Id as DocId,
            Docs.WebId,
            Docs.ListId,
            Docs.ScopeId,
            Docs.MetaInfo,
            Docs.TimeCreated,
            Docs.TimeLastModified,
            Docs.Size,
            Docs.DirName,
            Docs.LeafName,
            Docs.DirName + '/' + Docs.LeafName AS Url
        FROM Docs
    END

GO
