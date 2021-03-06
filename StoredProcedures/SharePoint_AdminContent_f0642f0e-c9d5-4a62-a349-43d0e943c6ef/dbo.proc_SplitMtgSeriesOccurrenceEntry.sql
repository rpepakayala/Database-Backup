/****** Object:  StoredProcedure [dbo].[proc_SplitMtgSeriesOccurrenceEntry]    Script Date: 5/15/2018 12:13:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SplitMtgSeriesOccurrenceEntry
(
    @SiteId             uniqueidentifier,
    @WebId              uniqueidentifier,
    @MeetingsListID     uniqueidentifier = NULL,    
    @InstanceID         int,
    @DTStartUTC         datetime,
    @CreateOrphaned     bit = 0
)
AS
    SET NOCOUNT ON
    IF @MeetingsListID IS NULL
    BEGIN
        EXEC proc_GetUniqueList @WebId, 200, @MeetingsListID OUTPUT
        IF @MeetingsListID IS NULL
            RETURN 13
    END
    DECLARE @EventType int
    SELECT TOP 1
        @EventType = int1
    FROM
        UserData
    WHERE
        tp_ListId = @MeetingsListID AND
        tp_InstanceID = @InstanceID AND
        tp_RowOrdinal = 0
    IF @@ROWCOUNT > 0
    BEGIN
        IF (@EventType = 2)
            RETURN 0     
        ELSE
            RETURN 183
    END
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    DECLARE @DTEndUTC datetime
    DECLARE @OccurrenceDuration int
    SELECT TOP 1
        @OccurrenceDuration = int2,
        @DirName            = tp_DirName,
        @LeafName           = tp_LeafName
    FROM
        UserData
    WHERE
        tp_ListId = @MeetingsListID AND
        int1 = 1 AND
        tp_RowOrdinal = 0
    IF @DirName IS NULL
        RETURN 13
    SET @DTEndUTC = DATEADD(second, @OccurrenceDuration, @DTStartUTC)
    DECLARE @ItemID int
    DECLARE @Error int
    EXEC @Error = proc_CloneDoc
        @SiteId,
        @DirName,
        @LeafName,
        @InstanceID,
        @ItemID OUTPUT
    IF @Error <> 0
        RETURN @Error
    UPDATE
        UserData
    SET
        int1 = 2,
        bit2 = @CreateOrphaned, bit1 = @CreateOrphaned, int4 = CASE WHEN @CreateOrphaned = 1 THEN int4 | 3 ELSE int4 END, datetime3 = @DTStartUTC, datetime1 = @DTStartUTC, datetime2 = @DTEndUTC,
        int6 = NULL, nvarchar1 = NULL, int2 = NULL, ntext1 = NULL, ntext2 = NULL, ntext3 = NULL, datetime5 = NULL, int3 = NULL
    WHERE
        tp_ListId = @MeetingsListID AND
        tp_ID = @ItemID AND
        tp_RowOrdinal = 0
    IF @@ROWCOUNT > 0
        RETURN 0
    ELSE
        RETURN 1150

GO
