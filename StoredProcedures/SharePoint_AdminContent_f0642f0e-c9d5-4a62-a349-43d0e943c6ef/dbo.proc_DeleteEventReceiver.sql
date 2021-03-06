/****** Object:  StoredProcedure [dbo].[proc_DeleteEventReceiver]    Script Date: 5/15/2018 12:12:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteEventReceiver(
    @Id uniqueidentifier,
    @Name nvarchar(256),
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @HostId uniqueidentifier,
    @HostType int,
    @ItemId int,                                
    @DirName nvarchar(256),     
    @LeafName nvarchar(128),   
    @Type int,
    @SequenceNumber int,
    @Assembly nvarchar(256),
    @Class nvarchar(256),
    @Data nvarchar(256),
    @Filter nvarchar(256),
    @SourceId tContentTypeId,
    @SourceType int,
    @Credential int,
    @ContextType uniqueidentifier,
    @ContextEventType uniqueidentifier,
    @ContextId uniqueidentifier,
    @ContextObjectId uniqueidentifier,
    @ContextCollectionId uniqueidentifier)
AS
    DECLARE @RC int
    SET @RC = 0
    DELETE FROM
        EventReceivers
    WHERE
        SiteId = @SiteId AND
        Id = @Id AND
        Type != 32767
    IF @@ROWCOUNT <> 1
        SET @RC = 87
    ELSE
    BEGIN
        IF @ContextObjectId IS NOT NULL
            AND EXISTS (SELECT TOP 1
                        *
                    FROM
                        EventReceivers WITH (XLOCK)
                    WHERE
                        SiteId = @SiteId AND
                        ContextCollectionId = @ContextObjectId AND
                        Type = 32767)
            AND NOT EXISTS (SELECT TOP 1
                        *
                    FROM
                        EventReceivers WITH (NOLOCK)
                    WHERE
                        SiteId = @SiteId AND
                        ContextObjectId = @ContextObjectId)
        BEGIN
            DELETE FROM
                EventReceivers
            WHERE
                SiteId = @SiteId AND
                ContextCollectionId = @ContextObjectId AND
                Type = 32767
        END
    END
    RETURN @RC

GO
