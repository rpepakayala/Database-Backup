/****** Object:  StoredProcedure [dbo].[proc_GetSiteQuota]    Script Date: 5/15/2018 12:12:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetSiteQuota (
    @WebSiteId uniqueidentifier
)
AS
    SET NOCOUNT ON
    SELECT 
        QuotaTemplateID,
        DiskQuota,
        DiskWarning,
        UserQuota
    FROM
        Sites
    WHERE
        Id = @WebSiteId
    RETURN 0

GO
