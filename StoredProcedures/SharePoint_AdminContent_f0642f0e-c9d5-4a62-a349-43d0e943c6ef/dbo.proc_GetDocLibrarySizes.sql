/****** Object:  StoredProcedure [dbo].[proc_GetDocLibrarySizes]    Script Date: 5/15/2018 12:12:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetDocLibrarySizes(@SiteId uniqueidentifier) AS 
    SET NOCOUNT ON
SELECT 
ISNULL(DocSizes,0) + ISNULL(VerSizes,0) + ISNULL(PersonSizes,0) + ISNULL(WpSizes,0) As TotalSize, 
nLists.tp_ID,
nLists.tp_WebID,
nLists.tp_Modified,
nLists.tp_ServerTemplate,
nLists.DirName,
nLists.LeafName,
nLists.tp_ImageUrl,
nLists.tp_Title,
nLists.tp_ItemCount,
Webs.WebTemplate,
Webs.Language,
Webs.FullUrl
FROM
Webs
INNER JOIN
    (SELECT 
    Lists.tp_ItemCount, 
    Lists.tp_Title, 
    Lists.tp_Id, 
    Lists.tp_WebID, 
    Lists.tp_Modified, 
    Lists.tp_ServerTemplate, 
    Docs.DirName, 
    Docs.LeafName, 
    Lists.tp_ImageUrl 
    FROM 
    Lists 
    INNER JOIN 
        Docs 
        ON 
        Lists.tp_RootFolder = Docs.Id AND 
        Lists.tp_WebId = Docs.WebId 
    WHERE   tp_BaseType = 1 AND
        SiteId = @SiteId) As nLists
    ON
    Webs.Id = nLists.tp_WebId
    LEFT OUTER JOIN
        (SELECT
            vq.VerSize As Versizes,
            dq.DocSize As DocSizes,
            dq.ListId As ListId
        FROM
            (SELECT
                (SUM(CAST((ISNULL(Docs.Size, 0)) AS BIGINT))) AS DocSize,
                Docs.ListId AS ListId
            FROM
                Docs
            WHERE
                Docs.SiteId = @SiteId AND
                Docs.Type = 0
            GROUP BY
                Docs.ListId
            ) AS dq
        LEFT OUTER JOIN
            (SELECT
                (SUM(CAST((ISNULL(DocVersions.Size, 0)) AS BIGINT))) AS VerSize,
                Docs.ListId AS ListId
            FROM
                DocVersions
            INNER JOIN
                Docs
            ON
                Docs.SiteId = @SiteId AND
                Docs.Id = DocVersions.Id AND
                DocVersions.SiteId = @SiteId
            GROUP BY
                Docs.ListId
            ) AS vq
        ON
            vq.ListId = dq.ListId
        ) AS DocsInList
        ON
        DocsInList.ListId = nLists.tp_ID
        LEFT OUTER JOIN
            (SELECT 
            (SUM(CAST((ISNULL(Personalization.tp_Size,0)) AS BIGINT)))
                As PersonSizes, 
            (SUM(CAST((ISNULL(WebParts.tp_Size,0)) AS BIGINT))) As WpSizes,
            WebParts.tp_ListId 
            FROM 
            WebParts 
            LEFT OUTER JOIN 
                Personalization 
                ON 
                Personalization.tp_WebPartId = WebParts.tp_ID 
            GROUP BY WebParts.tp_ListId) As WebPartsInList
            ON
            DocsInList.ListId = WebPartsInList.tp_ListId

GO
