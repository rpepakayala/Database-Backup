/****** Object:  StoredProcedure [dbo].[proc_getSiteNames]    Script Date: 5/15/2018 12:13:06 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_getSiteNames
(
    @ContainerId uniqueidentifier,
    @ContainerType int,
    @CollectionType int
) AS
    SET NOCOUNT ON
    IF @CollectionType = 0
    BEGIN
        SELECT
            Path
        FROM
            SiteMap
        WHERE
            (@ContainerType = 0 AND
            ApplicationId = @ContainerId) OR
            (@ContainerType = 1 AND
            DatabaseId = @ContainerId)
        ORDER BY
            Path
    END
    ELSE IF @CollectionType = 1
    BEGIN
        SELECT
            Path
        FROM
            SiteMap
        WHERE
            ((@ContainerType = 0 AND
            ApplicationId = @ContainerId) OR
            (@ContainerType = 1 AND
            DatabaseId = @ContainerId)) AND
            RedirectUrl IS NOT NULL
        ORDER BY
            Path
    END
    ELSE IF @CollectionType = 2
    BEGIN
        SELECT
            Path
        FROM
            SiteMap
        WHERE
            ((@ContainerType = 0 AND
            ApplicationId = @ContainerId) OR
            (@ContainerType = 1 AND
            DatabaseId = @ContainerId)) AND
            RedirectUrl IS NULL
        ORDER BY
            Path
    END

GO
