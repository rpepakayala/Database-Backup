/****** Object:  StoredProcedure [dbo].[proc_GetBlobIdsVersions]    Script Date: 5/15/2018 12:12:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetBlobIdsVersions(
    @SiteId uniqueidentifier,
    @DocId uniqueidentifier,
    @Version int)
AS 
    SELECT TOP 1000
        Content,
        Id,
        Version
    FROM
        AllDocVersions
    WHERE 
        (DocFlags & 65536) != 0 AND
        AllDocVersions.SiteId = @SiteId AND
        (AllDocVersions.Id > @DocId OR
        (AllDocVersions.Id = @DocId AND AllDocVersions.Version > @Version))
    ORDER BY
        AllDocVersions.SiteId, AllDocVersions.Id, AllDocVersions.Version
    RETURN 0 

GO
