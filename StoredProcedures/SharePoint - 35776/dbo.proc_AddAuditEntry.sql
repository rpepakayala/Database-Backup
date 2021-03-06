/****** Object:  StoredProcedure [dbo].[proc_AddAuditEntry]    Script Date: 5/15/2018 12:11:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddAuditEntry(
    @SiteId             uniqueidentifier,
    @ItemId             uniqueidentifier,
    @ItemType           smallint,
    @UserId             int,
    @MachineName        nvarchar(128) = NULL,
    @MachineIp          nvarchar(20) = NULL,
    @Location           nvarchar(260) = NULL,
    @LocationType       tinyint = NULL,
    @Occurred           datetime,
    @Event              int,
    @EventName          nvarchar(128) = NULL,
    @EventSource        tinyint,
    @SourceName         nvarchar(256) = NULL,
    @EventData          ntext = NULL)
AS
    SET NOCOUNT ON
    DECLARE @ActualItemType   smallint
    SET @ActualItemType = @ItemType
    IF (@ActualItemType = 1)
    BEGIN
        DECLARE @DocStoreType     int
        DECLARE @DocDirName        nvarchar(256)
        DECLARE @DocLeafName       nvarchar(256)
        EXEC proc_SplitUrl @Location, @DocDirName OUTPUT, @DocLeafName OUTPUT
        SELECT TOP 1
            @DocStoreType = Type
        FROM 
            Docs
        WHERE
            @SiteId = Docs.SiteId AND
            @DocDirName = Docs.DirName AND
            @DocLeafName = Docs.LeafName
        IF (@DocStoreType = 1)
            SET @ActualItemType = 5
    END
    INSERT INTO AuditData (
        SiteId,
        ItemId,
        ItemType,
        UserId,
        MachineName,
        MachineIp,
        DocLocation,
        LocationType,
        Occurred,
        Event,
        EventName,
        EventSource,
        SourceName,
        EventData)
    VALUES (
        @SiteId,
        @ItemId,
        @ItemType,
        @UserId,
        @MachineName,
        @MachineIp,
        @Location,
        @LocationType,
        @Occurred,
        @Event,
        @EventName,
        @EventSource,
        @SourceName,
        @EventData)
     IF ((@Event = 4) AND 
         (@EventSource = 0) AND 
         (@ItemType <> 7))
     BEGIN
        DECLARE @NewItemType    smallint
        DECLARE @DirName        nvarchar(256)
        DECLARE @LeafName       nvarchar(128)
        DECLARE @NewDirName     nvarchar(256)
        DECLARE @NewLeafName    nvarchar(128)
        DECLARE @NewEventData   nvarchar(4000)
        EXEC proc_SplitUrl @Location, @DirName OUTPUT, @LeafName OUTPUT
        EXEC proc_GetParent 
            @ItemType, 
            @SiteId, 
            @DirName, 
            @LeafName,
            @NewItemType OUTPUT,
            @NewDirName OUTPUT,
            @NewLeafName OUTPUT
        SET @NewEventData = STUFF(STUFF('</>', 3, 0, 'RelatedItem'), 1, 0, STUFF(STUFF(STUFF('</>', 3, 0, 'Id'), 1, 0, STUFF(@ItemId, 1, 0, STUFF('<>', 2, 0, 'Id'))) + STUFF(STUFF('</>', 3, 0, 'Relationship'), 1, 0, STUFF('ChildDelete', 1, 0, STUFF('<>', 2, 0, 'Relationship'))) + STUFF(STUFF('</>', 3, 0, 'Type'), 1, 0, STUFF(@ItemType, 1, 0, STUFF('<>', 2, 0, 'Type'))) + STUFF(STUFF('</>', 3, 0, 'Location'), 1, 0, STUFF(@Location, 1, 0, STUFF('<>', 2, 0, 'Location'))) + STUFF(STUFF('</>', 3, 0, 'LocationType'), 1, 0, STUFF(@LocationType, 1, 0, STUFF('<>', 2, 0, 'LocationType'))), 1, 0, STUFF('<>', 2, 0, 'RelatedItem')))
        EXEC proc_AddAuditEntryUrl
            @SiteId,
            @NewDirName,
            @NewLeafName,
            @NewItemType,
            @UserId,
            @MachineName,
            @MachineIp,
            @Location,
            @LocationType,
            @Occurred,
            7,
            NULL,
            @EventSource,
            @SourceName,
            @NewEventData,
            0
     END
     RETURN 0

GO
