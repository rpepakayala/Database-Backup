/****** Object:  StoredProcedure [dbo].[proc_HTGetFile]    Script Date: 5/15/2018 12:12:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_HTGetFile(
    @DocSiteId uniqueidentifier,
    @DocDirName nvarchar(256),
    @DocLeafName nvarchar(128),
    @TransName nvarchar(128),
    @JobType tinyint
)
AS
    DECLARE @dtLastModified as datetime
    DECLARE @TypeBlockList as tinyint
    SET @dtLastModified = (SELECT TimeLastModified FROM Docs
        WHERE SiteId=@DocSiteId AND 
            DirName=@DocDirName AND
            LeafName=@DocLeafName)
    SET @TypeBlockList  = (SELECT value FROM HT_Settings WHERE [key] = 'TypeBlklst')
    SELECT [File]
    FROM HT_Cache
    WHERE [SiteId]=@DocSiteId AND
        [DirName]=@DocDirName AND
        [LeafName]=@DocLeafName AND
        [TransName]=@TransName AND 
        [JobType]=@JobType AND 
        [STSDocVersion] >= @dtLastModified
    IF(@@ROWCOUNT > 0 AND 
        @JobType != (SELECT value FROM HT_Settings WHERE [key] = 'TypeDocRec'))
    BEGIN
    UPDATE HT_Cache
    SET [TimeStamp] = GETUTCDATE()
    WHERE [SiteId]=@DocSiteId AND
        [DirName]=@DocDirName AND
        [LeafName]=@DocLeafName AND
        [TransName]=@TransName AND 
        [JobType]=@JobType
    END

GO
