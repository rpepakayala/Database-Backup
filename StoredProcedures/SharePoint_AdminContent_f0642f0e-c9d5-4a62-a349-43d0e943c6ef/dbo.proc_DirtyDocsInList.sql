/****** Object:  StoredProcedure [dbo].[proc_DirtyDocsInList]    Script Date: 5/15/2018 12:12:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_DirtyDocsInList(
    @WebId uniqueidentifier,
    @ListId uniqueidentifier
    )
AS
    SET NOCOUNT ON
    DECLARE @siteId uniqueidentifier
    DECLARE @dirName nvarchar(260)
    DECLARE @dirNameLike nvarchar(1024)
    SELECT
        @siteId = Docs.SiteId,
        @dirName = CASE
            WHEN Docs.DirName = '' THEN Docs.LeafName
            ELSE Docs.DirName + '/' + Docs.LeafName
            END
    FROM
        Docs
    JOIN
        Lists
    ON
        Lists.tp_WebId = @WebId AND
        Lists.tp_Id = @ListId AND
        Lists.tp_RootFolder = Docs.Id
    IF @@ROWCOUNT = 1
    BEGIN
        EXEC proc_EscapeForLike @dirName, @dirNameLike OUTPUT
        UPDATE
            Docs
        SET
            Dirty = 1,
            DocFlags = CASE
                WHEN HasStream = 1 THEN DocFlags
                ELSE (DocFlags | 16384)
            END
        FROM
            Docs
        WHERE
            Docs.SiteId  = @siteId AND 
            (Docs.DirName = @dirName OR
             Docs.DirName LIKE @dirNameLike) AND
            Docs.Type = 0 AND
            Docs.DocFlags & 4 = 4 AND
            Docs.ListId = @ListID AND
            (Docs.HasStream = 1 OR Docs.LeafName NOT LIKE '%.aspx') AND
            ((Docs.DocLibRowId IS NOT NULL AND  Docs.HasStream = 1) OR  
             (Docs.DocLibRowId IS NULL))                                
        UPDATE
            AllDocs
        SET
            Dirty = 1
        FROM
            AllDocs INNER JOIN RecycleBin
        ON
            AllDocs.SiteId = @siteId AND
            AllDocs.DeleteTransactionId = RecycleBin.DeleteTransactionId AND
            AllDocs.DeleteTransactionId > 0x 
        WHERE
            AllDocs.SiteId  = @siteId AND 
            (AllDocs.DirName = @dirName OR
            AllDocs.DirName LIKE @dirNameLike) AND
            AllDocs.Type = 0 AND
            AllDocs.DocFlags & 4 = 4 AND
            AllDocs.ListId = @ListId AND
            (AllDocs.HasStream = 1 OR AllDocs.LeafName NOT LIKE '%.aspx') AND
            ((AllDocs.DocLibRowId IS NOT NULL AND  AllDocs.HasStream = 1) OR  
             (AllDocs.DocLibRowId IS NULL))                                   
    END     

GO
