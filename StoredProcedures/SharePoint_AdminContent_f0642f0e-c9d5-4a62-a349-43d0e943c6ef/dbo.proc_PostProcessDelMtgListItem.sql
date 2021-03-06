/****** Object:  StoredProcedure [dbo].[proc_PostProcessDelMtgListItem]    Script Date: 5/15/2018 12:12:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_PostProcessDelMtgListItem
(
    @SiteId             uniqueidentifier,
    @WebId              uniqueidentifier,
    @MeetingsListID     uniqueidentifier,
    @EventType          int
)
AS
    SET NOCOUNT ON
    IF (@EventType = 0 OR @EventType = 1)
    BEGIN
        DECLARE @NewMeetingCount int
        DECLARE @WebUrl nvarchar(256)    
        IF @EventType = 0
        BEGIN
            SELECT
                @NewMeetingCount = CASE WHEN MeetingCount = -1
                    THEN MeetingCount
                    ELSE MeetingCount - 1
                    END,
                @WebUrl = FullUrl
            FROM
                Webs WITH (UPDLOCK)
            WHERE
                Id = @WebId
        END
        ELSE    
        BEGIN
            SELECT
                @NewMeetingCount = COUNT(*)
            FROM
                UserData
            WHERE
                tp_ListId = @MeetingsListID AND
                tp_RowOrdinal = 0 AND
                int1 = 0
        END
        IF @NewMeetingCount <> -1
        BEGIN
            UPDATE
                Webs
            SET
                MeetingCount = @NewMeetingCount
            WHERE
                Id = @WebId
            IF @NewMeetingCount = 0
            BEGIN
                EXEC proc_CreateDocLibSubFoldersForMtgInst
                    @SiteId,
                    @WebId,
                    @WebUrl,
                    1
            END
        END
    END

GO
