/****** Object:  StoredProcedure [dbo].[proc_getSiteMapById]    Script Date: 5/15/2018 12:13:06 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_getSiteMapById
(   
    @SiteId uniqueidentifier
) AS
    SET NOCOUNT ON
    SELECT TOP 1
        ApplicationId,
        DatabaseId,
	Id,
        Path,
        RedirectUrl,
        Pairing,
	HostHeaderIsSiteName
    FROM
        SiteMap
    WHERE
        Id = @SiteId
    ORDER BY
	Version ASC

GO
