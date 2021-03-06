/****** Object:  StoredProcedure [dbo].[proc_DeplOrderExportObjects]    Script Date: 5/15/2018 12:12:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplOrderExportObjects(
    @TestRun tinyint,
    @ObjectCount int out)
AS
    SELECT
        @ObjectCount = COUNT(*)
    FROM #ExportObjects
    IF @TestRun = 1
        RETURN
    WHILE EXISTS
        (SELECT TOP 1 Id
         FROM #ExportObjects
         WHERE (Type = 2 OR Type = 5)AND 
            EXISTS (
                SELECT 1 
                FROM #ExportObjects parent
                WHERE 
                    parent.Id = #ExportObjects.ParentId AND
                    parent.Type = 6))
    BEGIN                              
        UPDATE #ExportObjects
            SET Type = 
                CASE 
                    WHEN Type = 2 THEN 6
                    ELSE 7
                END                    
        WHERE
            (Type = 2 OR Type = 5)AND 
            EXISTS (
                SELECT 1 
                FROM #ExportObjects parent
                WHERE 
                    parent.Id = #ExportObjects.ParentId AND
                    parent.Type = 6)
    END                    
    DECLARE @ExportObjectOrdered TABLE (
        Id uniqueidentifier not null,
        Ordinal int identity not null)
    INSERT INTO @ExportObjectOrdered (Id)
        SELECT e.Id
        FROM #ExportObjects e
        WHERE (e.Type = 0)
    INSERT INTO @ExportObjectOrdered (Id)
    SELECT e.Id
    FROM #ExportObjects e
    WHERE (e.Type = 11
            OR e.Type = 12
            OR e.Type = 13
            OR e.Type = 14) AND
    NOT EXISTS (
        SELECT ParentWebId
        FROM #ExportObjects e2
        WHERE e.ParentWebId = e2.Id)
    ORDER BY e.Type
    INSERT INTO @ExportObjectOrdered (Id)
    SELECT e.Id
    FROM #ExportObjects e
    WHERE ( (e.Type = 1 AND e.IsDeleted = 0) OR e.Type = 2) AND
    NOT EXISTS (
        SELECT ParentWebId
        FROM #ExportObjects e2
        WHERE e.ParentWebId = e2.Id)
    ORDER BY e.FullUrl
    INSERT INTO @ExportObjectOrdered (Id)
    SELECT e.Id
    FROM #ExportObjects e
    WHERE e.Type = 5 AND
    NOT EXISTS (
        SELECT ParentWebId
        FROM #ExportObjects e2
        WHERE e.ParentWebId = e2.Id)
    ORDER BY e.FullUrl
    INSERT INTO @ExportObjectOrdered (Id)
    SELECT e.Id
    FROM #ExportObjects e
    WHERE e.Type = 10 AND
    NOT EXISTS (
        SELECT ParentWebId
        FROM #ExportObjects e2
        WHERE e.ParentWebId = e2.Id)
    ORDER BY e.FullUrl
    INSERT INTO @ExportObjectOrdered (Id)
    SELECT e.Id
    FROM #ExportObjects e
    WHERE e.Type = 8 AND
    NOT EXISTS (
        SELECT ParentWebId
        FROM #ExportObjects e2
        WHERE e.ParentWebId = e2.Id)
    ORDER BY e.FullUrl
    INSERT INTO @ExportObjectOrdered (Id)
    SELECT e.Id
    FROM #ExportObjects e
    WHERE e.Type = 3 AND
    NOT EXISTS (
        SELECT ParentWebId
        FROM #ExportObjects e2
        WHERE e.ParentWebId = e2.Id)
    ORDER BY e.FullUrl
    INSERT INTO @ExportObjectOrdered (Id)
    SELECT e.Id
    FROM #ExportObjects e
    WHERE e.Type = 6 AND
    NOT EXISTS (
        SELECT ParentWebId
        FROM #ExportObjects e2
        WHERE e.ParentWebId = e2.Id)
    ORDER BY e.FullUrl
    INSERT INTO @ExportObjectOrdered (Id)
    SELECT e.Id
    FROM #ExportObjects e
    WHERE e.Type = 7 AND
    NOT EXISTS (
        SELECT ParentWebId
        FROM #ExportObjects e2
        WHERE e.ParentWebId = e2.Id)
    ORDER BY e.FullUrl
    INSERT INTO @ExportObjectOrdered (Id)
    SELECT e.Id
    FROM #ExportObjects e
    WHERE e.Type = 4 AND
    NOT EXISTS (
        SELECT ParentWebId
        FROM #ExportObjects e2
        WHERE e.ParentWebId = e2.Id)
    ORDER BY e.FullUrl
    INSERT INTO @ExportObjectOrdered (Id)
    SELECT e.Id
    FROM #ExportObjects e
    WHERE (e.Type = 15 OR
           e.Type = 17)
        AND NOT EXISTS (
            SELECT ParentWebId
            FROM #ExportObjects e2
            WHERE e.ParentWebId = e2.Id)
    ORDER BY e.Type
    INSERT INTO @ExportObjectOrdered (Id)
    SELECT e.Id
    FROM #ExportObjects e
    WHERE (e.Type = 16 OR
           e.Type = 18)
        AND NOT EXISTS (
            SELECT ParentWebId
            FROM #ExportObjects e2
            WHERE e.ParentWebId = e2.Id)
    ORDER BY e.EventTime
    DECLARE @WebId uniqueidentifier
    DECLARE webs CURSOR STATIC FOR
        SELECT e.Id
        FROM #ExportObjects e
        WHERE e.Type = 1 AND e.IsDeleted = 0
        ORDER BY e.FullUrl
    OPEN webs
    FETCH NEXT FROM webs INTO @WebId
    WHILE @@FETCH_STATUS = 0
    BEGIN
        INSERT INTO @ExportObjectOrdered (Id)
        VALUES(@WebId)
        INSERT INTO @ExportObjectOrdered (Id)
        SELECT e.Id
        FROM #ExportObjects e
        WHERE e.Type = 2 AND
        e.ParentWebId = @WebId
        ORDER BY e.FullUrl
        INSERT INTO @ExportObjectOrdered (Id)
        SELECT e.Id
        FROM #ExportObjects e
        WHERE e.Type = 5 AND
        e.ParentWebId = @WebId
        ORDER BY e.FullUrl
        INSERT INTO @ExportObjectOrdered (Id)
        SELECT e.Id
        FROM #ExportObjects e
        WHERE e.Type = 10 AND
        e.ParentWebId = @WebId
        ORDER BY e.FullUrl
        INSERT INTO @ExportObjectOrdered (Id)
        SELECT e.Id
        FROM #ExportObjects e
        WHERE e.Type = 8 AND
        e.ParentWebId = @WebId
        ORDER BY e.FullUrl
        INSERT INTO @ExportObjectOrdered (Id)
        SELECT e.Id
        FROM #ExportObjects e
        WHERE e.Type = 3 AND
        e.ParentWebId = @WebId
        ORDER BY e.FullUrl
        INSERT INTO @ExportObjectOrdered (Id)
        SELECT e.Id
        FROM #ExportObjects e
        WHERE e.Type = 6 AND
        e.ParentWebId = @WebId
        ORDER BY e.FullUrl
        INSERT INTO @ExportObjectOrdered (Id)
        SELECT e.Id
        FROM #ExportObjects e
        WHERE e.Type = 7 AND
        e.ParentWebId = @WebId
        ORDER BY e.FullUrl
        INSERT INTO @ExportObjectOrdered (Id)
        SELECT e.Id
        FROM #ExportObjects e
        WHERE e.Type = 4 AND
        e.ParentWebId = @WebId
        ORDER BY e.FullUrl
        INSERT INTO @ExportObjectOrdered (Id)
        SELECT e.Id
        FROM #ExportObjects e
        WHERE (e.Type = 15 OR e.Type = 17)
                AND e.ParentId = @WebId
        ORDER BY e.Type
        INSERT INTO @ExportObjectOrdered (Id)
        SELECT e.Id
        FROM #ExportObjects e
        WHERE (e.Type = 16 OR e.Type = 18)
                AND e.ParentId = @WebId
        ORDER BY e.EventTime
        INSERT INTO @ExportObjectOrdered (Id)
        SELECT e.Id
        FROM #ExportObjects e
        WHERE e.Type = 9 AND
        e.ParentWebId = @WebId
        ORDER BY e.FullUrl
        FETCH NEXT FROM webs INTO @WebId
    END
    CLOSE webs
    DEALLOCATE webs
    INSERT INTO @ExportObjectOrdered (Id)
    SELECT e.Id
    FROM #ExportObjects e
    WHERE e.Type = 1 AND
    e.IsDeleted = 1 
    ORDER BY e.FullUrl DESC
    UPDATE #ExportObjects
    SET Ordinal = ordered.Ordinal
    FROM #ExportObjects
    INNER JOIN @ExportObjectOrdered ordered
    ON #ExportObjects.Id = ordered.Id
    CREATE CLUSTERED INDEX exportobjects_ordinal
    ON #ExportObjects (Ordinal, Type, IsDeleted)
    CREATE INDEX exportobjects_parent_type
    ON #ExportObjects (ParentId, Type)
    UPDATE #ExportObjects
    SET ParentWebUrl = Webs.FullUrl
    FROM #ExportObjects e
    LEFT JOIN
        Webs
    ON e.ParentWebId = Webs.Id

GO
