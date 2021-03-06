/****** Object:  StoredProcedure [dbo].[proc_DeleteEventReceiversBySourceId]    Script Date: 5/15/2018 12:12:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteEventReceiversBySourceId(
    @SourceId tContentTypeId,
    @SourceType int,
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @HostId uniqueidentifier)
AS
    SET NOCOUNT ON
    DELETE FROM
        EventReceivers
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        HostId = @HostId AND
        SourceId = @SourceId AND
        SourceType = @SourceType

GO
