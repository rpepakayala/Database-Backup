/****** Object:  StoredProcedure [dbo].[proc_MSS_InsertDocSignaturesFromSession]    Script Date: 5/15/2018 12:11:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_InsertDocSignaturesFromSession
                @nIsAlt int,
    		    @NoExistingDocs bit
WITH RECOMPILE
AS

    SET NOCOUNT ON

    DECLARE @strAlt NVARCHAR(128)
    SELECT @strAlt = ''

    if (@nIsAlt=1)
    BEGIN
        SELECT @strAlt = 'Alt'
    END

    DECLARE @strSessionDocSignatures NVARCHAR(128)
    SELECT @strSessionDocSignatures = 'MSSSessionDocSignatures' + @strAlt

    DECLARE @strSessionDocProps NVARCHAR(128)
    SELECT @strSessionDocProps = 'MSSSessionDocProps' + @strAlt

    DECLARE @strCommand NVARCHAR(4000)

    SELECT @strCommand =  
        'INSERT INTO MSSAlertDocHistory 
                (UrlSignature, ContentSignature, SchemaSignature, DiscoveryTime, ModificationTime, SchemaModificationTime)
         SELECT UrlSignature, ContentSignature, SchemaSignature, CrawlTime, CrawlTime, CrawlTime 
         FROM ' + @strSessionDocSignatures
    EXEC(@strCommand)

    IF @NoExistingDocs = 0
    BEGIN
        SELECT @strCommand =  '
            UPDATE MSSAlertDocHistory 
                SET ModificationTime = 
                    CASE WHEN MSSAlertDocHistory.ContentSignature <> ' + @strSessionDocSignatures + '.ContentSignature AND
                        MSSAlertDocHistory.SchemaSignature = ' + @strSessionDocSignatures + '.SchemaSignature
                    THEN CrawlTime 
                    ELSE ModificationTime
                    END,
                    SchemaModificationTime = 
                    CASE WHEN MSSAlertDocHistory.SchemaSignature <> ' + @strSessionDocSignatures + '.SchemaSignature
                    THEN CrawlTime
                    ELSE SchemaModificationTime
                    END,
                    MSSAlertDocHistory.ContentSignature = ' + @strSessionDocSignatures + '.ContentSignature,
                    MSSAlertDocHistory.SchemaSignature = ' + @strSessionDocSignatures + '.SchemaSignature
                FROM MSSAlertDocHistory
                JOIN ' + @strSessionDocSignatures + ' ON MSSAlertDocHistory.UrlSignature = ' + @strSessionDocSignatures + '.UrlSignature
                WHERE MSSAlertDocHistory.ContentSignature <> ' + @strSessionDocSignatures + '.ContentSignature OR
                    MSSAlertDocHistory.SchemaSignature <> ' + @strSessionDocSignatures + '.SchemaSignature'
        EXEC(@strCommand)
    END

    SELECT @strCommand = 
        'INSERT INTO ' + @strSessionDocProps + '
            (CatalogId, DocId, Pid, RowId, llVal )
         SELECT 0, DocId, 321, 0, DiscoveryTime 
         FROM MSSAlertDocHistory
         JOIN ' + @strSessionDocSignatures + ' 
         ON MSSAlertDocHistory.UrlSignature = ' + @strSessionDocSignatures + '.UrlSignature' 
    EXEC (@strCommand)

    SELECT @strCommand = 
        'INSERT INTO ' + @strSessionDocProps + ' 
            (CatalogId, DocId, Pid, RowId, llVal )
         SELECT 0, DocId, 322, 0, ModificationTime FROM MSSAlertDocHistory
         JOIN ' + @strSessionDocSignatures + ' 
         ON MSSAlertDocHistory.UrlSignature = ' + @strSessionDocSignatures + '.UrlSignature '
    EXEC (@strCommand)

    SELECT @strCommand = '
        TRUNCATE TABLE '+ @strSessionDocSignatures
    EXEC(@strCommand)


GO
