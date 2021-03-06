/****** Object:  StoredProcedure [dbo].[proc_DeplGetFolderById]    Script Date: 5/15/2018 12:11:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetFolderById(
    @SiteId uniqueidentifier,
    @FolderId uniqueidentifier,
    @DeleteRecycleBinItems bit = 0)
AS
    SET NOCOUNT ON
    IF @SiteId IS NULL OR @FolderId IS NULL
        RETURN 87
    IF EXISTS(
        SELECT 1
        FROM Docs
        WHERE
            Docs.Id = @FolderId AND
            Docs.SiteId <> @SiteId)
        RETURN 80
    DECLARE @DeleteTransactionId varbinary(16)
    DECLARE @QuerySiteId uniqueidentifier
    SELECT TOP 1
        @QuerySiteId = AllDocs.SiteId,
        @DeleteTransactionId = AllDocs.DeleteTransactionId
    FROM AllDocs
    WHERE
        AllDocs.Id = @FolderId AND
        AllDocs.DeleteTransactionId <> 0x
     IF @@RowCount <> 0
     BEGIN
        IF @QuerySiteId = @SiteId AND
           @DeleteRecycleBinItems = 1
        BEGIN
            EXEC proc_DeleteRecycleBinItem
                 @SiteId, '00000000-0000-0000-0000-000000000000', 0, @DeleteTransactionId
        END
        ELSE
        BEGIN
            RETURN 30001
        END
     END
    IF EXISTS(
        SELECT 1
        FROM AllDocs
        WHERE
            AllDocs.Id = @FolderId AND
            AllDocs.DeleteTransactionId <> 0x)
        RETURN 30001
    SELECT
        Docs.WebId,
        '/' +
        CASE
            WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName
            WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName
            ELSE Docs.DirName + N'/' + Docs.LeafName
        END as Url
    FROM
        Docs
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.Id = @FolderId
    RETURN 0

GO
