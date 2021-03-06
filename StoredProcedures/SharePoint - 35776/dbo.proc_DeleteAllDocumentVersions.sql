/****** Object:  StoredProcedure [dbo].[proc_DeleteAllDocumentVersions]    Script Date: 5/15/2018 12:11:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteAllDocumentVersions(
    @DocSiteId uniqueidentifier,
    @DocDirName nvarchar(256),
    @DocLeafName nvarchar(128),
    @UserId int,
    @DeleteOp int,
    @Level tinyint)
AS
    SET NOCOUNT ON
    DECLARE @Ret int
    SET @Ret = 0
    DECLARE @ProgId nvarchar(255)
    SET @ProgId = NULL
    BEGIN TRAN
    BEGIN
        DECLARE @AuditEventData nvarchar(4000)
        DECLARE @ReturnStatus int
        IF (@Level = 2) SET @AuditEventData = STUFF(STUFF('</>', 3, 0, 'Version'), 1, 0, STUFF('<AllMinorVersions/>', 1, 0, STUFF('<>', 2, 0, 'Version')))
        ELSE IF (@Level = 1) SET @AuditEventData = STUFF(STUFF('</>', 3, 0, 'Version'), 1, 0, STUFF('<AllPreviousVersions/>', 1, 0, STUFF('<>', 2, 0, 'Version')))
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
    END
    IF (@DeleteOp = 3)
    BEGIN
        DELETE
            DocVersions
        FROM
            DocVersions
        INNER JOIN
            Docs
        ON
            DocVersions.SiteId = Docs.SiteId AND
            DocVersions.Id = Docs.Id
        WHERE
            Docs.SiteId = @DocSiteId AND
            Docs.DirName = @DocDirName AND
            Docs.LeafName = @DocLeafName AND
            Docs.Level >= @Level
        DELETE FROM
            UserDataVersioned
        WHERE
            tp_SiteId = @DocSiteId AND
            tp_DirName = @DocDirName AND
            tp_LeafName = @DocLeafName AND
            tp_IsCurrentVersion = CONVERT(bit,0) AND
            tp_Level >=@Level
        DELETE FROM
            UserDataJunctionsVersioned
        WHERE
            tp_SiteId = @DocSiteId AND
            tp_DirName = @DocDirName AND
            tp_LeafName = @DocLeafName AND
            tp_IsCurrentVersion = CONVERT(bit,0) AND
            tp_Level >= @Level
    END
    ELSE IF (@DeleteOp = 4)
    BEGIN
        DECLARE @WebId uniqueidentifier
        DECLARE @ListId uniqueidentifier
        DECLARE @DocId uniqueidentifier
        SELECT
            @WebId = WebId,
            @ListId = ListId,
            @DocId = Id,
            @ProgId = ProgId
        FROM
            Docs
        WHERE
            Docs.SiteId = @DocSiteId AND
            Docs.DirName = @DocDirName AND
            Docs.LeafName = @DocLeafName
        IF (@@ROWCOUNT = 0)
        BEGIN
            SET @Ret = 2
            GOTO cleanup
        END
        DECLARE @ListDirName nvarchar(260)
        SELECT 
            @ListDirName = CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM 
            Docs 
        WHERE 
            SiteId = @DocSiteId AND 
            Id = (SELECT tp_RootFolder FROM Lists WHERE 
                tp_WebId = @WebId AND tp_Id = @ListId)
        DECLARE @VersionsDeleted table (
            DocVersion int NOT NULL,
            DeleteTransactionId varbinary(16) NOT NULL,
            Size bigint NOT NULL,
            AuthorId int NULL DEFAULT NULL)
        INSERT INTO @VersionsDeleted (
            DocVersion,
            DeleteTransactionId,
            Size,
            AuthorId)
        SELECT
            dv.Version,
            NEWID(),
            ISNULL(dv.Size, 0) + ISNULL(dv.MetaInfoSize, 0) + ISNULL(u.tp_Size, 0),
            u.tp_Editor
        FROM
            DocVersions as dv
        INNER JOIN 
            Docs as d
        ON
            d.Id = dv.Id AND
            d.IsCurrentVersion = 1
        LEFT OUTER JOIN
            UserDataVersioned as u
        ON
            dv.SiteId = u.tp_SiteId AND
            d.DirName = u.tp_DirName AND
            d.LeafName = u.tp_LeafName AND
            dv.Level = u.tp_Level AND
            dv.Version = u.tp_UIVersion AND            
            u.tp_RowOrdinal = 0
        WHERE
            dv.SiteId = @DocSiteId AND
            dv.Id = @DocId AND
            dv.Level >= @Level        
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
        SELECT
            @DocSiteId,
            @WebId,
            1,
            @UserId,
            DeleteTransactionId,
            dbo.fn_RoundDateToNearestSecond(GETUTCDATE()),
            2,
            @ListId,
            @DocId,
            DocVersion,
            NULL,
            @DocLeafName + ' (' + CAST(DocVersion/512 AS nvarchar(10)) + 
                '.' + CAST(DocVersion%512 AS nvarchar(10)) + ')',
            @DocDirName,
            @DocLeafName,
            AuthorId,
            Size,
            @ListDirName,
            NULL,
            @ProgId
        FROM
            @VersionsDeleted
        UPDATE
            DocVersions
        SET
            DeleteTransactionId = 
                (SELECT
                    DeleteTransactionId
                FROM
                    @VersionsDeleted
                WHERE
                    DocVersions.Version = DocVersion
                )    
        WHERE
            DocVersions.SiteId = @DocSiteId AND
            DocVersions.Id = @DocId AND
            DocVersions.Level >= @Level
        UPDATE
            UserDataVersioned
        SET
            tp_DeleteTransactionId = 
                (SELECT
                    DeleteTransactionId
                FROM
                    @VersionsDeleted
                WHERE
                    UserDataVersioned.tp_CalculatedVersion = DocVersion
                )    
        WHERE
            tp_SiteId = @DocSiteId AND
            tp_DirName = @DocDirName AND
            tp_LeafName = @DocLeafName AND
            tp_IsCurrentVersion = CONVERT(bit,0) AND
	    tp_Level >= @Level
        UPDATE
            UserDataJunctionsVersioned
        SET
            tp_DeleteTransactionId = 
                (SELECT
                    DeleteTransactionId
                FROM
                    @VersionsDeleted
                WHERE
                    UserDataJunctionsVersioned.tp_CalculatedVersion = DocVersion
                )    
        WHERE
            tp_SiteId = @DocSiteId AND
            tp_DirName = @DocDirName AND
            tp_LeafName = @DocLeafName AND
            tp_IsCurrentVersion = CONVERT(bit,0) AND
            tp_Level >= @Level
    END
    ELSE
    BEGIN
        SET @Ret = 1359
    END
cleanup:
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Ret

GO
