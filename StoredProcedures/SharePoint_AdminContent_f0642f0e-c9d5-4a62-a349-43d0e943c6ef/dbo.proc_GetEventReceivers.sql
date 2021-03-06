/****** Object:  StoredProcedure [dbo].[proc_GetEventReceivers]    Script Date: 5/15/2018 12:12:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetEventReceivers(
    @SiteId uniqueidentifier,
    @WebId  uniqueidentifier,
    @HostId uniqueidentifier,
    @HostType int)
AS
    SET NOCOUNT ON
    IF @HostType IS NULL
    BEGIN    
        SELECT
            Id, Name, SiteId, WebId, HostId, HostType, ItemId, DirName, LeafName, Type, SequenceNumber, Assembly, Class, Data, Filter, SourceId, SourceType, Credential, ContextType, ContextEventType, ContextId, ContextObjectId, ContextCollectionId
        FROM
            EventReceivers
        WHERE
            SiteId = @SiteId AND
            WebId = @WebId AND
            HostId = @HostId
        ORDER BY
            SiteId, WebId, HostId, Type, HostType, SequenceNumber, Assembly
    END
    ELSE
    BEGIN
        SELECT
            Id, Name, SiteId, WebId, HostId, HostType, ItemId, DirName, LeafName, Type, SequenceNumber, Assembly, Class, Data, Filter, SourceId, SourceType, Credential, ContextType, ContextEventType, ContextId, ContextObjectId, ContextCollectionId
        FROM
            EventReceivers
        WHERE
            SiteId = @SiteId AND
            WebId = @WebId AND
            HostId = @HostId AND
            HostType = @HostType
        ORDER BY
            SiteId, WebId, HostId, Type, HostType, SequenceNumber, Assembly
    END

GO
