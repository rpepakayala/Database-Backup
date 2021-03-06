/****** Object:  StoredProcedure [dbo].[proc_CopyEventReceivers]    Script Date: 5/15/2018 12:11:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CopyEventReceivers(
    @SiteId    uniqueidentifier,
    @WebId     uniqueidentifier,
    @OldHostId uniqueidentifier,
    @NewHostId uniqueidentifier)
AS
    SET NOCOUNT ON
    INSERT INTO EventReceivers
        (Id, HostId, Name, SiteId, WebId, HostType, ItemId, DirName, LeafName, Type, SequenceNumber, Assembly, Class, Data, Filter, SourceId, SourceType, Credential, ContextType, ContextEventType, ContextId, ContextObjectId, ContextCollectionId)
    SELECT
        NEWID(),
        @NewHostId,
        Name, SiteId, WebId, HostType, ItemId, DirName, LeafName, Type, SequenceNumber, Assembly, Class, Data, Filter, SourceId, SourceType, Credential, ContextType, ContextEventType, ContextId, ContextObjectId, ContextCollectionId
    FROM
        EventReceivers
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        HostId = @OldHostId

GO
