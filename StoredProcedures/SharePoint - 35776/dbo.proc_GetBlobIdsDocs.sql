/****** Object:  StoredProcedure [dbo].[proc_GetBlobIdsDocs]    Script Date: 5/15/2018 12:12:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetBlobIdsDocs(
    @SiteId uniqueidentifier,
    @DocId uniqueidentifier)
AS 
    SELECT TOP 1000
        AllDocStreams.Content,
        AllDocStreams.Id,
        0
    FROM
        AllDocStreams
    LEFT OUTER JOIN 
        AllDocs
    ON
        AllDocs.Id = AllDocStreams.Id AND
        AllDocs.Level = AllDocStreams.Level 
    WHERE 
        (DocFlags & 65536) != 0 AND
        (AllDocStreams.SiteId = @SiteId AND AllDocStreams.Id >= @DocId)
    ORDER BY
        AllDocStreams.SiteId, AllDocStreams.Id, AllDocStreams.Level
    RETURN 0 

GO
