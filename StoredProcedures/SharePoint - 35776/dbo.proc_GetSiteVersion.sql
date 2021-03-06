/****** Object:  StoredProcedure [dbo].[proc_GetSiteVersion]    Script Date: 5/15/2018 12:12:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetSiteVersion(
    @SiteId uniqueidentifier,
    @VersionId uniqueidentifier,
    @Version nvarchar(64) output
    )
AS
    SET NOCOUNT ON
    SELECT
        @Version = Version
    FROM
        SiteVersions
    WHERE
        SiteId = @SiteId
    AND
        VersionId = @VersionId

GO
