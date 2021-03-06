/****** Object:  StoredProcedure [dbo].[proc_HTCreateRow]    Script Date: 5/15/2018 12:12:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_HTCreateRow(
    @DocSiteId uniqueidentifier,
    @DocDirName nvarchar(256),
    @DocLeafName nvarchar(128),
    @TransName nvarchar(128),
    @JobType tinyint,
    @File image,
    @MainFile bit,
    @maxCacheSize int
)
AS
    DECLARE @dtLastModified as datetime
    DECLARE @FileSize as int
    DECLARE @SpaceAvailable as bigint
    SET @dtLastModified = (SELECT TimeLastModified 
        FROM Docs
        WHERE SiteId=@DocSiteId AND 
            DirName=@DocDirName AND
            LeafName=@DocLeafName)
    SET @FileSize = DATALENGTH(@File)
    IF @dtLastModified IS NOT NULL
    BEGIN
        EXEC proc_HTMakeSpace @DocSiteId,
            @DocDirName,
            @DocLeafName,
            @dtLastModified,
            @JobType,
            @FileSize, 
            @maxCacheSize, 
            @SpaceAvailable OUTPUT
        IF(@FileSize <= @SpaceAvailable)
        BEGIN
            INSERT INTO 
                HT_Cache
            VALUES 
                (GETUTCDATE(), 
                @DocSiteId, 
                @DocDirName,
                @DocLeafName,
                @TransName, 
                @JobType, 
                @dtLastModified, 
                @File, 
                @FileSize, @MainFile)
            UPDATE HT_Settings
            SET value = (SELECT value FROM HT_Settings WHERE [key] = 'CurSize') + @FileSize
            WHERE [key] = 'CurSize'
        END
    END

GO
