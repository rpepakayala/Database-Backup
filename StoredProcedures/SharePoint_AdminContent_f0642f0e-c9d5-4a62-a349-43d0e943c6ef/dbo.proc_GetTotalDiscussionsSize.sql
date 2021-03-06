/****** Object:  StoredProcedure [dbo].[proc_GetTotalDiscussionsSize]    Script Date: 5/15/2018 12:12:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetTotalDiscussionsSize(
    @SiteId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        ISNULL((SUM(CAST((Size) AS BIGINT))), 0)
    FROM
        ComMd
    WHERE
        SiteId = @SiteId
    RETURN 0

GO
