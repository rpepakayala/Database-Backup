/****** Object:  StoredProcedure [dbo].[proc_DeplGetFileEventReceivers]    Script Date: 5/15/2018 12:11:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetFileEventReceivers(
    @LastOrdinal int,
    @SiteId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        er.Id,
        er.HostId,
        er.WebId,
        er.Name,
        er.HostType,
        er.ItemId,
        er.Type,
        er.SequenceNumber,
        er.Assembly,
        er.Class,
        er.Data,
        er.Filter,
        er.Credential
    FROM
        EventReceivers ER
    INNER JOIN
        (SELECT TOP 200
             files.Id, files.ParentWebId
         FROM #ExportObjects files
         WHERE
             files.Ordinal > @LastOrdinal AND
             (files.Type = 5 OR
              files.Type = 7) AND
             files.IsDeleted = 0
         ORDER BY files.Ordinal) as E
    ON
        E.Id = er.HostId AND
        E.ParentWebId = er.WebId AND
        ER.SiteId = @SiteId AND
        ER.HostType <> 5 AND
        ER.Type <> 32767

GO
