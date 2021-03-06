/****** Object:  StoredProcedure [dbo].[proc_ListDerivedContentTypes]    Script Date: 5/15/2018 12:12:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_ListDerivedContentTypes(
    @SiteId uniqueidentifier,
    @ContentTypeId tContentTypeId)
AS
    SET NOCOUNT ON
    SELECT
        ContentTypeId,
        Scope,
        Definition,
        NextChildByte,
        Version,
        ResourceDir
    FROM
        ContentTypes
    WHERE
        SiteId = @SiteId AND
        ContentTypeId > @ContentTypeId AND
        ContentTypeId <= (@ContentTypeId + 0xff) AND
        Class = 1
    SELECT
        ContentTypeId,
        WebId,
        ListId
    FROM
        ContentTypeUsage
    WHERE
        SiteId = @SiteId AND
        ContentTypeId >= @ContentTypeId AND
        ContentTypeId <= (@ContentTypeId + 0xff) AND
        IsFieldId = 0
    ORDER BY
        WebId,
        ListId

GO
