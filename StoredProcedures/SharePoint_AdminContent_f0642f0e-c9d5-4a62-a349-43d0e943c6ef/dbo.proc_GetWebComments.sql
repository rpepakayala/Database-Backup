/****** Object:  StoredProcedure [dbo].[proc_GetWebComments]    Script Date: 5/15/2018 12:12:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetWebComments(
    @SiteId         uniqueidentifier,
    @WebId          uniqueidentifier)
AS
    SET NOCOUNT ON
    IF @SiteId IS NULL OR @WebId IS NULL
    BEGIN
        RETURN 3
    END
    SELECT
        CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END,
        ComMd.Id,
        ComMd.ParentId,
        ComMd.CommentId,
        ComMd.Bookmark,
        ComMd.Author,
        ComMd.UserId,
        ComMd.Subject,
        ComMd.Created,
        ComMd.Status,
        ComMd.Comment
    FROM
        ComMd INNER JOIN Docs
    ON
        ComMd.SiteID = Docs.SiteID AND
        ComMd.DocID  = Docs.ID
    WHERE
        ComMd.SiteID = @SiteID AND
        Docs.WebID   = @WebID
    ORDER BY
        ComMd.SiteId,
        ComMd.DocId,
        ComMd.Id
    RETURN 0

GO
