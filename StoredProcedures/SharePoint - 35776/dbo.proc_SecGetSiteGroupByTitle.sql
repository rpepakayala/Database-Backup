/****** Object:  StoredProcedure [dbo].[proc_SecGetSiteGroupByTitle]    Script Date: 5/15/2018 12:12:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetSiteGroupByTitle(
    @SiteId uniqueidentifier,
    @Title  nvarchar(255))
AS
    SET NOCOUNT ON
    SELECT
        V.*
    FROM
        Sec_SiteGroupsView V
    WHERE
        SiteId = @SiteId AND
        Title = @Title

GO
