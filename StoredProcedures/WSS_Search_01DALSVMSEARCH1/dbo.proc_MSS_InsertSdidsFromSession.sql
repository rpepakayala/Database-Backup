/****** Object:  StoredProcedure [dbo].[proc_MSS_InsertSdidsFromSession]    Script Date: 5/15/2018 12:13:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_InsertSdidsFromSession
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
DECLARE @strSessionDocSdids NVARCHAR(128)
SELECT @strSessionDocSdids = 'MSSSessionDocSdids' + @strAlt
DECLARE @strCommand NVARCHAR(4000)
IF @NoExistingDocs = 1
BEGIN
	SELECT @strCommand = 
	    'INSERT INTO MSSDocSdids 
	        (DocId, Sdid, Type, HasPluggableSecurityTrimming )
		 SELECT DocId, Sdid, Type, HasPluggableSecurityTrimming
		 FROM ' + @strSessionDocSdids 
	EXEC(@strCommand)
END
ELSE
BEGIN
	SELECT @strCommand = 
	    'INSERT INTO MSSDocSdids 
	        (DocId, Sdid, Type, HasPluggableSecurityTrimming )
		 SELECT DocId, Sdid, Type, HasPluggableSecurityTrimming
		 FROM ' + @strSessionDocSdids + '
		 WHERE NOT EXISTS (
			SELECT 1 FROM MSSDocSdids 
			WHERE DocId = ' + @strSessionDocSdids + '.DocId AND
			Type = ' + @strSessionDocSdids + '.Type AND
            HasPluggableSecurityTrimming = ' + @strSessionDocSdids + '.HasPluggableSecurityTrimming)'
	EXEC(@strCommand)
	SELECT @strCommand = 
	    'UPDATE MSSDocSdids SET
			Sdid = ' + @strSessionDocSdids + '.Sdid,
			Type = ' + @strSessionDocSdids + '.Type,
			HasPluggableSecurityTrimming = ' + @strSessionDocSdids + '.HasPluggableSecurityTrimming
			FROM MSSDocSdids
			INNER JOIN ' + @strSessionDocSdids + ' 
			ON MSSDocSdids.DocId = ' + @strSessionDocSdids + '.DocId AND
			MSSDocSdids.Type = ' + @strSessionDocSdids + '.Type AND
			MSSDocSdids.HasPluggableSecurityTrimming = ' + @strSessionDocSdids + '.HasPluggableSecurityTrimming'
	EXEC(@strCommand)
END
SELECT @strCommand = '
    TRUNCATE TABLE '+ @strSessionDocSdids
EXEC(@strCommand)

GO
