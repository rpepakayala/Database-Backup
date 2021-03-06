/****** Object:  StoredProcedure [dbo].[proc_CheckMeetingInstance]    Script Date: 5/15/2018 12:12:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CheckMeetingInstance
(
    @WebId              uniqueidentifier,
    @ReturnSeriesItem   bit,
    @InstanceID         int,
    @@IsInstantiated    bit OUTPUT,
    @@DTStartUTC        datetime OUTPUT
)
AS
    SET NOCOUNT ON
    DECLARE @MeetingsListID uniqueidentifier
    EXEC proc_GetUniqueList @WebId, 200, @MeetingsListID OUTPUT
    IF @MeetingsListID IS NULL
        RETURN 13
    DECLARE @EventType int
    SELECT TOP 1
        @EventType      = int1,
        @@DTStartUTC    = datetime1
    FROM
        UserData
    WHERE
        tp_ListId = @MeetingsListID AND
        tp_InstanceID = @InstanceID AND
        tp_RowOrdinal = 0
    IF @@ROWCOUNT <> 0
    BEGIN
        IF (@EventType = 0 OR @EventType = 2)
            SET @@IsInstantiated = 1
        ELSE
            SET @@IsInstantiated = 0
        IF @@IsInstantiated = 1
            RETURN 0    
        ELSE    
            RETURN 2
    END
    IF @ReturnSeriesItem = 0
        RETURN 2
    SELECT TOP 1
        bit3, tp_InstanceID, int1, uniqueidentifier1, datetime3, datetime1, datetime2, int2, ntext1, ntext2, ntext3, datetime5, int3
    FROM
        UserData
    WHERE
        tp_ListId = @MeetingsListID AND
        tp_RowOrdinal = 0 AND
        int1 = 1 AND
        CONVERT( char(8), datetime1, 112 ) - 1 <= @InstanceID AND
        (datetime2 IS NULL OR
            CONVERT( char(8), datetime2,  112 ) + 1 >= @InstanceID)
    IF @@ROWCOUNT <> 0
        RETURN 0    
    ELSE
        RETURN 2

GO
