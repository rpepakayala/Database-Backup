/****** Object:  StoredProcedure [dbo].[proc_UpdateDiskUsed]    Script Date: 5/15/2018 12:12:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateDiskUsed(
    @SiteId uniqueidentifier,
    @bUpdateTimeStampForce bit = 0)
AS
    SET NOCOUNT ON
    DECLARE @cbDelta bigint
    DECLARE @cTimeStamp bigint
    DECLARE @updateTimeStamp bit
    SELECT
        @cbDelta = (SUM(CAST((DiskUsed) AS BIGINT))),
        @cTimeStamp = (SUM(CAST((UpdateTimeStamp) AS BIGINT)))
    FROM
        SiteQuota
    WHERE
        SiteId = @SiteId
    IF @cbDelta IS NOT NULL
    BEGIN
        IF @cTimeStamp > 0 OR @bUpdateTimeStampForce = 1
            SET @updateTimeStamp = 1
        ELSE
            SET @updateTimeStamp = 0
        EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, @cbDelta, @updateTimeStamp
        DELETE
            SiteQuota
        WHERE
            SiteId = @SiteId
    END
    ELSE IF (@bUpdateTimeStampForce = 1)
    BEGIN
        EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, 0, 1
    END

GO
