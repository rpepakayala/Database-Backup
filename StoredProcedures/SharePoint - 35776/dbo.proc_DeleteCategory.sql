/****** Object:  StoredProcedure [dbo].[proc_DeleteCategory]    Script Date: 5/15/2018 12:11:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteCategory(
    @SiteId uniqueidentifier,
    @WebDirName nvarchar(256),
    @WebLeafName nvarchar(128),
    @Category nvarchar(128))
AS
    SET NOCOUNT ON
    DELETE
        WebCat
    FROM
        WebCat INNER JOIN Docs
    ON
        WebCat.WebId = Docs.WebId
        INNER JOIN Sites WITh (NOLOCK)
    ON
        Sites.Id = Docs.SiteId
    WHERE
        Docs.DirName = @WebDirName AND
        Docs.LeafName = @WebLeafName AND
        Sites.Id = @SiteId AND
        WebCat.Category = @Category
    RETURN 0

GO
