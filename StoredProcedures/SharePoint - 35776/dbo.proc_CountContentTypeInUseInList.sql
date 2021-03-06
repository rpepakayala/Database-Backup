/****** Object:  StoredProcedure [dbo].[proc_CountContentTypeInUseInList]    Script Date: 5/15/2018 12:11:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_CountContentTypeInUseInList(
    @SiteId uniqueidentifier,
    @ListId uniqueidentifier,
    @ContentTypeId tContentTypeId)
AS
    SET NOCOUNT ON
    DECLARE @cUsage int
    SELECT
        @cUsage = COUNT(*)
    FROM
        UserData
    WHERE
        @SiteId = tp_SiteId AND
        @ListId = tp_ListId AND
        @ContentTypeId = tp_ContentTypeId
    RETURN @cUsage

GO
