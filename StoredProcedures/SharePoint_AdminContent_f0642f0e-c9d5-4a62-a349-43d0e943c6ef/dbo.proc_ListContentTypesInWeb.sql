/****** Object:  StoredProcedure [dbo].[proc_ListContentTypesInWeb]    Script Date: 5/15/2018 12:12:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_ListContentTypesInWeb(
    @SiteId uniqueidentifier,
    @Class tinyint,
    @Scope nvarchar(256))
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
        Class = @Class AND
        Scope = @Scope
    ORDER BY
        ContentTypeId

GO
