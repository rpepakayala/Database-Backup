/****** Object:  StoredProcedure [dbo].[proc_MSS_InsertDuplicateHashesFromSession]    Script Date: 5/15/2018 12:11:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_InsertDuplicateHashesFromSession
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

    DECLARE @strSessionDuplicateHashes NVARCHAR(128)
    SELECT @strSessionDuplicateHashes = 'MSSSessionDuplicateHashes' + @strAlt

    DECLARE @strCommand NVARCHAR(4000)

    IF @NoExistingDocs = 1
    BEGIN
        SELECT @strCommand = 
            'INSERT INTO MSSDuplicateHashes 
                (DocId, HashVal)
             SELECT DocId, HashVal 
             FROM ' + @strSessionDuplicateHashes 
        EXEC(@strCommand)
    END
    ELSE
    BEGIN
        SELECT @strCommand = 
            'UPDATE ' + @strSessionDuplicateHashes + ' 
                    SET RecordExists = 1 
             FROM ' + @strSessionDuplicateHashes + ' 
             INNER JOIN MSSDuplicateHashes
             ON MSSDuplicateHashes.DocId = ' + @strSessionDuplicateHashes + ' .DocId AND
             MSSDuplicateHashes.HashVal = ' + @strSessionDuplicateHashes + ' .HashVal'
        EXEC(@strCommand)

        SELECT @strCommand = 
            'DELETE FROM MSSDuplicateHashes
             FROM MSSDuplicateHashes 
             WHERE DocId IN (SELECT DocId FROM ' + @strSessionDuplicateHashes + ') AND
             NOT EXISTS (SELECT 1 FROM ' + @strSessionDuplicateHashes + ' WHERE DocId = MSSDuplicateHashes.DocId and MSSDuplicateHashes.HashVal = HashVal and RecordExists = 1)'
        EXEC(@strCommand)

        SELECT @strCommand = 
            'INSERT INTO MSSDuplicateHashes 
                (DocId, HashVal)
             SELECT DocId, HashVal 
             FROM ' + @strSessionDuplicateHashes + ' 
             WHERE RecordExists = 0'
        EXEC(@strCommand)

    END

    SELECT @strCommand = '
        TRUNCATE TABLE '+ @strSessionDuplicateHashes
    EXEC(@strCommand)


GO
