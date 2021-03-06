/****** Object:  StoredProcedure [dbo].[proc_IsContentTypeGhosted]    Script Date: 5/15/2018 12:12:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_IsContentTypeGhosted(
    @SiteId uniqueidentifier,
    @ContentTypeId tContentTypeId)
AS
    SET NOCOUNT ON
    SELECT
        CASE
            WHEN Definition IS NULL THEN 1
            ELSE 0
        END
    FROM
        ContentTypes
    WHERE
        SiteId = @SiteId AND
        ContentTypeId = @ContentTypeId

GO
