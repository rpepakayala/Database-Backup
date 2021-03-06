/****** Object:  StoredProcedure [dbo].[proc_SetSiteQuota]    Script Date: 5/15/2018 12:13:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SetSiteQuota(
    @WebSiteId uniqueidentifier,
    @quotaId smallint,
    @diskQuota bigint,
    @diskWarning bigint,
    @userQuota int)
AS
    SET NOCOUNT ON
    UPDATE
        Sites
    SET 
        QuotaTemplateID = @quotaId,
        DiskQuota       = @diskQuota,
        DiskWarning     = @diskWarning,
        UserQuota       = @userQuota
    WHERE
        Id = @WebSiteId
    EXEC proc_LogChange @WebSiteId, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        8192,  8, NULL
    RETURN 0

GO
