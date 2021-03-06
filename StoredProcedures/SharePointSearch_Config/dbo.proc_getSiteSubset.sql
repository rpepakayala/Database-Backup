/****** Object:  StoredProcedure [dbo].[proc_getSiteSubset]    Script Date: 5/15/2018 12:13:06 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_getSiteSubset
(   
    @DatabaseId uniqueidentifier = NULL,
    @ApplicationId uniqueidentifier = NULL,
    @PageSize int,
    @StartRow int,
    @SortDirection nvarchar(4),
    @CollectionType int
) AS
    SET NOCOUNT ON
    DECLARE @Id uniqueidentifier
    DECLARE @CurrentSites TABLE (
        Id uniqueidentifier NOT NULL PRIMARY KEY
    )
    IF @SortDirection = 'DESC'
        DECLARE PagingCursor CURSOR DYNAMIC READ_ONLY FOR
            SELECT Id
            FROM SiteMap
            WHERE
                (@DatabaseId IS NULL OR DatabaseId = @DatabaseId) AND
                (@ApplicationId IS NULL OR ApplicationId = @ApplicationId) AND
                (    @CollectionType = 0 OR
                    (@CollectionType = 1 AND RedirectUrl IS NOT NULL) OR
                    (@CollectionType = 2 AND RedirectUrl IS NULL) OR
                    (@CollectionType = 3 AND RedirectUrl IS NULL AND Pairing = 1)
                )
            ORDER BY Path DESC
    ELSE
        DECLARE PagingCursor CURSOR DYNAMIC READ_ONLY FOR
            SELECT Id
            FROM SiteMap
            WHERE
                (@DatabaseId IS NULL OR DatabaseId = @DatabaseId) AND
                (@ApplicationId IS NULL OR ApplicationId = @ApplicationId) AND
                (    @CollectionType = 0 OR
                    (@CollectionType = 1 AND RedirectUrl IS NOT NULL) OR
                    (@CollectionType = 2 AND RedirectUrl IS NULL) OR
                    (@CollectionType = 3 AND RedirectUrl IS NULL AND Pairing = 1)
                )
            ORDER BY Path ASC
    OPEN PagingCursor
        FETCH RELATIVE @StartRow
        FROM PagingCursor INTO @Id
    WHILE @PageSize > 0 AND @@FETCH_STATUS = 0
    BEGIN
        INSERT @CurrentSites(Id) VALUES(@Id)
        FETCH NEXT FROM PagingCursor INTO @Id
        SET @PageSize = @PageSize - 1
    END
    CLOSE PagingCursor
    DEALLOCATE PagingCursor
    IF @SortDirection = 'DESC'
        SELECT
            SiteMap.Id,
            SiteMap.Path
        FROM SiteMap JOIN @CurrentSites CS
            ON SiteMap.Id = CS.Id 
            ORDER BY Path DESC
    ELSE
        SELECT
            SiteMap.Id,
            SiteMap.Path
        FROM SiteMap JOIN @CurrentSites CS
            ON SiteMap.Id = CS.Id 
            ORDER BY Path ASC

GO
