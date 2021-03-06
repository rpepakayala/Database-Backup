/****** Object:  StoredProcedure [dbo].[proc_getSiteBestMatch]    Script Date: 5/15/2018 12:13:06 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_getSiteBestMatch
(   
    @DatabaseId uniqueidentifier = NULL,
    @ApplicationId uniqueidentifier = NULL,
    @PathSearch nvarchar(128),
    @BestMatchOffsetScope int = 0,
    @CollectionType int,
    @BestMatchSiteId uniqueidentifier output,
    @BestMatchDatabaseId uniqueidentifier output,
    @BestMatchApplicationId uniqueidentifier output,
    @BestMatchOffset int output
) AS
    DECLARE @BestMatchPath nvarchar(128)
    SET NOCOUNT ON
    SELECT @PathSearch = @PathSearch + '%'
    SELECT TOP 1
        @BestMatchSiteId = Id,
        @BestMatchDatabaseId = DatabaseId,
        @BestMatchApplicationId = ApplicationId,
        @BestMatchPath = Path
    FROM SiteMap WITH (NOLOCK)
    WHERE 
        (@ApplicationId IS NULL OR ApplicationId = @ApplicationId) AND
        (@DatabaseId IS NULL OR DatabaseId = @DatabaseId) AND
        (    @CollectionType = 0 OR
            (@CollectionType = 1 AND RedirectUrl IS NOT NULL) OR
            (@CollectionType = 2 AND RedirectUrl IS NULL) OR
            (@CollectionType = 3 AND RedirectUrl IS NULL AND Pairing = 1)
        ) AND
        Path LIKE @PathSearch
    ORDER BY Path
    SELECT 
        @BestMatchOffset = COUNT(*)
    FROM SiteMap
    WHERE 
        (@BestMatchOffsetScope <> 1 OR ApplicationId = @BestMatchApplicationId) AND
        (@BestMatchOffsetScope <> 2 OR DatabaseId = @BestMatchDatabaseId) AND
        (    @CollectionType = 0 OR
            (@CollectionType = 1 AND RedirectUrl IS NOT NULL) OR
            (@CollectionType = 2 AND RedirectUrl IS NULL) OR
            (@CollectionType = 3 AND RedirectUrl IS NULL AND Pairing = 1)
        ) AND
    Path < @BestMatchPath
RETURN

GO
