/****** Object:  StoredProcedure [dbo].[proc_CountContentTypeInUse]    Script Date: 5/15/2018 12:11:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_CountContentTypeInUse(
    @SiteId uniqueidentifier,
    @ContentTypeId tContentTypeId)
AS
    SET NOCOUNT ON    
    DECLARE @cUsage int
    DECLARE @cListUsage int
    DECLARE @cFieldUsage int
    DECLARE @fieldId uniqueidentifier
    SELECT
        @cUsage = COUNT(*)
    FROM
        ContentTypes
    WHERE
        SiteId = @SiteId AND
        ContentTypeId > @ContentTypeId AND
        ContentTypeId <= (@ContentTypeId + 0xff)
    SET @cUsage = ISNULL(@cUsage, 0)
    SELECT
        @cListUsage = COUNT(*) 
    FROM
        ContentTypeUsage
    JOIN
        Lists
    ON
        Lists.tp_WebID = ContentTypeUsage.WebId AND
        Lists.tp_ID = ContentTypeUsage.ListId
    WHERE
        SiteId = @SiteId AND
        ContentTypeId >= @ContentTypeId AND
        ContentTypeId <= (@ContentTypeId + 0xff) AND
        IsFieldId = 0
    SET @cFieldUsage = 0
    IF DATALENGTH(@ContentTypeId) = 16
    BEGIN
        SET @fieldId = CAST(@ContentTypeId AS uniqueidentifier)
        SELECT
            @cFieldUsage = COUNT(*)
        FROM
            ContentTypeUsage
        WHERE
            SiteId = @SiteId AND
            ListId = @fieldId AND
            IsFieldId = 1
    END
    RETURN ISNULL(@cUsage, 0) + ISNULL(@cListUsage, 0) + ISNULL(@cFieldUsage, 0);

GO
