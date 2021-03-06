/****** Object:  StoredProcedure [dbo].[proc_MSS_RemoveFilenameFromResults]    Script Date: 5/15/2018 12:11:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_RemoveFilenameFromResults( @File nvarchar(2000), 
                                                 @FileHash int )
AS
    DELETE FROM 
        dbo.MSSDocSdids
    WHERE
        DocId in
        (
            SELECT 
                DocId 
            FROM 
                dbo.MSSCrawlUrl
            WHERE 
                DisplayHash = @FileHash AND
                DisplayUrl like @File 
        )

GO
