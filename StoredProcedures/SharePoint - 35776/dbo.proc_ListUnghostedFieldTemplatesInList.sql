/****** Object:  StoredProcedure [dbo].[proc_ListUnghostedFieldTemplatesInList]    Script Date: 5/15/2018 12:12:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_ListUnghostedFieldTemplatesInList(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        CAST(c.ContentTypeId AS uniqueidentifier),
        c.Definition
    FROM
        ContentTypes AS c
    JOIN
        ContentTypeUsage AS u WITH(NOLOCK)
    ON
        c.SiteId = u.SiteId AND
        c.ContentTypeId = u.ContentTypeId AND
        u.WebId = @WebId AND
        u.ListId = @ListId AND
        u.IsFieldId = 0
    WHERE
        c.SiteId = @SiteId AND
        c.Class = 0 AND
        c.Definition IS NOT null

GO
