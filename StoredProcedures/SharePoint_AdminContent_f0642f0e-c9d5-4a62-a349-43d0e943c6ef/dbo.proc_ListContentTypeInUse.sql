/****** Object:  StoredProcedure [dbo].[proc_ListContentTypeInUse]    Script Date: 5/15/2018 12:12:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_ListContentTypeInUse(
    @SiteId uniqueidentifier,
    @ContentTypeId tContentTypeId)
AS
    SET NOCOUNT ON
    SELECT
        ContentTypeId, Scope
    FROM
        ContentTypes
    WHERE
        SiteId = @SiteId AND
        Class = 1 AND
        ContentTypeId > @ContentTypeId AND
        ContentTypeId <= (@ContentTypeId + 0xff)
    SELECT
        cu.ContentTypeId,
        CASE WHEN (DATALENGTH(d.DirName) = 0) THEN d.LeafName WHEN (DATALENGTH(d.LeafName) = 0) THEN d.DirName ELSE d.DirName + N'/' + d.LeafName END
    FROM
        ContentTypeUsage AS cu
    JOIN
        Webs AS w
    ON
        cu.SiteId = w.SiteId
    JOIN
        Lists AS l
    ON
        l.tp_WebId = w.Id AND
        l.tp_ID = cu.ListId
    JOIN
        Docs AS d
    ON
        d.ID = l.tp_RootFolder
    WHERE
        cu.SiteId = @SiteId AND
        cu.ContentTypeId >= @ContentTypeId AND
        cu.ContentTypeId <= (@ContentTypeId + 0xff) AND
        cu.IsFieldId = 0 AND
        cu.Class = 1

GO
