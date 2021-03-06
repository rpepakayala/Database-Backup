/****** Object:  StoredProcedure [dbo].[proc_DeleteDocumentVersion]    Script Date: 5/15/2018 12:11:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteDocumentVersion(
    @DocSiteId uniqueidentifier,
    @DocDirName nvarchar(256),
    @DocLeafName nvarchar(128),
    @DocVersion int,
    @UserId int,
    @DeleteOp int)
AS
    DECLARE @ReturnStatus int
    SET @ReturnStatus = 1359
    DECLARE @ProgId nvarchar(255)
    SET @ProgId = NULL
    BEGIN TRAN
    DECLARE @WebId uniqueidentifier
    DECLARE @ListId uniqueidentifier
    DECLARE @ItemId int
    DECLARE @DocId uniqueidentifier
    DECLARE @AuditEventData nvarchar(4000)
    SET @AuditEventData = STUFF(STUFF('</>', 3, 0, 'Version'), 1, 0, STUFF(STUFF(STUFF('</>', 3, 0, 'Major'), 1, 0, STUFF(@DocVersion/512, 1, 0, STUFF('<>', 2, 0, 'Major'))) + STUFF(STUFF('</>', 3, 0, 'Minor'), 1, 0, STUFF(@DocVersion%512, 1, 0, STUFF('<>', 2, 0, 'Minor'))), 1, 0, STUFF('<>', 2, 0, 'Version')))
    IF (@DeleteOp = 3) SET @AuditEventData = @AuditEventData + '<Recycle>0<Recycle>'
    ELSE IF (@DeleteOp = 4) SET @AuditEventData = @AuditEventData + '<Recycle>1<Recycle>'
    EXEC @ReturnStatus = proc_AddAuditEntryFromSql
            @DocSiteId,
            @DocDirName,
            @DocLeafName,
            1,
            @UserId,                
            4,
            @AuditEventData,
            0x00000008
    IF @ReturnStatus <> 0 GOTO cleanup
    SELECT TOP 1
        @WebId = WebId,
        @ListId = ListId,
        @ItemId = DoclibRowId,
        @DocId = Id,
        @ProgId = ProgId
    FROM
        Docs
    WHERE
        Docs.SiteId = @DocSiteId AND
        Docs.DirName = @DocDirName AND
        Docs.LeafName = @DocLeafName
    IF EXISTS (SELECT
            *
            FROM
                Docs 
            WHERE
                Docs.SiteId = @DocSiteId AND
                Docs.DirName = @DocDirName AND
                Docs.LeafName = @DocLeafName AND
                Docs.UIVersion = @DocVersion)
    BEGIN
        SET @ReturnStatus = 186
        GOTO cleanup
    END
    IF (@DeleteOp = 3)
    BEGIN
        DELETE FROM
            DocVersions
        WHERE
            SiteId = @DocSiteId AND
            Id = @DocId AND
            Version = @DocVersion
        IF @@ROWCOUNT = 0
        BEGIN        
            SET @ReturnStatus = 2
            GOTO cleanup
        END
        IF @ListId IS NOT NULL AND @ItemId IS NOT NULL
        BEGIN
            DELETE FROM
                AllUserData
            WHERE
                tp_ListId = @ListId AND
                tp_ID = @ItemId AND
                tp_CalculatedVersion = @DocVersion
        END
        EXEC proc_UpdateDiskUsed @DocSiteId
        SET @ReturnStatus = 0
    END
    ELSE IF (@DeleteOp = 4)
    BEGIN
        DECLARE @DeleteTransactionId varbinary(16)
        SET @DeleteTransactionId = NEWID()
        DECLARE @ListDirName nvarchar(256)
        SELECT 
            @ListDirName = CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM 
            Docs 
        WHERE 
            SiteId = @DocSiteId AND 
            Id = (SELECT tp_RootFolder FROM Lists WHERE 
                tp_WebId = @WebId AND tp_Id = @ListId)
        DECLARE @AuthorId int
        DECLARE @Size bigint
        SET @Size = (
            SELECT
                (ISNULL((SUM(CAST((ISNULL(Size, 0) + ISNULL(MetaInfoSize, 0)) AS BIGINT))),0))
            FROM
                DocVersions
            WHERE
                DocVersions.SiteId = @DocSiteId AND
                DocVersions.Id = @DocId AND
                DocVersions.Version = @DocVersion)
        IF @ListId IS NOT NULL AND @ItemId IS NOT NULL
        BEGIN
            SELECT
                @Size = @Size + ISNULL(tp_Size, 0),
                @AuthorId = tp_Editor
            FROM
                UserDataVersioned
            WHERE
                tp_ListId = @ListId AND
                tp_ID = @ItemId AND
                tp_CalculatedVersion = @DocVersion
        END
        INSERT INTO RecycleBin (
            SiteId,
            WebId,
            BinId,
            DeleteUserId,
            DeleteTransactionId,
            DeleteDate,
            ItemType,
            ListId,
            DocId,
            DocVersionId,
            ListItemId,
            Title,
            DirName,
            LeafName,
            AuthorId,
            Size,
            ListDirName,
            ScopeId,
            ProgId)
        VALUES (
            @DocSiteId,
            @WebId,
            1,
            @UserId,
            @DeleteTransactionId,
            dbo.fn_RoundDateToNearestSecond(GETUTCDATE()),
            2,
            @ListId,
            @DocId,
            @DocVersion,
            NULL,
            @DocLeafName + ' (' + CAST(@DocVersion/512 AS nvarchar(10)) + 
                '.' + CAST(@DocVersion%512 AS nvarchar(10)) + ')',
            @DocDirName,
            @DocLeafName,
            @AuthorId,
            @Size,
            @ListDirName,
            NULL,
            @ProgId)
        UPDATE
            DocVersions
        SET
            DeleteTransactionId = @DeleteTransactionId
        WHERE
            DocVersions.SiteId = @DocSiteId AND
            DocVersions.Id = @DocId AND
            DocVersions.Version = @DocVersion
        IF @@ROWCOUNT = 0
        BEGIN
            SET @ReturnStatus = 2
            GOTO cleanup
        END    
        IF @ListId IS NOT NULL AND @ItemId IS NOT NULL
        BEGIN
            UPDATE 
                UserDataVersioned
            SET
                tp_DeleteTransactionId = @DeleteTransactionId
            WHERE
                tp_ListId = @ListId AND
                tp_ID = @ItemId AND
                tp_CalculatedVersion = @DocVersion
        END
        SET @ReturnStatus = 0
    END
cleanup:
    IF (@ReturnStatus <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @ReturnStatus

GO
