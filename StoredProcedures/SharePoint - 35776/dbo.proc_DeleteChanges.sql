/****** Object:  StoredProcedure [dbo].[proc_DeleteChanges]    Script Date: 5/15/2018 12:11:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteChanges(
    @Days int)
AS
    SET NOCOUNT ON
    DECLARE @KeepTime datetime
    SET @KeepTime = DATEADD(day, @Days * -1, GETUTCDATE())
    DECLARE @EventTimeBatchStart datetime
    SELECT
        @EventTimeBatchStart = EventTime
    FROM
        EventBatches
    IF (@EventTimeBatchStart IS NOT NULL)
    BEGIN
        DELETE
            EventCache
        WHERE
            EventTime < @KeepTime AND
            EventTime < @EventTimeBatchStart
    END
    DELETE
        EventLog WITH (XLOCK, TABLOCK)
    WHERE
        EventTime < GETUTCDATE() - 14.0

GO
