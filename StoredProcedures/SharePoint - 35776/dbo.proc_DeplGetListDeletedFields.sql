/****** Object:  StoredProcedure [dbo].[proc_DeplGetListDeletedFields]    Script Date: 5/15/2018 12:11:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetListDeletedFields(
    @LastOrdinal int,
    @SiteId uniqueidentifier,
    @ChangeTimeStart datetime = null,
    @ChangeNumberStart int = null,
    @ChangeTimeEnd datetime = null,
    @ChangeNumberEnd int = null
    )
AS
    SET NOCOUNT ON
    IF NOT @ChangeTimeStart IS NULL
    BEGIN
        SELECT
            ev.ListId,
            ev.Guid0 as FieldId
            FROM
                EventCache ev
            INNER JOIN
                 (SELECT TOP 50
                    lists.Id, lists.ParentWebId
                  FROM #ExportObjects lists
                  WHERE
                      lists.Ordinal > @LastOrdinal AND
                      lists.Type = 3 AND
                      lists.IsDeleted = 0
                  ORDER BY lists.Ordinal) as e
            ON
                e.Id = ev.ListId AND
                e.ParentWebId = ev.WebId AND
                ev.SiteId = @SiteId AND
                ev.EventTime >= @ChangeTimeStart AND
                ev.Id > @ChangeNumberStart AND
                ev.EventTime <= @ChangeTimeEnd AND
                ev.Id <= @ChangeNumberEnd AND
                (ev.EventType & 8192) != 0 AND
                (ev.ObjectType & 2) != 0 AND
                ev.Guid0 IS NOT NULL
    END                
    ELSE
    BEGIN
        SELECT
            ev.ListId,
            ev.Guid0 as FieldId
            FROM
                EventCache ev
            INNER JOIN #IncrementalSearchScope scope
            ON
                ev.SiteId = @SiteId AND
                ev.WebId = scope.Id AND
                scope.Type = 1 AND
                ev.EventTime >= scope.ChangeTime AND
                ev.Id > scope.ChangeNumber AND
                ev.EventTime <= @ChangeTimeEnd AND
                ev.Id <= @ChangeNumberEnd AND
                (ev.EventType & 8192) != 0 AND
                (ev.ObjectType & 2) != 0  AND
                ev.Guid0 IS NOT NULL             
            INNER JOIN
                 (SELECT TOP 50
                    lists.Id, lists.ParentWebId
                  FROM #ExportObjects lists
                  WHERE
                      lists.Ordinal > @LastOrdinal AND
                      lists.Type = 3 AND
                      lists.IsDeleted = 0
                  ORDER BY lists.Ordinal) as e
            ON
                e.Id = ev.ListId AND
                e.ParentWebId = ev.WebId 
    END            

GO
