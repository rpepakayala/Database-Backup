/****** Object:  StoredProcedure [dbo].[proc_ListDocsInCategory]    Script Date: 5/15/2018 12:12:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ListDocsInCategory(
    @SiteId uniqueidentifier,
    @WebDirName nvarchar(256),
    @WebLeafName nvarchar(128),
    @Category nvarchar(128),
    @FullMetaInfo bit)
AS
    SET NOCOUNT ON
    DECLARE @WebId uniqueidentifier
    SELECT
        @WebId = Docs.WebId
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @WebDirName AND
        LeafName = @WebLeafName AND
        Type = 2
    IF @WebId IS NULL
    BEGIN
        RETURN 3
    END
    IF @FullMetaInfo = 1
    BEGIN
        SELECT
            Docs.DirName,
            Docs.LeafName,
            Docs.TimeLastModified,
            Docs.MetaInfo
        FROM
            WebCat INNER JOIN Categories
        ON
            Categories.CategoryId = WebCat.CategoryId
            INNER JOIN Docs
        ON
            Docs.Id = Categories.DocId AND
            Docs.Level = 1
        WHERE
            (WebCat.WebId = @WebId AND
                WebCat.Category = @Category)
    END
    ELSE
    BEGIN
        SELECT
            Docs.DirName,
            Docs.LeafName
        FROM
            WebCat INNER JOIN Categories
        ON
            Categories.CategoryId = WebCat.CategoryId
            INNER JOIN Docs
        ON
            Docs.Id = Categories.DocId AND
            Docs.Level = 1
        WHERE
            (WebCat.WebId = @WebId AND
                WebCat.Category = @Category)
    END
    RETURN 0

GO
