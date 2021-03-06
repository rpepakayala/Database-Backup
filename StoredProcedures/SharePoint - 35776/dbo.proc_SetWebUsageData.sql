/****** Object:  StoredProcedure [dbo].[proc_SetWebUsageData]    Script Date: 5/15/2018 12:12:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SetWebUsageData(
    @WebSiteId uniqueidentifier,
    @WebUrl nvarchar(260),
    @BlobTypeToUpdate int,
    @UsageData image,
    @BWUsed bigint,
    @UsageDataVersion int,
    @DayLastAccessed smallint)
AS
    SET NOCOUNT ON
    DECLARE @WebId uniqueidentifier
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    EXEC proc_SplitUrl @Weburl, @DirName OUTPUT, @LeafName OUTPUT
    SELECT
        @WebId = WebId
    FROM
        Docs
    WHERE
        SiteId = @WebSiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        Type = 2
    IF @WebId IS NULL
    BEGIN
        RETURN 3
    END
    IF @BlobTypeToUpdate = 0
    BEGIN
    UPDATE
        Webs
        SET
            DailyUsageData = @UsageData,
            DailyUsageDataVersion = @UsageDataVersion + 1,
            DayLastAccessed = @DayLastAccessed
        WHERE
            Id = @WebId AND
            DailyUsageDataVersion = @UsageDataVersion
        END
        ELSE
        BEGIN
        UPDATE
            Webs
        SET
            MonthlyUsageData = @UsageData,
            MonthlyUsageDataVersion = @UsageDataVersion + 1,
            DayLastAccessed = @DayLastAccessed
        WHERE
            Id = @WebId AND
            MonthlyUsageDataVersion = @UsageDataVersion
        END
        IF @@ROWCOUNT = 1 
        BEGIN
            UPDATE
                Sites
            SET
                BWUsed = BWUsed + @BWUsed
            WHERE
                Id = @WebSiteId
            EXEC proc_DirtyDependents @WebSiteId, 7, @WebUrl
            RETURN 0
        END
        ELSE
        BEGIN
            RETURN 3
        END

GO
