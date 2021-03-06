/****** Object:  StoredProcedure [dbo].[proc_SetDeadWebNotificationCount]    Script Date: 5/15/2018 12:13:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SetDeadWebNotificationCount(
    @SiteId uniqueidentifier,
    @NotifyCount smallint)
AS
    SET NOCOUNT ON
    UPDATE
        Sites
    SET
        DeadWebNotifyCount = @NotifyCount
    WHERE
        Id = @SiteId
    EXEC proc_LogChange @SiteId, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, 8192,  8, NULL
    RETURN 0             

GO
