/****** Object:  StoredProcedure [dbo].[proc_MSS_InsertDefinitionsFromSession]    Script Date: 5/15/2018 12:13:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_InsertDefinitionsFromSession
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
    DECLARE @strSessionDefinitions NVARCHAR(128)
    SELECT @strSessionDefinitions = 'MSSSessionDefinitions' + @strAlt
    DECLARE @strCommand NVARCHAR(4000)
    IF @NoExistingDocs = 0
    BEGIN
        SELECT @strCommand = 
            'DELETE FROM MSSDefinitions 
            WHERE DocId IN 
                (SELECT DocId FROM ' + @strSessionDefinitions + ')'
        EXEC(@strCommand)
    END
    SELECT @strCommand =  
        'INSERT INTO MSSDefinitions 
            (Term, DocId, Sentence, TermOffset, TermLength)
        SELECT Term, DocId, Sentence, TermOffset, TermLength
        FROM ' + @strSessionDefinitions
    EXEC(@strCommand)
    SELECT @strCommand = '
        TRUNCATE TABLE '+ @strSessionDefinitions
    EXEC(@strCommand)

GO
