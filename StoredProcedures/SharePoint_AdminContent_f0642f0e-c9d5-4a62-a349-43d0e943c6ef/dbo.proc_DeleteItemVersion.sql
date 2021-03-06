/****** Object:  StoredProcedure [dbo].[proc_DeleteItemVersion]    Script Date: 5/15/2018 12:12:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteItemVersion(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @ItemId int,
    @ItemVersion int,
    @UserId int,
    @UseNvarchar1ItemName bit = 1,
    @DeleteOp int = 3)
AS
    DECLARE @ReturnStatus int
    DECLARE @DeleteTransactionId varbinary(16)
    SET @ReturnStatus = 1359
    SET @DeleteTransactionId = 0x
    BEGIN TRAN
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    DECLARE @Size bigint
    DECLARE @ItemName nvarchar(255)
    DECLARE @AuthorId int
    DECLARE @AuditEventData nvarchar(4000)
    SELECT
        @DirName = tp_DirName,
        @LeafName = tp_LeafName,
        @Size = CAST(ISNULL(tp_Size, 0) AS BIGINT),
        @ItemName = 
            CASE 
                WHEN @UseNvarchar1ItemName = 1 AND nvarchar1 IS NOT NULL THEN nvarchar1 
                ELSE CAST(tp_Id AS NVARCHAR(10)) 
            END,
        @AuthorId = tp_Editor
    FROM
        UserDataVersioned
    WHERE
        tp_ListId = @ListId AND
        tp_Id = @ItemId AND
        tp_CalculatedVersion = @ItemVersion
    SET @AuditEventData = STUFF(STUFF('</>', 3, 0, 'Version'), 1, 0, STUFF(STUFF(STUFF('</>', 3, 0, 'Major'), 1, 0, STUFF(@ItemVersion/512, 1, 0, STUFF('<>', 2, 0, 'Major'))) + STUFF(STUFF('</>', 3, 0, 'Minor'), 1, 0, STUFF(@ItemVersion%512, 1, 0, STUFF('<>', 2, 0, 'Minor'))), 1, 0, STUFF('<>', 2, 0, 'Version')))
    IF (@DeleteOp = 3) SET @AuditEventData = @AuditEventData + '<Recycle>0<Recycle>'
    ELSE IF (@DeleteOp = 4) SET @AuditEventData = @AuditEventData + '<Recycle>1<Recycle>'
    EXEC @ReturnStatus = proc_AddAuditEntryFromSql
            @SiteId,
            @DirName,
            @LeafName,
            3,
            @UserId,                
            4,
            @AuditEventData,
            0x00000008
    IF @ReturnStatus <> 0 GOTO cleanup
    IF (@DeleteOp = 3)
    BEGIN
        DELETE FROM
            UserDataVersioned
        WHERE
            tp_ListId = @ListId AND
            tp_Id = @ItemId AND
            tp_CalculatedVersion = @ItemVersion
        IF @@ROWCOUNT = 0
        BEGIN
            SET @ReturnStatus = 2
            GOTO cleanup
        END
        SET @ReturnStatus = 0
    END
    ELSE IF (@DeleteOp = 4)
    BEGIN
        SET @DeleteTransactionId = NEWID()
        DECLARE @ListDirName nvarchar(256)
        SELECT 
            @ListDirName = CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM 
            Docs 
        WHERE 
            SiteId = @SiteId AND 
            Id = (SELECT tp_RootFolder FROM Lists WHERE 
                tp_WebId = @WebId AND tp_Id = @ListId)
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
            ScopeId)
        VALUES (
            @SiteId,
            @WebId,
            1,
            @UserId,
            @DeleteTransactionId,
            dbo.fn_RoundDateToNearestSecond(GETUTCDATE()),
            8,
            @ListId,
            NULL,
            @ItemVersion,
            @ItemId,
            @ItemName + ' (' + CAST(@ItemVersion/512 AS nvarchar(10)) + 
                         '.' + CAST(@ItemVersion%512 AS nvarchar(10)) + ')',
            @DirName,
            @LeafName,
            @AuthorId,
            @Size,
            @ListDirName,
            NULL)   
        UPDATE 
            UserDataVersioned
        SET
            tp_DeleteTransactionId = @DeleteTransactionId
        WHERE
            tp_ListId = @ListId AND
            tp_ID = @ItemId AND
            tp_CalculatedVersion = @ItemVersion
        SET @ReturnStatus = 0
    END
    EXEC proc_DeleteItemJunctionsVersion @ListId, @ItemId, @ItemVersion, @DeleteOp, @DeleteTransactionId
cleanup:
    IF (@ReturnStatus <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @ReturnStatus

GO
