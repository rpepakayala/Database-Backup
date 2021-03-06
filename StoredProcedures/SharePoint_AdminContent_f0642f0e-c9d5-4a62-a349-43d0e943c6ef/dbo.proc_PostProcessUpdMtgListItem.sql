/****** Object:  StoredProcedure [dbo].[proc_PostProcessUpdMtgListItem]    Script Date: 5/15/2018 12:12:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_PostProcessUpdMtgListItem
(
    @SiteId         uniqueidentifier,
    @WebId          uniqueidentifier,
    @ListID         uniqueidentifier,
    @InstanceID     int,
    @OldEventType   int,
    @EventType      int,
    @RecurrenceID   datetime,
    @IsDetached     int,
    @tp_Version     int,
    @tp_Editor      int,
    @tp_Modified    datetime
)
AS
    SET NOCOUNT ON
    IF (@EventType IS NULL OR
        (@RecurrenceID IS NULL AND
            (@EventType <> 0 AND @EventType <> 1)) OR
        (@RecurrenceID IS NOT NULL AND
            (@EventType <> 3 AND @EventType <> 2)))
        RETURN 13
    IF NOT (
        ((@OldEventType = 0 OR @OldEventType = 2) AND
            (@EventType = 0 OR @EventType = 2)) OR
        (@OldEventType = 1 AND
            @EventType = 1) OR
        (@OldEventType = 3 AND
            @EventType = 2)
        )
            RETURN 13
    IF (@EventType = 1 AND @IsDetached <> 0)
    BEGIN
        UPDATE
            UserData
        SET
            int4 = @IsDetached
        WHERE
            tp_ListId = @ListID AND
            tp_RowOrdinal = 0
        UPDATE
            UserData
        SET
            tp_Version  = ISNULL(@tp_Version + 1, tp_Version),
            tp_Editor   = @tp_Editor,
            tp_Modified = @tp_Modified
        WHERE
            tp_ListId = @ListID
    END
    IF (@OldEventType = 3 AND
        @EventType = 2)
    BEGIN
        DECLARE @Error int
        EXEC @Error = proc_InstantiateMtgInstance
            @SiteId,
            @WebId,
            NULL,   
            @InstanceID,
            NULL    
        IF @Error <> 0
            RETURN @Error
    END
    RETURN 0

GO
