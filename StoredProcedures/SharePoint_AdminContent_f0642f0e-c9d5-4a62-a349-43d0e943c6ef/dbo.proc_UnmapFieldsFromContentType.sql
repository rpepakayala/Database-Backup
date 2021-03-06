/****** Object:  StoredProcedure [dbo].[proc_UnmapFieldsFromContentType]    Script Date: 5/15/2018 12:13:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_UnmapFieldsFromContentType(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ContentTypeId tContentTypeId)
AS
    SET NOCOUNT ON
    DELETE
        ContentTypeUsage
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        ContentTypeId = @ContentTypeId AND
        IsFieldId = 1

GO
