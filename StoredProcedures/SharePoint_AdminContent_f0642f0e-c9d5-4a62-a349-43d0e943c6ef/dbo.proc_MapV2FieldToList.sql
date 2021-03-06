/****** Object:  StoredProcedure [dbo].[proc_MapV2FieldToList]    Script Date: 5/15/2018 12:12:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_MapV2FieldToList(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @ContentTypeId tContentTypeId)
AS
    SET NOCOUNT ON
    IF NOT EXISTS (SELECT * FROM ContentTypeUsage WHERE (
        SiteId = @SiteId AND
        Class = 0 AND        
        WebId = @WebId AND
        ListId = @ListId AND
        ContentTypeId = @ContentTypeId))
    BEGIN
        INSERT
            ContentTypeUsage
        VALUES
            (@SiteId, @ContentTypeId, @WebId, @ListId, 0, 0)
    END            

GO
