/****** Object:  StoredProcedure [dbo].[proc_HTMakeSpace]    Script Date: 5/15/2018 12:12:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_HTMakeSpace(
    @DocSiteId uniqueidentifier,
    @DocDirName nvarchar(256),
    @DocLeafName nvarchar(128),
    @Version datetime,
    @JobType as tinyint,
    @delAmount int,
    @maxCacheSize int,
    @SpaceAvailable bigint OUTPUT
)
AS
DECLARE @curOldestTime as SmallDateTime
DECLARE @curDocSiteId uniqueidentifier
DECLARE @curDocDirName nvarchar(256)
DECLARE @curDocLeafName nvarchar(128)
DECLARE @curJobType as tinyint
DECLARE @curSize as bigint
DECLARE @actualDelAmount as bigint
DECLARE @maxCacheSizeInBytes as bigint
DECLARE @totalRemoved bigint
SET @totalRemoved = 0
SET @curSize = (SELECT value FROM HT_Settings WHERE [key] = 'CurSize')
SET @maxCacheSizeInBytes = (@maxCacheSize * CAST(1048576 as bigint))
IF (@delAmount <= @maxCacheSizeInBytes)
BEGIN
    SET @totalRemoved = (SELECT (SUM(CAST(([FileSize]) AS BIGINT))) 
        FROM HT_Cache 
        WHERE SiteId = @DocSiteId AND 
            DirName = @DocDirName AND
            LeafName = @DocLeafName AND
            JobType = @jobType AND
            STSDocVersion < @Version)
    IF @totalRemoved IS NULL
    BEGIN
        SET @totalRemoved = 0
    END
    ELSE
    BEGIN
        DELETE FROM HT_Cache 
        WHERE SiteId = @DocSiteId AND 
            DirName = @DocDirName AND
            LeafName = @DocLeafName AND
            JobType = @jobType AND
            STSDocVersion < @Version
    END
    SET @actualDelAmount = @curSize + @delAmount - @maxCacheSizeInBytes
    WHILE @totalRemoved < @actualDelAmount
    BEGIN
        SELECT @curOldestTime = (SELECT MIN([TimeStamp]) FROM HT_Cache)
        IF @curOldestTime IS NULL
        BEGIN
            BREAK
        END
        SELECT @curDocSiteId = SiteId, 
            @curDocDirName = DirName,
            @curDocLeafName = LeafName,
            @CurJobType = JobType  
            FROM HT_Cache 
            WHERE [TimeStamp] = @curOldestTime
        SET @totalRemoved = @totalRemoved + 
            (SELECT (SUM(CAST(([FileSize]) AS BIGINT))) 
            FROM HT_Cache 
            WHERE @curDocSiteId = SiteId AND
                @curDocDirName = DirName AND
                @curDocLeafName = LeafName AND
                @CurJobType = JobType)
        DELETE FROM HT_Cache 
            WHERE @curDocSiteId = SiteId AND
                @curDocDirName = DirName AND
                @curDocLeafName = LeafName AND
                @CurJobType = JobType
    END
    IF (@totalRemoved >= 0)
    BEGIN
        SET @curSize = @curSize - @totalRemoved
        EXEC proc_HTSetSetting 'CurSize', @curSize
    END
    SET @SpaceAvailable =  @maxCacheSizeInBytes - @curSize
END

GO
