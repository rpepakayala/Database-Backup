/****** Object:  StoredProcedure [dbo].[proc_GetSiteFlags]    Script Date: 5/15/2018 12:12:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetSiteFlags (
    @WebSiteId uniqueidentifier
)
AS
    SET NOCOUNT ON
    DECLARE @SiteFlags int
    DECLARE @SiteNextUserOrGroupId int
    SELECT 
       @SiteFlags = Sites.BitFlags,
       @SiteNextUserOrGroupId = Sites.NextUserOrGroupId
    FROM
       Sites
    WHERE
       Id = @WebSiteId
    IF (@SiteNextUserOrGroupId IS NOT NULL AND
        @SiteNextUserOrGroupId > 1000)
    BEGIN
       SET @SiteFlags = @SiteFlags | 4096
    END
    SELECT
       @SiteFlags
    RETURN 0

GO
