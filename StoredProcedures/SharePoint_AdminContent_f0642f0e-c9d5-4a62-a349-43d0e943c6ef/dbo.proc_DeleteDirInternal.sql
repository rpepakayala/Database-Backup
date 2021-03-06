/****** Object:  StoredProcedure [dbo].[proc_DeleteDirInternal]    Script Date: 5/15/2018 12:12:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteDirInternal(
    @WebSiteId       uniqueidentifier,
    @WebId           uniqueidentifier,
    @Url             nvarchar(260),
    @UserId          int,
    @ListDeletedUrls bit,
    @ListDeletedAliases bit,
    @DeleteOp        int,
    @DoclibId        uniqueidentifier,
    @DoclibRowId     int,
    @DocId           uniqueidentifier,
    @UrlLike         nvarchar(1024),
    @DeleteDirName   nvarchar(256),
    @DeleteLeafName  nvarchar(256),
    @ItemName        nvarchar(255),
    @DeleteDTM       datetime,
    @ScopeId         uniqueidentifier,
    @ProgId          nvarchar(255),
    @BinId           tinyint,
    @ShowUserName    bit,
    @DeleteTransactionId varbinary(16) OUTPUT,
    @Size            bigint OUTPUT,
    @NewDeleteTransaction bit OUTPUT,
    @ItemCountDelta  int OUTPUT,
    @FreedSpace      bigint OUTPUT
    )
AS
    DECLARE @ReturnStatus int
    SET @ReturnStatus = 0
    DECLARE @NumLists int
    DECLARE @Collation smallint
    DECLARE @ListsDeleted table (
        Id uniqueidentifier NOT NULL,
        Flags bigint NOT NULL)
    INSERT INTO @ListsDeleted(
        Id,
        Flags)
    SELECT
        Lists.tp_Id,
        Lists.tp_Flags
    FROM
        Lists WITH (XLOCK)
    WHERE
        Lists.tp_WebId = @WebId AND
        Lists.tp_ID = @DoclibId AND
        Lists.tp_RootFolder = @DocId
    SET @NumLists = @@ROWCOUNT
    DECLARE @ListId uniqueidentifier
    DECLARE @DeleteItemType tinyint
    IF @NumLists = 1
    BEGIN
        SELECT
            @ListId = Id
        FROM
            @ListsDeleted
        SET @DeleteItemType = 4
        EXEC proc_LogChange @WebSiteId, @WebId, @ListId, NULL, NULL, NULL,
            NULL, @Url, 16384,  2,
            @DeleteDTM
    END    
    ELSE
    BEGIN
        INSERT INTO @ListsDeleted(
            Id,
            Flags)
        SELECT
            Lists.tp_Id,
            Lists.tp_Flags
        FROM
            Docs
        INNER JOIN
            Lists WITH (XLOCK)
        ON
            Lists.tp_WebId = @WebId AND
            Lists.tp_ID = Docs.ListId AND
            Lists.tp_RootFolder = Docs.ID
        WHERE
            Lists.tp_WebId = @WebId AND
            Docs.SiteId = @WebSiteId AND
            (Docs.DirName = @Url OR
                Docs.DirName LIKE @UrlLike) AND
            Docs.Type = 1
        IF (@@ROWCOUNT > 0)
            SET @DeleteItemType = 6
        ELSE    
            SET @DeleteItemType = 5
    END
    IF EXISTS(
        SELECT
            *
        FROM
            @ListsDeleted
        WHERE
            (Flags & 0x04) <> 0)
    BEGIN
        SET @ReturnStatus = 8398
        GOTO cleanup
    END
    IF @DeleteOp = 4 AND
        @DeleteTransactionId = 0x
    BEGIN
        DECLARE @AuthorId int
        DECLARE @Title nvarchar(260)
        IF @NumLists = 1
        BEGIN
            SELECT
                @AuthorId = tp_Author,
                @Title = tp_Title
            FROM
                Lists
            WHERE
                Lists.tp_WebId = @WebId AND
                Lists.tp_ID = @DoclibId
        END
        ELSE
        BEGIN
            SELECT
                @AuthorId = tp_Author
            FROM
                UserData
            WHERE
                tp_ListId = @DoclibId AND
                tp_ID = @DoclibRowId
            SET @Title = @DeleteLeafName    
        END
        DECLARE @ListDirName nvarchar(256)
        IF @DeleteItemType = 5
        BEGIN
            SELECT 
                @ListDirName = CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
            FROM 
                Docs 
            WHERE 
                SiteId = @WebSiteId AND 
                Id = (
                    SELECT 
                        tp_RootFolder 
                    FROM 
                        Lists 
                    WHERE 
                        tp_WebId = @WebId AND 
                        tp_Id = @DoclibId)
        END
        SET @NewDeleteTransaction = 1
        SET @DeleteTransactionId = NEWID()
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
            @WebSiteId,
            @WebId,
            @BinId,
            @UserId,
            @DeleteTransactionId,
            @DeleteDTM,
            @DeleteItemType,
            @DoclibId,
            CASE
                WHEN (@DeleteItemType = 4) THEN NULL
                ELSE @DocId
            END,
            NULL,
            @DoclibRowId,
            ISNULL(@Title,''),
            @DeleteDirName,
            @DeleteLeafName,
            CASE WHEN @ShowUserName = 1 THEN @AuthorId ELSE NULL END,
            0,
            @ListDirName,
            @ScopeId,
            @ProgId)
    END
    IF @ListDeletedUrls = 1
    BEGIN
        SELECT
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END, Type
        FROM
            Docs
        WHERE
            SiteId = @WebSiteId AND
            (DirName = @Url OR
                DirName LIKE @UrlLike) AND
            (Type = 0 OR
                Type = 1)
        UNION ALL
        SELECT
            @Url, 1 
    END
    IF @ListDeletedAliases = 1
    BEGIN
        SELECT
            @WebSiteId, tp_WebId, tp_Id
        FROM
            Lists
        WHERE
            tp_EmailAlias IS NOT NULL AND
            tp_Id
        IN
            (SELECT LD.Id FROM @ListsDeleted LD)
    END
    EXEC proc_DirtyDependents @WebSiteId, 1, NULL, @UrlLike
    IF @DoclibRowId IS NOT NULL
    BEGIN
        IF @ItemName IS NULL
           SET @ItemName = @DeleteLeafName
        EXEC proc_AddEventToCacheForDeleteRestore
            @WebSiteId, 
            @WebId, 
            @DoclibId,
            @DoclibRowId,
            @ItemName,
            @Url,
            @DocId,
            16388,
            @UserId,
            @DeleteDTM,
            NULL,
            NULL
        DECLARE @DocLibRowsDeleted table (
            Id int NOT NULL)
        INSERT INTO @DocLibRowsDeleted(
            Id)
        VALUES(
            @DoclibRowId)
        INSERT INTO @DocLibRowsDeleted(
            Id)
        SELECT
            Docs.DoclibRowId
        FROM
            Docs
        WHERE
            Docs.SiteId = @WebSiteId AND
            (Docs.DirName = @Url OR
                Docs.DirName LIKE @UrlLike) AND
            Docs.DoclibRowId IS NOT NULL    
        IF (@DeleteOp = 3)
        BEGIN
            DELETE FROM
                UserDataVersioned
            WHERE
                tp_ListId = @DoclibId AND
                tp_ID
            IN
                (SELECT Id FROM @DocLibRowsDeleted)
            DELETE NVP FROM
                NameValuePair AS NVP
            WHERE
                SiteId = @WebSiteId AND
                ListId = @DoclibId AND
                ItemId
            IN
                (SELECT Id FROM @DocLibRowsDeleted)
            EXEC proc_GetCollation @ListId, @Collation OUTPUT
    IF @Collation = 0
    BEGIN
        DELETE NVP FROM
            NameValuePair_Albanian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 1
    BEGIN
        DELETE NVP FROM
            NameValuePair_Arabic_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 2
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_PRC_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 3
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_PRC_Stroke_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 4
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_Taiwan_Bopomofo_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 5
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_Taiwan_Stroke_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 6
    BEGIN
        DELETE NVP FROM
            NameValuePair_Croatian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 7
    BEGIN
        DELETE NVP FROM
            NameValuePair_Cyrillic_General_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 8
    BEGIN
        DELETE NVP FROM
            NameValuePair_Czech_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 9
    BEGIN
        DELETE NVP FROM
            NameValuePair_Danish_Norwegian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 10
    BEGIN
        DELETE NVP FROM
            NameValuePair_Estonian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 11
    BEGIN
        DELETE NVP FROM
            NameValuePair_Finnish_Swedish_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 12
    BEGIN
        DELETE NVP FROM
            NameValuePair_French_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 13
    BEGIN
        DELETE NVP FROM
            NameValuePair_Georgian_Modern_Sort_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 14
    BEGIN
        DELETE NVP FROM
            NameValuePair_German_PhoneBook_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 15
    BEGIN
        DELETE NVP FROM
            NameValuePair_Greek_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 16
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hebrew_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 17
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hindi_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 18
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hungarian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 19
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hungarian_Technical_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 20
    BEGIN
        DELETE NVP FROM
            NameValuePair_Icelandic_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 21
    BEGIN
        DELETE NVP FROM
            NameValuePair_Japanese_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 22
    BEGIN
        DELETE NVP FROM
            NameValuePair_Japanese_Unicode_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 23
    BEGIN
        DELETE NVP FROM
            NameValuePair_Korean_Wansung_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 24
    BEGIN
        DELETE NVP FROM
            NameValuePair_Korean_Wansung_Unicode_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 25
    BEGIN
        DELETE NVP FROM
            NameValuePair_Latin1_General_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 26
    BEGIN
        DELETE NVP FROM
            NameValuePair_Latvian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 27
    BEGIN
        DELETE NVP FROM
            NameValuePair_Lithuanian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 28
    BEGIN
        DELETE NVP FROM
            NameValuePair_Lithuanian_Classic_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 29
    BEGIN
        DELETE NVP FROM
            NameValuePair_Traditional_Spanish_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 30
    BEGIN
        DELETE NVP FROM
            NameValuePair_Modern_Spanish_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 31
    BEGIN
        DELETE NVP FROM
            NameValuePair_Polish_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 32
    BEGIN
        DELETE NVP FROM
            NameValuePair_Romanian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 33
    BEGIN
        DELETE NVP FROM
            NameValuePair_Slovak_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 34
    BEGIN
        DELETE NVP FROM
            NameValuePair_Slovenian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 35
    BEGIN
        DELETE NVP FROM
            NameValuePair_Thai_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 36
    BEGIN
        DELETE NVP FROM
            NameValuePair_Turkish_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 37
    BEGIN
        DELETE NVP FROM
            NameValuePair_Ukrainian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
    ELSE
    IF @Collation = 38
    BEGIN
        DELETE NVP FROM
            NameValuePair_Vietnamese_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId = @DoclibId AND ItemId IN (SELECT Id FROM @DocLibRowsDeleted)
    END
            DELETE FROM
                ImmedSubscriptions
            WHERE
                SiteId = @WebSiteId AND
                ListId = @DoclibId AND
                ItemId
            IN
                (SELECT Id FROM @DocLibRowsDeleted)
            DELETE FROM
                SchedSubscriptions
            WHERE
                SiteId = @WebSiteId AND
                ListId = @DoclibId AND
                ItemId
            IN
                (SELECT Id FROM @DocLibRowsDeleted)
        END
        ELSE
        BEGIN
            SET @Size = @Size + (
                SELECT
                    (ISNULL((SUM(CAST((ISNULL(tp_Size, 0)) AS BIGINT))),0))
                FROM    
                    UserDataVersioned
                WHERE
                    tp_ListId = @DoclibId AND
                    tp_ID
                IN
                    (SELECT Id FROM @DocLibRowsDeleted))
            UPDATE
                UserDataVersioned
            SET
                tp_DeleteTransactionId = @DeleteTransactionId
            WHERE
                tp_ListId = @DoclibId AND
                tp_ID
            IN
                (SELECT Id FROM @DocLibRowsDeleted)
            UPDATE
                ImmedSubscriptions
            SET
                Deleted = 1
            WHERE
                SiteId = @WebSiteId AND
                ListId = @DoclibId AND
                ItemId
            IN
                (SELECT Id FROM @DocLibRowsDeleted)
            UPDATE
                SchedSubscriptions
            SET
                Deleted = 1
            WHERE
                SiteId = @WebSiteId AND
                ListId = @DoclibId AND
                ItemId
            IN
                (SELECT Id FROM @DocLibRowsDeleted)
        END
    END
    ELSE IF (@DeleteItemType != 4)
    BEGIN
        EXEC proc_LogChange @WebSiteId, @WebId, NULL, NULL, @DocId,
            NULL, NULL, @Url, 16384,
            32, @DeleteDTM 
    END
    EXEC proc_NavStructDeleteNodesByUrlDir @WebSiteId, @DeleteDirName,
        @DeleteLeafName, @Url, @UrlLike
    DECLARE @DocsDeleted table (
        Id uniqueidentifier NOT NULL,
        DocType tinyint NULL,
        DoclibRowId int NULL,
        IsCurrentVersion bit NULL)
    INSERT INTO @DocsDeleted(
        Id,
        DocType,
        DoclibRowId,
        IsCurrentVersion)
    SELECT
        Id,
        Type,
        DoclibRowId,
        IsCurrentVersion
    FROM
        Docs
    WHERE
        Docs.SiteId = @WebSiteId AND
        (Docs.DirName = @Url OR
            Docs.DirName LIKE @UrlLike)
    SET @ItemCountDelta = 
        (SELECT
            COUNT(*)
        FROM
            @DocsDeleted
        WHERE
            DoclibRowId IS NOT NULL AND
            IsCurrentVersion = 1 
            )
    IF (@DeleteOp = 3)
    BEGIN
        DECLARE @TransactionsDeleted table (
            DeleteTransactionId varbinary(16),
            BinId tinyint,
            Size bigint)
        IF @DeleteItemType = 4 OR
            @DeleteItemType = 6
        BEGIN
            INSERT INTO @TransactionsDeleted 
                (DeleteTransactionId, BinId, Size)
            SELECT
                DeleteTransactionId, BinId, Size
            FROM
                RecycleBin
            WHERE
                ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
            INSERT INTO @DocsDeleted 
                (Id, IsCurrentVersion)
            SELECT
                Id, IsCurrentVersion
            FROM
                AllDocs
            WHERE
                SiteId = @WebSiteId AND
                DeleteTransactionId IN (SELECT DeleteTransactionId FROM @TransactionsDeleted)
        END
        IF @DeleteItemType = 5
        BEGIN
            INSERT INTO @TransactionsDeleted 
                (DeleteTransactionId, BinId, Size)
            SELECT
                RecycleBin.DeleteTransactionId,
                RecycleBin.BinId,
                RecycleBin.Size
            FROM
                AllDocVersions
            INNER JOIN
                RecycleBin
            ON
                AllDocVersions.DeleteTransactionId = RecycleBin.DeleteTransactionId
            WHERE
                AllDocVersions.SiteId = @WebSiteId AND
                AllDocVersions.Id IN (SELECT Id FROM @DocsDeleted) AND
                AllDocVersions.DeleteTransactionId <> 0x AND
                RecycleBin.ListId = @ListId
        END
        ELSE IF @DeleteItemType = 6
        BEGIN
            INSERT INTO @TransactionsDeleted 
                (DeleteTransactionId, BinId, Size)
            SELECT
                RecycleBin.DeleteTransactionId,
                RecycleBin.BinId,
                RecycleBin.Size
            FROM
                AllDocVersions
            INNER JOIN
                RecycleBin
            ON
                AllDocVersions.DeleteTransactionId = RecycleBin.DeleteTransactionId
            WHERE
                AllDocVersions.SiteId = @WebSiteId AND
                AllDocVersions.Id IN (SELECT Id FROM @DocsDeleted) AND
                AllDocVersions.DeleteTransactionId <> 0x AND
                RecycleBin.ListId IS NULL
        END
        SET @FreedSpace = @FreedSpace + ISNULL((
            SELECT
                SUM(Size)
            FROM
                @TransactionsDeleted
            WHERE
                BinId = 1),0)
        DELETE FROM
            AllUserData
        WHERE
            tp_ListId
        IN
            (SELECT LD.Id FROM @ListsDeleted LD)
        DELETE NVP FROM
            NameValuePair AS NVP
        WHERE
            SiteId = @WebSiteId AND
            ListId
        IN
            (SELECT LD.Id FROM @ListsDeleted LD)
        EXEC proc_GetCollation @ListId, @Collation OUTPUT
    IF @Collation = 0
    BEGIN
        DELETE NVP FROM
            NameValuePair_Albanian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 1
    BEGIN
        DELETE NVP FROM
            NameValuePair_Arabic_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 2
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_PRC_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 3
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_PRC_Stroke_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 4
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_Taiwan_Bopomofo_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 5
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_Taiwan_Stroke_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 6
    BEGIN
        DELETE NVP FROM
            NameValuePair_Croatian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 7
    BEGIN
        DELETE NVP FROM
            NameValuePair_Cyrillic_General_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 8
    BEGIN
        DELETE NVP FROM
            NameValuePair_Czech_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 9
    BEGIN
        DELETE NVP FROM
            NameValuePair_Danish_Norwegian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 10
    BEGIN
        DELETE NVP FROM
            NameValuePair_Estonian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 11
    BEGIN
        DELETE NVP FROM
            NameValuePair_Finnish_Swedish_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 12
    BEGIN
        DELETE NVP FROM
            NameValuePair_French_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 13
    BEGIN
        DELETE NVP FROM
            NameValuePair_Georgian_Modern_Sort_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 14
    BEGIN
        DELETE NVP FROM
            NameValuePair_German_PhoneBook_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 15
    BEGIN
        DELETE NVP FROM
            NameValuePair_Greek_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 16
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hebrew_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 17
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hindi_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 18
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hungarian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 19
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hungarian_Technical_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 20
    BEGIN
        DELETE NVP FROM
            NameValuePair_Icelandic_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 21
    BEGIN
        DELETE NVP FROM
            NameValuePair_Japanese_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 22
    BEGIN
        DELETE NVP FROM
            NameValuePair_Japanese_Unicode_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 23
    BEGIN
        DELETE NVP FROM
            NameValuePair_Korean_Wansung_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 24
    BEGIN
        DELETE NVP FROM
            NameValuePair_Korean_Wansung_Unicode_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 25
    BEGIN
        DELETE NVP FROM
            NameValuePair_Latin1_General_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 26
    BEGIN
        DELETE NVP FROM
            NameValuePair_Latvian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 27
    BEGIN
        DELETE NVP FROM
            NameValuePair_Lithuanian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 28
    BEGIN
        DELETE NVP FROM
            NameValuePair_Lithuanian_Classic_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 29
    BEGIN
        DELETE NVP FROM
            NameValuePair_Traditional_Spanish_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 30
    BEGIN
        DELETE NVP FROM
            NameValuePair_Modern_Spanish_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 31
    BEGIN
        DELETE NVP FROM
            NameValuePair_Polish_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 32
    BEGIN
        DELETE NVP FROM
            NameValuePair_Romanian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 33
    BEGIN
        DELETE NVP FROM
            NameValuePair_Slovak_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 34
    BEGIN
        DELETE NVP FROM
            NameValuePair_Slovenian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 35
    BEGIN
        DELETE NVP FROM
            NameValuePair_Thai_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 36
    BEGIN
        DELETE NVP FROM
            NameValuePair_Turkish_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 37
    BEGIN
        DELETE NVP FROM
            NameValuePair_Ukrainian_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
    ELSE
    IF @Collation = 38
    BEGIN
        DELETE NVP FROM
            NameValuePair_Vietnamese_CI_AS AS NVP
        WHERE SiteId = @WebSiteId AND ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
    END
        DELETE FROM
            WebPartLists
        WHERE
            tp_SiteId = @WebSiteId AND
            tp_PageUrlId
        IN
            (SELECT Id FROM @DocsDeleted)
        DELETE FROM
            WebPartLists
        WHERE
            tp_ListId
        IN
            (SELECT LD.Id FROM @ListsDeleted LD)
        DELETE FROM
            WebParts
        WHERE
            tp_SiteId = @WebSiteId AND
            tp_PageUrlId
        IN
            (SELECT Id FROM @DocsDeleted)
        DELETE FROM
            WebParts
        WHERE
            tp_ListId
        IN
            (SELECT LD.Id FROM @ListsDeleted LD)
        DELETE FROM
            ImmedSubscriptions
        WHERE
            SiteId = @WebSiteId AND
            ListId
        IN
            (SELECT LD.Id FROM @ListsDeleted LD)
        DELETE FROM
            SchedSubscriptions
        WHERE
            SiteId = @WebSiteId AND
            ListId
        IN
            (SELECT LD.Id FROM @ListsDeleted LD)
        DELETE FROM
            AllLists
        WHERE
            tp_WebId = @WebId AND
            tp_Id
        IN
            (SELECT LD.Id FROM @ListsDeleted LD)
        DELETE
            AllUserDataJunctions
        FROM
            AllUserDataJunctions AS j
        INNER JOIN
            @DocsDeleted as dd
        ON
            j.tp_SiteId = @WebSiteId AND
            j.tp_DeleteTransactionId = 0x AND
            j.tp_IsCurrentVersion = ISNULL(dd.IsCurrentVersion, CAST(1 AS bit))
        INNER JOIN
            Docs AS d
        ON
            d.SiteId = @WebSiteId AND
            d.ID = dd.ID AND
            d.DirName = j.tp_DirName AND
            d.LeafName = j.tp_LeafName
        DELETE
            AllUserDataJunctions
        FROM
            AllUserDataJunctions AS j
        INNER JOIN
            @DocsDeleted as dd
        ON
            j.tp_SiteId = @WebSiteId AND
            j.tp_IsCurrentVersion = ISNULL(dd.IsCurrentVersion, CAST(1 AS bit))            
        INNER JOIN
            @TransactionsDeleted AS r
        ON
            j.tp_DeleteTransactionId = r.DeleteTransactionId
        DELETE FROM
            RecycleBin
        WHERE
            ListId
        IN
            (SELECT LD.Id FROM @ListsDeleted LD)
        DELETE FROM
            EventReceivers
        WHERE
            SiteId = @WebSiteId AND
            WebId = @WebId AND
            HostId IN (SELECT LD.Id FROM @ListsDeleted LD)
        DELETE FROM
            ContentTypeUsage
        WHERE
            SiteId = @WebSiteId AND
            WebId = @WebId AND
            ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
        UPDATE
            WorkflowAssociation
        SET
            Configuration = Configuration | 512
        WHERE
            SiteId = @WebSiteId AND
            WebId = @WebId AND
            ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
        DELETE FROM
            ScheduledWorkItems
        WHERE
            SiteId = @WebSiteId AND
            ParentId IN (SELECT LD.Id FROM @ListsDeleted LD)
        DELETE FROM
            AllDocVersions
        WHERE
            SiteId = @WebSiteId AND
            Id
        IN
            (SELECT Id FROM @DocsDeleted)
        DELETE FROM
            AllDocs
        WHERE
            SiteId = @WebSiteId AND
            Id
        IN
            (SELECT Id FROM @DocsDeleted)
        DELETE FROM
            AllDocStreams
        WHERE
            SiteId = @WebSiteId AND
            Id
        IN
            (SELECT Id FROM @DocsDeleted)
        DELETE FROM
            RecycleBin
        WHERE
            SiteId = @WebSiteId AND
            WebId = @WebId AND
            DeleteTransactionId IN (SELECT DeleteTransactionId FROM @TransactionsDeleted)
        DELETE FROM 
            BuildDependencies
         WHERE 
            SiteId = @WebSiteId AND
            (DirName = @Url OR DirName LIKE @UrlLike)
    END
    ELSE
    BEGIN
        SET @Size = @Size + (
            SELECT
                (ISNULL((SUM(CAST((ISNULL(tp_Size, 0)) AS BIGINT))),0))
            FROM    
                UserDataVersioned
            WHERE
                tp_ListId
            IN
                (SELECT LD.Id FROM @ListsDeleted LD))
        UPDATE
            UserDataVersioned
        SET
            tp_DeleteTransactionId = @DeleteTransactionId
        WHERE
            tp_ListId
        IN
            (SELECT LD.Id FROM @ListsDeleted LD)
        IF EXISTS(SELECT * FROM @ListsDeleted)
        BEGIN
            DECLARE @WebPartPagesAffected table (
                DocId uniqueidentifier NOT NULL,
                DeleteTransactionId varbinary(16)
                    NOT NULL,
                SizeDelta bigint NOT NULL)
            INSERT INTO @WebPartPagesAffected
                (DocId, DeleteTransactionId, SizeDelta)
            SELECT
                AllDocs.Id,
                AllDocs.DeleteTransactionId,
                ISNULL(WebParts.tp_Size, 0)
            FROM    
                WebParts
            INNER JOIN
                AllDocs
            ON
                AllDocs.SiteId = @WebSiteId AND
                AllDocs.DeleteTransactionId <> 0x AND
                WebParts.tp_PageUrlId = Id
            WHERE
                AllDocs.ListId NOT IN (SELECT LD.Id FROM @ListsDeleted LD) AND
                WebParts.tp_ListId IN (SELECT LD.Id FROM @ListsDeleted LD)
            INSERT INTO @WebPartPagesAffected
                (DocId, DeleteTransactionId, SizeDelta)
            SELECT
                Personalization.tp_PageUrlId,
                S.DeleteTransactionId,
                ISNULL(Personalization.tp_Size, 0)
            FROM
                Personalization
            INNER JOIN
                @WebPartPagesAffected S
            ON
                Personalization.tp_SiteId = @WebSiteId AND
                Personalization.tp_PageUrlId = S.DocId
            UPDATE
                RecycleBin
            SET
                Size = Size - ISNULL((
                    SELECT
                        SUM(SizeDelta)
                    FROM
                        @WebPartPagesAffected S
                    WHERE
                        S.DeleteTransactionId = RecycleBin.DeleteTransactionId),0)
            WHERE
                SiteId = @WebSiteId AND
                DeleteTransactionId 
            IN
                (SELECT DeleteTransactionId FROM @WebPartPagesAffected)
            SET @FreedSpace = @FreedSpace + ISNULL((
                SELECT
                    SUM(SizeDelta)
                FROM
                    @WebPartPagesAffected S
                INNER JOIN
                    RecycleBin
                ON
                    S.DeleteTransactionId = RecycleBin.DeleteTransactionId
                WHERE
                    RecycleBin.SiteId = @WebSiteId AND
                    RecycleBin.BinId = 1),0)
            DELETE FROM
                WebPartLists
            WHERE
                tp_ListId IN (SELECT LD.Id FROM @ListsDeleted LD) AND
                NOT EXISTS (
                    SELECT 
                        *
                    FROM 
                        AllDocs 
                    WHERE 
                        Id = WebPartLists.tp_PageUrlId AND
                        ListId IN (SELECT LD.Id FROM @ListsDeleted LD))
            DELETE FROM
                WebParts
            WHERE
                tp_ListId IN (SELECT LD.Id FROM @ListsDeleted LD) AND
                NOT EXISTS (
                    SELECT 
                        *
                    FROM 
                        AllDocs 
                    WHERE 
                        Id = WebParts.tp_PageUrlId AND
                        ListId IN (SELECT LD.Id FROM @ListsDeleted LD))
        END
        SET @Size = @Size + (
            SELECT
                (ISNULL((SUM(CAST((ISNULL(tp_Size, 0)) AS BIGINT))),0))
            FROM
                WebParts
            WHERE
                tp_SiteId = @WebSiteId AND
                tp_PageUrlId
            IN
                (SELECT Id FROM @DocsDeleted))
        UPDATE
            Personalization
        SET
            tp_Deleted = 1
        WHERE
            tp_SiteId = @WebSiteId AND
            tp_PageUrlId
        IN
            (SELECT Id FROM @DocsDeleted)
        UPDATE
            WebParts
        SET
            tp_Deleted = 1
        WHERE
            tp_SiteId = @WebSiteId AND
            tp_PageUrlId
        IN
            (SELECT Id FROM @DocsDeleted)
        UPDATE
            ImmedSubscriptions
        SET
            Deleted = 1
        WHERE
            SiteId = @WebSiteId AND
            ListId
        IN
            (SELECT LD.Id FROM @ListsDeleted LD)
        UPDATE
            SchedSubscriptions
        SET
            Deleted = 1
        WHERE
            SiteId = @WebSiteId AND
            ListId
        IN
            (SELECT LD.Id FROM @ListsDeleted LD)
        UPDATE
            Lists
        SET
            tp_DeleteTransactionId = @DeleteTransactionId,
            tp_EmailAlias = NULL
        WHERE
            tp_WebId = @WebId AND
            tp_Id
        IN
            (SELECT LD.Id FROM @ListsDeleted LD)
        SET @Size = @Size + (
            SELECT
                (ISNULL((SUM(CAST((ISNULL(Size, 0) + ISNULL(MetaInfoSize, 0)) AS BIGINT))),0))
            FROM
                DocVersions
            WHERE
                SiteId = @WebSiteId AND
                Id
            IN
                (SELECT Id FROM @DocsDeleted))
        UPDATE
            AllUserDataJunctions
        SET
            tp_DeleteTransactionId = @DeleteTransactionId
        FROM
            AllUserDataJunctions AS j, Docs AS d, @DocsDeleted AS dd
        WHERE
            d.SiteId = @WebSiteId AND
            d.DirName = j.tp_DirName AND
            d.LeafName = j.tp_LeafName AND
            d.Id = dd.Id AND
            j.tp_IsCurrentVersion = ISNULL(dd.IsCurrentVersion, CAST(1 AS bit)) AND
            j.tp_SiteId = @WebSiteId AND
            j.tp_DeleteTransactionId = 0x
        UPDATE
            DocVersions
        SET
            DeleteTransactionId = @DeleteTransactionId
        WHERE
            SiteId = @WebSiteId AND
            Id
        IN
            (SELECT Id FROM @DocsDeleted)
        SET @Size = @Size + ISNULL((
            SELECT
                SUM(CAST(ISNULL(Size, 0) AS BIGINT) +
                    CAST(ISNULL(MetaInfoSize, 0) AS BIGINT) +
                    CAST(ISNULL(UnVersionedMetaInfoSize,0) AS BIGINT) +
                    CAST(152 AS BIGINT))
            FROM
                Docs
            WHERE
                SiteId = @WebSiteId AND
                (DirName = @Url OR
                    DirName LIKE @UrlLike)),0)
        UPDATE
            DocStreams
        SET
            DeleteTransactionId = @DeleteTransactionId
        FROM
            Docs 
        INNER JOIN 
            DocStreams
        ON
            Docs.SiteId = DocStreams.SiteId AND
            Docs.ParentId = DocStreams.ParentId AND
            Docs.Id = DocStreams.Id AND
            Docs.Level = DocStreams.Level
        WHERE
            Docs.SiteId = @WebSiteId AND
            (Docs.DirName = @Url OR
                Docs.DirName LIKE @UrlLike)
        UPDATE
            Docs
        SET
            DeleteTransactionId = @DeleteTransactionId,
            BuildDependencySet = NULL
        WHERE
            SiteId = @WebSiteId AND
            (DirName = @Url OR
                DirName LIKE @UrlLike)
        DELETE FROM 
            BuildDependencies
        WHERE 
            SiteId = @WebSiteId AND
            (DirName = @Url OR 
                DirName LIKE @UrlLike)
    END
    DELETE FROM
        ComMd
    WHERE
        SiteId = @WebSiteId AND
        DocId
    IN
        (SELECT Id FROM @DocsDeleted)
    DELETE FROM
        Categories
    WHERE
        DocId
    IN
        (SELECT Id FROM @DocsDeleted)
cleanup:
    RETURN @ReturnStatus

GO
