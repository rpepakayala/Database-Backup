/****** Object:  StoredProcedure [dbo].[proc_MSS_InsertDocPropsFromSession]    Script Date: 5/15/2018 12:11:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_InsertDocPropsFromSession
                    @nIsAlt int,
		            @NoExistingDocs bit
WITH RECOMPILE
AS

    SET NOCOUNT ON

    DECLARE @strAlt nvarchar(128)
    SELECT @strAlt = ''

    if (@nIsAlt=1)
    begin
        SELECT @strAlt = 'Alt'
    end

    DECLARE @strSessionDocProps NVARCHAR(128)
    SELECT @strSessionDocProps = 'MSSSessionDocProps' + @strAlt

    DECLARE @strCommand nvarchar(4000)

    IF @NoExistingDocs = 0
    BEGIN
        SELECT @strCommand = 'UPDATE '+ @strSessionDocProps + ' SET
                    RecordExists = 1,
                    llValChanged = CASE WHEN ISNULL(MSSDocProps.llVal, 0) <> ISNULL('+ @strSessionDocProps + '.llVal, 0) THEN 1 ELSE 0 END,
                    strValChanged = CASE WHEN ISNULL(MSSDocProps.strVal, '''') <> ISNULL('+ @strSessionDocProps + '.strVal, '''') THEN 1 ELSE 0 END,
                    fltValChanged = CASE WHEN ISNULL(MSSDocProps.fltVal, 0) <> ISNULL('+ @strSessionDocProps + '.fltVal, 0) THEN 1 ELSE 0 END
                    FROM MSSDocProps
                    INNER JOIN '+ @strSessionDocProps + ' 
                    ON MSSDocProps.DocId = '+ @strSessionDocProps + '.DocId AND
                    MSSDocProps.Pid = '+ @strSessionDocProps + '.Pid AND
                    MSSDocProps.RowId = '+ @strSessionDocProps + '.RowId'	
        EXEC(@strCommand)

        SELECT @strCommand = 'UPDATE '+ @strSessionDocProps + ' SET
                    binValChanged = 1
                    FROM MSSDocProps
                    INNER JOIN '+ @strSessionDocProps + ' 
                    ON MSSDocProps.DocId = '+ @strSessionDocProps + '.DocId AND
                    MSSDocProps.Pid = '+ @strSessionDocProps + '.Pid AND
                    MSSDocProps.RowId = '+ @strSessionDocProps + '.RowId
                    WHERE NOT(MSSDocProps.binVal IS NULL)'
        EXEC(@strCommand)

        SELECT @strCommand = 'UPDATE '+ @strSessionDocProps + ' SET
                    binValChanged = 1
                    FROM MSSDocProps
                    INNER JOIN '+ @strSessionDocProps + ' 
                    ON MSSDocProps.DocId = '+ @strSessionDocProps + '.DocId AND
                    MSSDocProps.Pid = '+ @strSessionDocProps + '.Pid AND
                    MSSDocProps.RowId = '+ @strSessionDocProps + '.RowId
                    WHERE '+ @strSessionDocProps + '.binValChanged = 0 AND
                    NOT('+ @strSessionDocProps + '.binVal IS NULL)'
        EXEC(@strCommand)
    END

    SELECT @strCommand = 'INSERT INTO MSSDocProps ( DocId, Pid, RowId, llVal, strVal, binVal, fltVal )
                            SELECT DocId, Pid, RowId, llVal, strVal, binVal, fltVal 
                            FROM '+ @strSessionDocProps + '
                            WHERE RecordExists = 0'
    EXEC(@strCommand)

    IF @NoExistingDocs = 0
    BEGIN
        SELECT @strCommand = 
            'UPDATE MSSDocProps SET
                llVal = '+ @strSessionDocProps + '.llVal
            FROM MSSDocProps
            INNER JOIN '+ @strSessionDocProps + ' 
            ON MSSDocProps.DocId = '+ @strSessionDocProps + '.DocId AND
            MSSDocProps.Pid = '+ @strSessionDocProps + '.Pid AND
            MSSDocProps.RowId = '+ @strSessionDocProps + '.RowId AND 
            '+ @strSessionDocProps + '.llValChanged = 1'
        EXEC(@strCommand)

        SELECT @strCommand = 
            'UPDATE MSSDocProps SET
                strVal = '+ @strSessionDocProps + '.strVal
            FROM MSSDocProps
            INNER JOIN '+ @strSessionDocProps + ' 
            ON MSSDocProps.DocId = '+ @strSessionDocProps + '.DocId AND
            MSSDocProps.Pid = '+ @strSessionDocProps + '.Pid AND
            MSSDocProps.RowId = '+ @strSessionDocProps + '.RowId AND
            '+ @strSessionDocProps + '.strValChanged = 1'
        EXEC(@strCommand)

        SELECT @strCommand = 
            'UPDATE MSSDocProps SET
                binVal = '+ @strSessionDocProps + '.binVal,
                fltVal = '+ @strSessionDocProps + '.fltVal
            FROM MSSDocProps
            INNER JOIN '+ @strSessionDocProps + ' 
            ON MSSDocProps.DocId = '+ @strSessionDocProps + '.DocId AND
            MSSDocProps.Pid = '+ @strSessionDocProps + '.Pid AND
            MSSDocProps.RowId = '+ @strSessionDocProps + '.RowId AND
            '+ @strSessionDocProps + '.binValChanged = 1'

        EXEC(@strCommand)

        SELECT @strCommand = 
            'UPDATE MSSDocProps SET
                fltVal = '+ @strSessionDocProps + '.fltVal
            FROM MSSDocProps
            INNER JOIN '+ @strSessionDocProps + ' 
            ON MSSDocProps.DocId = '+ @strSessionDocProps + '.DocId AND
            MSSDocProps.Pid = '+ @strSessionDocProps + '.Pid AND
            MSSDocProps.RowId = '+ @strSessionDocProps + '.RowId AND
            '+ @strSessionDocProps + '.fltValChanged = 1 AND
            '+ @strSessionDocProps + '.binValChanged = 0'
        EXEC(@strCommand)	

        SELECT @strCommand = 
            'DELETE FROM MSSDocProps 
            FROM MSSDocProps
            WHERE DocId IN 
                (SELECT DocId FROM '+ @strSessionDocProps + ') AND
            NOT EXISTS 
                (SELECT 1 FROM '+ @strSessionDocProps + ' 
                WHERE '+ @strSessionDocProps + '.DocId = MSSDocProps.DocId AND
                '+ @strSessionDocProps + '.Pid = MSSDocProps.Pid AND
                '+ @strSessionDocProps + '.RowId = MSSDocProps.Rowid)'
        EXEC(@strCommand)

    END

GO
