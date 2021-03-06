/****** Object:  StoredProcedure [dbo].[proc_MSS_GetDocStatus]    Script Date: 5/15/2018 12:13:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetDocStatus
@DisplayHashes nvarchar(2048)
AS
    DECLARE @strCommand AS nvarchar(2048)
    SELECT @strCommand = 'SELECT DocId, ErrorId, DisplayURL FROM MSSCrawlURL WHERE DisplayHash IN (' 
                    + @DisplayHashes + 
                    ') ORDER BY DisplayURL ASC, IndexType DESC, DocId ASC'
    EXEC(@strCommand)

GO
