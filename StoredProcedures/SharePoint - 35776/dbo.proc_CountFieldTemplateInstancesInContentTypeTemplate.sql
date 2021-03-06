/****** Object:  StoredProcedure [dbo].[proc_CountFieldTemplateInstancesInContentTypeTemplate]    Script Date: 5/15/2018 12:11:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CountFieldTemplateInstancesInContentTypeTemplate(
    @SiteId uniqueidentifier,
    @FieldId uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @Count int
    SELECT
        @Count = COUNT(*)
    FROM
        FieldUsage U
    WHERE
        SiteId = @SiteId AND
        FieldId = @FieldId AND
        ContentTypeId IN (
            SELECT
                ContentTypeId
            FROM
                ContentTypes CT
            WHERE
                SiteId = @SiteId AND
                Class = 1)
    RETURN @Count

GO
