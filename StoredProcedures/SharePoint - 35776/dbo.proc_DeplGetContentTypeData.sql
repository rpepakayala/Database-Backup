/****** Object:  StoredProcedure [dbo].[proc_DeplGetContentTypeData]    Script Date: 5/15/2018 12:11:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetContentTypeData(
    @LastOrdinal int)
AS
    SET NOCOUNT ON
    SELECT TOP 50
        e.Id,
        e.FullUrl as ExportObjectUrl,
        e.Ordinal,
        e.ContentTypeId,
        e.ParentWebId,
        e.ContentTypeListId
       FROM #ExportObjects e
       WHERE
           e.Ordinal > @LastOrdinal AND
           e.Type = 8 AND
           e.IsDeleted = 0
       ORDER BY e.Ordinal

GO
