/****** Object:  StoredProcedure [dbo].[proc_GetSiteUsage]    Script Date: 5/15/2018 12:12:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetSiteUsage (
    @WebSiteId uniqueidentifier
)
AS
    SET NOCOUNT ON
    SELECT 
        DiskUsed,
        BWUsed
    FROM
        Sites
    WHERE
        Id = @WebSiteId
    RETURN 0

GO
