/****** Object:  StoredProcedure [dbo].[proc_RenameDir]    Script Date: 5/15/2018 12:12:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_RenameDir(
    @SiteId                     uniqueidentifier,
    @SubWebId                   uniqueidentifier,
    @ParentWebId                uniqueidentifier,
    @ScopeId                    uniqueidentifier,
    @FirstUniqueAncestorWebId   uniqueidentifier,
    @DstUrlParentWebId          uniqueidentifier,
    @SubWebUrl             nvarchar(256),
    @OldUrl                nvarchar(260),
    @NewUrl                nvarchar(260),
    @NewDocParentId        uniqueidentifier,
    @SubWebAncestrySize         int,
    @UserId                int,
    @RenameFlags           int = 0,
    @PutFlags              int = 0,
    @ReturnFlags           int = 0,
    @ParseDocsNow          bit OUTPUT,
    @FailedDirName         nvarchar(256) OUTPUT,
    @FailedLeafName        nvarchar(128) OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @OldUrlDirName nvarchar(256)
    DECLARE @NewUrlDirName nvarchar(256)
    DECLARE @OldUrlLeafName nvarchar(128)
    DECLARE @NewUrlLeafName nvarchar(128)
    DECLARE @OldUrlLike nvarchar(1024)
    DECLARE @NewUrlLike nvarchar(1024)
    DECLARE @OldListId uniqueidentifier
    DECLARE @OldBaseType int
    DECLARE @OldDoclibExcludedType int
    DECLARE @OldListMinDoclibRowId int
    DECLARE @OldListMaxDoclibRowId int
    DECLARE @OldListNumDoclibEntries int
    DECLARE @OldListDoclibItemDelta int
    DECLARE @OldListDoclibFileDelta int
    DECLARE @OldListMinIdVal int
    DECLARE @OldListMaxIdVal int
    DECLARE @OldDocParentId uniqueidentifier
    DECLARE @NewListId uniqueidentifier
    DECLARE @NewBaseType int
    DECLARE @NewDoclibRowId int
    DECLARE @NewDoclibExcludedType int
    DECLARE @SQLErrorCode int
    DECLARE @MaxNewListRowOrd int
    DECLARE @DirId uniqueidentifier
    SET @OldDoclibExcludedType = 0x00
    SET @NewDoclibExcludedType = 0x00
    DECLARE @HasSubsumedWebs bit
    DECLARE @RenamingList bit
    SET @RenamingList = 0
    DECLARE @OldListTitle nvarchar(255)
    DECLARE @OldListVersion int
    DECLARE @RetVal int
    DECLARE @Now datetime
    SELECT @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE());
    DECLARE @RenamingWeb bit
    DECLARE @RenamingWebDir bit
    SELECT @RenamingWeb = @RenameFlags & 32
    SELECT @RenamingWebDir = @RenameFlags & 256
    DECLARE @Collation smallint
    DECLARE @WebTitle nvarchar(255)
    DECLARE @NavParentWebId uniqueidentifier
    DECLARE @WebScope uniqueidentifier
    DECLARE @bRemoveFGP bit
    DECLARE @SrcScopeId uniqueidentifier
    DECLARE @DestScopeId uniqueidentifier
    DECLARE @bWasUnique bit
    DECLARE @bResetDestFGP bit
    SET @bRemoveFGP = 0
    SET @bResetDestFGP = 0
    SELECT 
        @NavParentWebId = NavParentWebId,
        @WebScope = ScopeId,
        @WebTitle = Title
    FROM 
        Webs
    WHERE
        SiteId = @SiteId AND
        Id = @SubWebId
    EXEC proc_SplitUrl
        @OldUrl,
        @OldUrlDirName OUTPUT,
        @OldUrlLeafName OUTPUT
    EXEC proc_SplitUrl
        @NewUrl,
        @NewUrlDirName OUTPUT,
        @NewUrlLeafName OUTPUT
    EXEC @RetVal = proc_ValidateRenameDir @SiteId, @SubWebId,
        @DstUrlParentWebId, @SubWebUrl, @OldUrl, @NewUrl, @UserId, @RenameFlags,
        @OldListId OUTPUT,
        @OldBaseType OUTPUT, @OldDoclibExcludedType OUTPUT,
        @NewListId OUTPUT, @NewBaseType OUTPUT,
        @NewDoclibExcludedType OUTPUT, @FailedDirName OUTPUT,
        @FailedLeafName OUTPUT
    IF @RetVal <> 0
    BEGIN
        RETURN @RetVal
    END
    SELECT
        @OldListTitle = CASE
                             WHEN @OldListId IS NOT NULL
                             THEN Lists.tp_Title
                             ELSE NULL
                        END,
        @OldListVersion = CASE
                               WHEN @OldListId IS NOT NULL
                               THEN Lists.tp_Version
                               ELSE NULL
                          END,
        @OldDocParentId = Docs.ParentId
    FROM
        Docs LEFT OUTER JOIN Lists
    ON
        Lists.tp_WebID = @SubWebId AND
        Lists.tp_ID = Docs.ListID AND
        Lists.tp_RootFolder = Docs.ID
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @OldUrlDirName AND
        Docs.LeafName = @OldUrlLeafName AND
        Docs.Type = 1 AND
        Docs.ListId = @OldListId
    IF @OldListId IS NOT NULL
    BEGIN
        SELECT @RenamingList =
            CASE
                WHEN (@OldListVersion IS NOT NULL)
            THEN
                1
            ELSE
                0
            END
        IF @RenamingList = 1
        BEGIN
            SET @NewListId = @OldListId
            SET @NewBaseType = @OldBaseType
        END
    END
    IF (@RenamingList = 0 AND @RenamingWeb = 0 AND @NewListId IS NULL)
    BEGIN
        SET @bRemoveFGP = 1
    END
    SELECT
        @SrcScopeId  = ScopeId
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        WebId = @SubWebId AND
        DirName = @OldUrlDirName AND
        LeafName = @OldUrlLeafName
    IF EXISTS (
        SELECT
            *
        FROM
            Perms
        WHERE
            SiteId = @SiteId AND
            ScopeId = @SrcScopeId AND
            WebId = @SubWebId AND
            ScopeUrl = @OldUrl)
    BEGIN
        SET @bWasUnique = 1
    END
    ELSE
    BEGIN
        SET @bWasUnique = 0
    END
    DECLARE @NumDocsToRename int
    DECLARE @NumDocsRenamed1 int
    DECLARE @NumDocsRenamed2 int
    DECLARE @NumDocsRenamed3 int
    DECLARE @RowDelta int
    SET @NumDocsRenamed1 = 0
    SET @NumDocsRenamed2 = 0
    SET @NumDocsRenamed3 = 0
    EXEC proc_EscapeForLike @OldUrl, @OldUrlLike OUTPUT
    EXEC proc_EscapeForLike @NewUrl, @NewUrlLike OUTPUT
    SELECT TOP 1
        @DirId = Docs.Id
    FROM
        Docs WITH (UPDLOCK)
    WHERE
        SiteId = @SiteId AND
        DirName = @OldUrlDirName AND
        LeafName = @OldUrlLeafName AND
        WebId = @SubWebId AND
        Type = 1
    DECLARE @DocList table
        (OldDirName nvarchar(256) COLLATE Latin1_General_CI_AS_KS_WS, 
            OldLeafName nvarchar(128) COLLATE Latin1_General_CI_AS_KS_WS,
            Level tinyint DEFAULT 1 NOT NULL,
            IsCurrentVersion bit DEFAULT 1 NOT NULL,
            NewDirName nvarchar(256) COLLATE Latin1_General_CI_AS_KS_WS, 
            NewLeafName nvarchar(128) COLLATE Latin1_General_CI_AS_KS_WS,
            NewFullUrl nvarchar(260) COLLATE Latin1_General_CI_AS_KS_WS,
            Type int,
            Size int,
            TimeCreated datetime,
            TimeLastModified datetime,
            MetaInfoTimeLastModified datetime,
            ListId uniqueidentifier,
            WebId uniqueidentifier,
            DoclibRowId int,
            ThicketFlag int,
            CtoOffset int,
            IdVal int IDENTITY,
            KeepModified bit,
            CheckoutUserId int,
            DraftOwnerId int,
            PRIMARY KEY CLUSTERED (OldDirName, OldLeafName, Level)
        )
    INSERT INTO @DocList
    SELECT
        Docs.DirName,
        Docs.LeafName,
        Docs.Level,
        Docs.IsCurrentVersion,
        NewDirName =  COALESCE(
            CASE
            WHEN
            (Docs.DirName = @OldUrlDirName AND
                Docs.LeafName = @OldUrlLeafName)
            THEN
                @NewUrlDirName
            ELSE
                STUFF(Docs.DirName, 1,
                LEN(@OldUrl), @NewUrl)
            END, 
            @NewUrlDirName
            ),
        NewLeafName = CASE
            WHEN
                (Docs.DirName = @OldUrlDirName AND
                    Docs.LeafName = @OldUrlLeafName)
            THEN
                @NewUrlLeafName
            ELSE
                Docs.LeafName
            END,
        NewFullUrl = STUFF((CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END), 1,
            LEN(@OldUrl), @NewUrl),
        Docs.Type,
        Docs.Size,
        Docs.TimeCreated,
        TimeLastModified = CASE
            WHEN
                Docs.TimeLastModified IS NULL
            THEN
                NULL
            WHEN 
                Docs.IsCurrentVersion = 0 
            THEN
                Docs.TimeLastModified
            ELSE
                @Now
            END,
        MetaInfoTimeLastModified = CASE
            WHEN
                Docs.MetaInfoTimeLastModified IS NULL
            THEN
                NULL
            ELSE
                @Now
            END,
        Docs.ListId,
        Docs.WebId,
        Docs.DoclibRowId,
        Docs.ThicketFlag,
        Docs.CtoOffset,
        0,    
        Docs.LTCheckoutUserId,
        Docs.DraftOwnerId
    FROM                         
        Docs WITH (UPDLOCK)
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @OldUrlDirName AND
        Docs.LeafName = @OldUrlLeafName 
    UNION ALL
    SELECT
        Docs.DirName,
        Docs.LeafName,
        Docs.Level,
        Docs.IsCurrentVersion,
        NewDirName =  COALESCE(
            CASE
            WHEN
                (Docs.DirName = @OldUrlDirName AND
                    Docs.LeafName = @OldUrlLeafName)
            THEN
                @NewUrlDirName
            ELSE
                STUFF(Docs.DirName, 1,
                LEN(@OldUrl), @NewUrl)
            END, 
            @NewUrlDirName
            ),
        NewLeafName = CASE
            WHEN
                (Docs.DirName = @OldUrlDirName AND
                    Docs.LeafName = @OldUrlLeafName)
            THEN
                @NewUrlLeafName
            ELSE
                Docs.LeafName
            END,
        NewFullUrl = STUFF((CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END), 1,
            LEN(@OldUrl), @NewUrl),
        Docs.Type,
        Docs.Size,
        Docs.TimeCreated,
        Docs.TimeLastModified,
        Docs.MetaInfoTimeLastModified,
        Docs.ListId,
        Docs.WebId,
        Docs.DoclibRowId,
        Docs.ThicketFlag,
        Docs.CtoOffset,
        1,
        Docs.LTCheckoutUserId,
        Docs.DraftOwnerId
    FROM                         
        Docs WITH (UPDLOCK)
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @OldUrl 
    UNION ALL
    SELECT
        Docs.DirName,
        Docs.LeafName,
        Docs.Level,
        Docs.IsCurrentVersion,
        NewDirName =  COALESCE(
            CASE
            WHEN
                (Docs.DirName = @OldUrlDirName AND
                    Docs.LeafName = @OldUrlLeafName)
            THEN
                @NewUrlDirName
            ELSE
                STUFF(Docs.DirName, 1,
                LEN(@OldUrl), @NewUrl)
            END, 
            @NewUrlDirName
            ),
        NewLeafName = CASE
            WHEN
                (Docs.DirName = @OldUrlDirName AND
                    Docs.LeafName = @OldUrlLeafName)
            THEN
                @NewUrlLeafName
            ELSE
                Docs.LeafName
            END,
        NewFullUrl = STUFF((CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END), 1,
            LEN(@OldUrl), @NewUrl),
        Docs.Type,
        Docs.Size,
        Docs.TimeCreated,
        Docs.TimeLastModified,
        Docs.MetaInfoTimeLastModified,
        Docs.ListId,
        Docs.WebId,
        Docs.DoclibRowId,
        Docs.ThicketFlag,
        Docs.CtoOffset,
        1,
        Docs.LTCheckoutUserId,
        Docs.DraftOwnerId
    FROM                         
        Docs WITH (UPDLOCK)
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName LIKE @OldUrlLike 
    SELECT @NumDocsToRename = @@ROWCOUNT, @SQLErrorCode = @@ERROR 
    IF @NumDocsToRename = 0
    BEGIN
        IF EXISTS(
            SELECT 
                * 
            FROM 
                Docs 
            WHERE 
                SiteId = @SiteId AND
                DirName = @OldUrlDirName AND
                LeafName = @OldUrlLeafName)
        BEGIN
            IF @SQLErrorCode = 8152
            BEGIN
                RETURN 206
            END
            ELSE
            BEGIN
                RETURN 50
            END
        END
        RETURN 3
    END
    IF (@ReturnFlags & 0x01) = 0x01
    BEGIN
        SELECT DISTINCT
            OldDirName,
            OldLeafName,
            NewDirName,
            NewLeafName,
            Type
        FROM
            @DocList DocList
    END
    DECLARE @DepList table (DocUrl nvarchar(260) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL, Level tinyint DEFAULT 1 NOT NULL, DirName AS ISNULL(CASE WHEN (CHARINDEX(N'/', REVERSE(DocUrl)) > 0) THEN LEFT(DocUrl, DATALENGTH(DocUrl)/2 - CHARINDEX(N'/', REVERSE(DocUrl) COLLATE Latin1_General_BIN)) ELSE N'' END, N''), LeafName AS ISNULL(CASE WHEN (CHARINDEX(N'/', REVERSE(DocUrl) COLLATE Latin1_General_BIN) > 0) THEN RIGHT(DocUrl, CHARINDEX(N'/', REVERSE(DocUrl) COLLATE Latin1_General_BIN) - 1) ELSE DocUrl END, DocUrl), UNIQUE (DocUrl,Level))
    IF (@RenameFlags & 4 = 4) AND
        (@ReturnFlags & 0x02) = 0x02
    BEGIN
        INSERT INTO @DepList
        SELECT
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END,
            BackLinks.Level
        FROM (            
        SELECT DISTINCT
            Links.DirName AS DirName,
            Links.LeafName AS LeafName,
            Links.Level AS Level
        FROM
            Links INNER JOIN Docs
        ON
            Links.SiteId = Docs.SiteId AND
            Links.TargetDirName = Docs.DirName AND
            Links.TargetLeafName = Docs.LeafName AND
            Docs.WebId = @SubWebId
        WHERE
            Links.SiteId = @SiteId AND
            Links.TargetDirName = @OldUrlDirName AND
            Links.TargetLeafName = @OldUrlLeafName
        UNION
        SELECT DISTINCT
            Links.DirName AS DirName,
            Links.LeafName AS LeafName,
            Links.Level AS Level
        FROM
            Links INNER JOIN Docs
        ON
            Links.SiteId = Docs.SiteId AND
            Links.TargetDirName = Docs.DirName AND
            Links.TargetLeafName = Docs.LeafName AND
            Docs.WebId = @SubWebId
        WHERE
            Links.SiteId = @SiteId AND
            Links.TargetDirName = @OldUrl
        UNION
        SELECT DISTINCT
            Links.DirName AS DirName,
            Links.LeafName AS LeafName,
            Links.Level AS Level
        FROM
            Links INNER JOIN Docs
        ON
            Links.SiteId = Docs.SiteId AND
            Links.TargetDirName = Docs.DirName AND
            Links.TargetLeafName = Docs.LeafName AND
            Docs.WebId = @SubWebId
        WHERE
            Links.SiteId = @SiteId AND
            Links.TargetDirName LIKE @OldUrlLike
            )
        AS
            BackLinks LEFT OUTER JOIN @DocList DocList
        ON
            BackLinks.DirName = DocList.OldDirName AND
            BackLinks.LeafName = DocList.OldLeafName AND
            BackLinks.Level = DocList.Level
        WHERE
            DocList.OldDirName IS NULL AND
            DocList.OldLeafName IS NULL
    END
    EXEC @RetVal =
        proc_DirtyListData @SiteId, @OldUrlDirName, @OldUrlLeafName, 1
    IF @RetVal <> 0
    BEGIN
        RETURN @RetVal
    END
    IF @OldListId IS NOT NULL OR @NewListId IS NOT NULL
    BEGIN
        DECLARE @MaxNewRows int
        SELECT
            @OldListMinDoclibRowId = MIN(DoclibRowId),
            @OldListMaxDoclibRowId = MAX(DoclibRowId),
            @OldListNumDoclibEntries =
                SUM(CASE
                    WHEN DoclibRowId IS NULL
                    THEN
                        0
                    ELSE
                        1
                    END),
            @OldListDoclibItemDelta =
                SUM(CASE
                    WHEN DoclibRowId IS NOT NULL AND
                        IsCurrentVersion = 1
                    THEN
                        1
                    ELSE
                        0
                    END),
            @OldListDoclibFileDelta =
                SUM(CASE
                    WHEN
                        IsCurrentVersion = 1
                    THEN
                        1
                    ELSE
                        0
                    END),
                @OldListMinIdVal = MIN(IdVal),
                @OldListMaxIdVal = MAX(IdVal)
        FROM
            @DocList
        IF (@OldListId IS NOT NULL AND @NewListId IS NOT NULL AND
            @OldListId = @NewListId)
            BEGIN
                UPDATE
                    NameValuePair
                SET 
                    Value =
                        CASE WHEN FieldId = '{28cf69c5-fa48-462a-b5cd-27b6f9d2bd5f}'
                            THEN DocList.TimeLastModified
                        WHEN FieldId = '{d31655d1-1d5b-4511-95a1-7a09e9b75bf2}' AND DocList.KeepModified <> 1
                            THEN @UserId
                        ELSE
                            Value
                        END
                FROM
                    NameValuePair NVP
                INNER JOIN
                    @DocList DocList
                ON
                    NVP.ListId = DocList.ListId AND
                    NVP.ItemId = DocList.DoclibRowId AND
                    NVP.Level = DocList.Level
                WHERE
                    NVP.SiteId = @SiteId AND
                    NVP.ListId = @OldListId AND
                    DocList.DoclibRowId IS NOT NULL
                UPDATE
                    UserData
                SET
                    tp_Modified = DocList.TimeLastModified,
                    tp_Editor = CASE WHEN DocList.KeepModified = 1 THEN UserData.tp_Editor
                                ELSE @UserId
                                END
                FROM
                    UserData INNER JOIN @DocList DocList
                ON
                    UserData.tp_ListId = DocList.ListId AND
                    UserData.tp_Id = Doclist.DoclibRowId AND
                    UserData.tp_Level = DocList.Level
                WHERE
                    UserData.tp_ListId = @OldListId AND
                    DocList.DoclibRowId IS NOT NULL
                SET @RowDelta = @@ROWCOUNT
                IF @RowDelta < @OldListNumDoclibEntries
                    RETURN 87
                UPDATE
                    Lists
                SET
                    tp_Modified = @Now
                WHERE
                    tp_WebID = @SubWebId AND
                    tp_ID = @OldListId
                IF @@ROWCOUNT <> 1
                    RETURN 87
        END
        ELSE
        BEGIN
            IF @OldListId IS NOT NULL AND
                @OldBaseType = 1 AND
                (@NewListId IS NULL OR
                    @NewBaseType IS NULL OR
                    @NewBaseType <> 1) AND
                    @RenamingList = 0
            BEGIN
                DELETE NVP FROM
                    NameValuePair AS NVP
                    INNER JOIN @DocList DocList 
                ON
                    NVP.SiteId = @SiteId AND
                    NVP.ListId = DocList.ListId AND
                    NVP.ItemId = DocList.DoclibRowId AND
                    DocList.IsCurrentVersion = 1
                WHERE
                    NVP.ListId = @OldListId AND
                    DocList.DoclibRowId IS NOT NULL
                EXEC proc_GetCollation @OldListId, @Collation OUTPUT
    IF @Collation = 0
    BEGIN
        DELETE NVP FROM
            NameValuePair_Albanian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 1
    BEGIN
        DELETE NVP FROM
            NameValuePair_Arabic_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 2
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_PRC_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 3
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_PRC_Stroke_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 4
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_Taiwan_Bopomofo_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 5
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_Taiwan_Stroke_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 6
    BEGIN
        DELETE NVP FROM
            NameValuePair_Croatian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 7
    BEGIN
        DELETE NVP FROM
            NameValuePair_Cyrillic_General_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 8
    BEGIN
        DELETE NVP FROM
            NameValuePair_Czech_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 9
    BEGIN
        DELETE NVP FROM
            NameValuePair_Danish_Norwegian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 10
    BEGIN
        DELETE NVP FROM
            NameValuePair_Estonian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 11
    BEGIN
        DELETE NVP FROM
            NameValuePair_Finnish_Swedish_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 12
    BEGIN
        DELETE NVP FROM
            NameValuePair_French_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 13
    BEGIN
        DELETE NVP FROM
            NameValuePair_Georgian_Modern_Sort_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 14
    BEGIN
        DELETE NVP FROM
            NameValuePair_German_PhoneBook_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 15
    BEGIN
        DELETE NVP FROM
            NameValuePair_Greek_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 16
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hebrew_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 17
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hindi_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 18
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hungarian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 19
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hungarian_Technical_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 20
    BEGIN
        DELETE NVP FROM
            NameValuePair_Icelandic_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 21
    BEGIN
        DELETE NVP FROM
            NameValuePair_Japanese_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 22
    BEGIN
        DELETE NVP FROM
            NameValuePair_Japanese_Unicode_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 23
    BEGIN
        DELETE NVP FROM
            NameValuePair_Korean_Wansung_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 24
    BEGIN
        DELETE NVP FROM
            NameValuePair_Korean_Wansung_Unicode_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 25
    BEGIN
        DELETE NVP FROM
            NameValuePair_Latin1_General_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 26
    BEGIN
        DELETE NVP FROM
            NameValuePair_Latvian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 27
    BEGIN
        DELETE NVP FROM
            NameValuePair_Lithuanian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 28
    BEGIN
        DELETE NVP FROM
            NameValuePair_Lithuanian_Classic_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 29
    BEGIN
        DELETE NVP FROM
            NameValuePair_Traditional_Spanish_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 30
    BEGIN
        DELETE NVP FROM
            NameValuePair_Modern_Spanish_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 31
    BEGIN
        DELETE NVP FROM
            NameValuePair_Polish_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 32
    BEGIN
        DELETE NVP FROM
            NameValuePair_Romanian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 33
    BEGIN
        DELETE NVP FROM
            NameValuePair_Slovak_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 34
    BEGIN
        DELETE NVP FROM
            NameValuePair_Slovenian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 35
    BEGIN
        DELETE NVP FROM
            NameValuePair_Thai_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 36
    BEGIN
        DELETE NVP FROM
            NameValuePair_Turkish_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 37
    BEGIN
        DELETE NVP FROM
            NameValuePair_Ukrainian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 38
    BEGIN
        DELETE NVP FROM
            NameValuePair_Vietnamese_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId AND DocList.IsCurrentVersion = 1 WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
                DELETE
                    UserDataVersioned
                FROM
                    UserDataVersioned INNER JOIN @DocList DocList
                ON
                    UserDataVersioned.tp_ListId = DocList.ListId AND
                    UserDataVersioned.tp_Id = Doclist.DoclibRowId AND
                    DocList.IsCurrentVersion = 1
                WHERE
                    UserDataVersioned.tp_ListId = @OldListId AND
                    DocList.DoclibRowId IS NOT NULL
                SET @RowDelta = @@ROWCOUNT
                IF @RowDelta < @OldListNumDoclibEntries
                BEGIN
                    RETURN 87
                END
                UPDATE
                    Lists
                SET
                    tp_ItemCount = tp_ItemCount -
                        @OldListDoclibItemDelta,
                    tp_LastDeleted = @Now,
                    tp_Modified = @Now
                WHERE
                    tp_WebID = @SubWebId AND
                    tp_ID = @OldListId
                UPDATE
                    @DocList
                SET
                    ListId = NULL,
                    DoclibRowId = NULL
            END
            IF (@OldListId IS NULL OR
                @OldBaseType <> 1) AND
                @NewListId IS NOT NULL AND
                @NewBaseType = 1
            BEGIN
                SET @ParseDocsNow = 1
                SET @MaxNewRows = @OldListMaxIdVal -
                    @OldListMinIdVal + 1
                EXEC @NewDoclibRowId =
                    proc_GenerateNextId @SubWebId, @NewListId,
                        @MaxNewRows
                UPDATE
                    @DocList
                SET
                    ListId = @NewListId,
                    DoclibRowId = @NewDoclibRowId +
                        IdVal - @OldListMinIdVal
                WHERE
                    ThicketFlag IS NOT NULL
                UPDATE 
                    DocList
                SET 
                    ListId = DocList1.ListId,
                    DoclibRowId = DocList1.DoclibRowId
                FROM
                    @DocList DocList INNER JOIN @DocList DocList1
                ON
                    DocList.OldDirName = DocList1.OldDirName AND
                    DocList.OldLeafName = DocList1.OldLeafName AND
                    DocList1.Level = 1
                WHERE
                    DocList.Level <> 1 AND
                    DocList.ThicketFlag IS NOT NULL
                UPDATE 
                    DocList
                SET 
                    ListId = DocList1.ListId,
                    DoclibRowId = DocList1.DoclibRowId
                FROM
                    @DocList DocList INNER JOIN @DocList DocList1
                ON
                    DocList.OldDirName = DocList1.OldDirName AND
                    DocList.OldLeafName = DocList1.OldLeafName AND
                    DocList1.Level = 2
                WHERE
                    DocList.Level = 255 AND
                    DocList.ThicketFlag IS NOT NULL
                INSERT INTO AllUserData(
                    tp_ID,
                    tp_ListId,
                    tp_SiteId,
                    tp_DirName,
                    tp_LeafName,
                    tp_RowOrdinal,
                    tp_Version,
                    tp_Author,
                    tp_Editor,
                    tp_Created,
                    tp_Modified,
                    tp_Ordering,
                    tp_ItemOrder,
                    tp_InstanceID,
                    tp_Size,
                    tp_Level,
                    tp_CheckoutUserId,
                    tp_DraftOwnerId)
                SELECT
                    DoclibRowId,
                    @NewListId,
                    @SiteId,
                    NewDirName,
                    NewLeafName,
                    0,
                    0,
                    @UserId,
                    @UserId,
                    @Now,
                    @Now,
                    NULL,
                    NULL,
                    NULL,
                    0,
                    Level,
                    CheckoutUserId,
                    DraftOwnerId
                FROM
                    @DocList
                WHERE
                    ThicketFlag IS NOT NULL
                SET @RowDelta = @@ROWCOUNT
                IF @RowDelta = 0 OR
                    @RowDelta > @MaxNewRows
                    RETURN 87
                SELECT 
                    @MaxNewListRowOrd = tp_MaxRowOrdinal
                FROM 
                    Lists
                WHERE
                    tp_WebID = @SubWebID AND
                    tp_ID = @NewListID
                DECLARE @rowOrdCount int
                SET @rowOrdCount = 1
                IF @MaxNewListRowOrd > 0
                BEGIN
                    WHILE  @rowOrdCount  <= @MaxNewListRowOrd
                    BEGIN
                       INSERT INTO AllUserData(
                            tp_ID,
                            tp_ListId,
                            tp_SiteId,
                            tp_DirName,
                            tp_LeafName,
                            tp_RowOrdinal,
                            tp_Version,
                            tp_Author,
                            tp_Editor,
                            tp_Created,
                            tp_Modified,
                            tp_Ordering,
                            tp_ItemOrder,
                            tp_InstanceID,
                            tp_Size,
                            tp_Level,
                            tp_CheckoutUserId,
                            tp_DraftOwnerId)
                        SELECT
                            DoclibRowId,
                            @NewListId,
                            @SiteId,
                            NewDirName,
                            NewLeafName,
                            @rowOrdCount,
                            0,
                            @UserId,
                            @UserId,
                            @Now,
                            @Now,
                            NULL,
                            NULL,
                            NULL,
                            0,
                            Level,
                            CheckoutUserId,
                            DraftOwnerId
                        FROM
                            @DocList
                        WHERE
                            ThicketFlag IS NOT NULL
                  SET @rowOrdCount = @rowOrdCount + 1
                    END
                END
                UPDATE
                    Lists
                SET
                    tp_ItemCount = tp_ItemCount +
                        @OldListDoclibFileDelta,
                    tp_Modified = @Now
                WHERE
                    tp_WebID = @SubWebID AND
                    tp_ID = @NewListID
            END
            IF (@OldListId IS NOT NULL AND
                @OldBaseType = 1 AND
                @NewListId IS NOT NULL AND
                @NewBaseType = 1 AND
                @OldListId <> @NewListId)
            BEGIN
                SET @ParseDocsNow = 1
                DECLARE @UseRowIds bit
                DECLARE @DoclibRowIdDelta int
                DECLARE @IdValDelta int
                SET @DoclibRowIdDelta = @OldListMaxDoclibRowId -
                    @OldListMinDoclibRowId + 1
                SET @IdValDelta = @OldListMaxIdVal -
                    @OldListMinIdVal + 1
                IF @DoclibRowIdDelta IS NOT NULL AND
                    @DoclibRowIdDelta < @IdValDelta
                BEGIN
                    SET @MaxNewRows = @DoclibRowIdDelta
                    SET @UseRowIds = 1
                END
                ELSE
                BEGIN
                    SET @MaxNewRows = @IdValDelta
                    SET @UseRowIds = 0
                END
                SET @bResetDestFGP = 1
                EXEC @NewDoclibRowId =
                    proc_GenerateNextId @SubWebId, @NewListId,
                        @MaxNewRows
                INSERT INTO AllUserData (
                    tp_ID,
                    tp_ListId,
                    tp_SiteId,
                    tp_DirName,
                    tp_LeafName,
                    tp_RowOrdinal,
                    tp_Version,
                    tp_Author,
                    tp_Editor,
                    tp_Created,
                    tp_Modified,
                    tp_Ordering,
                    tp_ItemOrder,
                    tp_InstanceID,
                    tp_Size,
                    tp_Level,
                    tp_ModerationStatus,
                    tp_UIVersion,
                    tp_IsCurrentVersion,
                    tp_IsCurrent,
                    tp_CalculatedVersion,
                    tp_CheckoutUserId,
                    tp_DraftOwnerId)
                SELECT
                    CASE
                    WHEN
                        DocList.DoclibRowId IS NULL
                    THEN
                        NULL
                    WHEN
                        @UseRowIds = 1
                    THEN
                        @NewDoclibRowId +
                        DocList.DoclibRowId -
                        @OldListMinDoclibRowId
                    ELSE
                        @NewDoclibRowId +
                        DocList.IdVal -
                        @OldListMinIdVal
                    END,
                    @NewListId,
                    @SiteId,
                    DocList.NewDirName,
                    DocList.NewLeafName,
                    0,
                    0,
                    UserDataVersioned.tp_Author,
                    CASE WHEN DocList.KeepModified = 1 THEN UserDataVersioned.tp_Editor
                                ELSE @UserId
                                END,
                    UserDataVersioned.tp_Created,
                    DocList.TimeLastModified,
                    NULL,
                    NULL,
                    NULL,
                    0,
                    UserDataVersioned.tp_Level,
                    UserDataVersioned.tp_ModerationStatus,
                    UserDataVersioned.tp_UIVersion,
                    UserDataVersioned.tp_IsCurrentVersion,
                    UserDataVersioned.tp_IsCurrent,
                    UserDataVersioned.tp_CalculatedVersion,
                    UserDataVersioned.tp_CheckoutUserId,
                    UserDataVersioned.tp_DraftOwnerId
                FROM
                    UserDataVersioned  INNER JOIN @DocList DocList
                ON
                    UserDataVersioned.tp_SiteId = @SiteId AND
                    UserDataVersioned.tp_DirName = DocList.OldDirName AND
                    UserDataVersioned.tp_LeafName = DocList.OldLeafName
                SET @RowDelta = @@ROWCOUNT
                IF @RowDelta = 0
                    RETURN 87
                SELECT 
                    @MaxNewListRowOrd = tp_MaxRowOrdinal
                FROM 
                    Lists
                WHERE
                    tp_WebID = @SubWebID AND
                    tp_ID = @NewListID
                SET @rowOrdCount = 1
                IF @MaxNewListRowOrd > 0
                BEGIN
                    WHILE  @rowOrdCount  <= @MaxNewListRowOrd
                    BEGIN
                        INSERT INTO AllUserData (
                            tp_ID,
                            tp_ListId,
                            tp_SiteId,
                            tp_DirName,
                            tp_LeafName,
                            tp_RowOrdinal,
                            tp_Version,
                            tp_Author,
                            tp_Editor,
                            tp_Created,
                            tp_Modified,
                            tp_Ordering,
                            tp_ItemOrder,
                            tp_InstanceID,
                            tp_Size,
                            tp_Level,
                            tp_ModerationStatus,
                            tp_UIVersion,
                            tp_IsCurrentVersion,
                            tp_IsCurrent,
                            tp_CalculatedVersion,
                            tp_CheckoutUserId,
                            tp_DraftOwnerId)
                        SELECT 
                            tp_ID,
                            tp_ListId,
                            tp_SiteId,
                            tp_DirName,
                            tp_LeafName,
                            @rowOrdCount,
                            tp_Version,
                            tp_Author,
                            tp_Editor,
                            tp_Created,
                            tp_Modified,
                            tp_Ordering,
                            tp_ItemOrder,
                            tp_InstanceID,
                            tp_Size,
                            tp_Level,
                            tp_ModerationStatus,
                            tp_UIVersion,
                            tp_IsCurrentVersion,
                            tp_IsCurrent,
                            tp_CalculatedVersion,
                            tp_CheckoutUserId,
                            tp_DraftOwnerId
                        FROM
                            UserDataVersioned INNER JOIN @DocList DocList 
                        ON
                            UserDataVersioned.tp_SiteId = @SiteId AND
                            UserDataVersioned.tp_DirName = DocList.NewDirName AND
                            UserDataVersioned.tp_LeafName = DocList.NewLeafName
                        WHERE
                            UserDataVersioned.tp_RowOrdinal = 0
                        SET @rowOrdCount = @rowOrdCount + 1
                    END
                END
                UPDATE
                    Lists
                SET
                    tp_ItemCount = tp_ItemCount +
                        @OldListDoclibItemDelta,
                    tp_Modified = @Now
                WHERE
                    tp_WebID = @SubWebID AND
                    tp_ID = @NewListID
                IF @@ROWCOUNT <> 1
                    RETURN 87
                DELETE NVP FROM
                    NameValuePair AS NVP
                    INNER JOIN @DocList DocList
                ON
                    NVP.SiteId = @SiteId AND
                    NVP.ListId = DocList.ListId AND
                    NVP.ItemId = Doclist.DoclibRowId
                WHERE
                    NVP.ListId = @OldListId AND
                    DocList.DoclibRowId IS NOT NULL
                EXEC proc_GetCollation @OldListId, @Collation OUTPUT
    IF @Collation = 0
    BEGIN
        DELETE NVP FROM
            NameValuePair_Albanian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 1
    BEGIN
        DELETE NVP FROM
            NameValuePair_Arabic_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 2
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_PRC_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 3
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_PRC_Stroke_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 4
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_Taiwan_Bopomofo_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 5
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_Taiwan_Stroke_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 6
    BEGIN
        DELETE NVP FROM
            NameValuePair_Croatian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 7
    BEGIN
        DELETE NVP FROM
            NameValuePair_Cyrillic_General_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 8
    BEGIN
        DELETE NVP FROM
            NameValuePair_Czech_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 9
    BEGIN
        DELETE NVP FROM
            NameValuePair_Danish_Norwegian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 10
    BEGIN
        DELETE NVP FROM
            NameValuePair_Estonian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 11
    BEGIN
        DELETE NVP FROM
            NameValuePair_Finnish_Swedish_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 12
    BEGIN
        DELETE NVP FROM
            NameValuePair_French_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 13
    BEGIN
        DELETE NVP FROM
            NameValuePair_Georgian_Modern_Sort_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 14
    BEGIN
        DELETE NVP FROM
            NameValuePair_German_PhoneBook_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 15
    BEGIN
        DELETE NVP FROM
            NameValuePair_Greek_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 16
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hebrew_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 17
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hindi_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 18
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hungarian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 19
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hungarian_Technical_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 20
    BEGIN
        DELETE NVP FROM
            NameValuePair_Icelandic_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 21
    BEGIN
        DELETE NVP FROM
            NameValuePair_Japanese_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 22
    BEGIN
        DELETE NVP FROM
            NameValuePair_Japanese_Unicode_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 23
    BEGIN
        DELETE NVP FROM
            NameValuePair_Korean_Wansung_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 24
    BEGIN
        DELETE NVP FROM
            NameValuePair_Korean_Wansung_Unicode_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 25
    BEGIN
        DELETE NVP FROM
            NameValuePair_Latin1_General_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 26
    BEGIN
        DELETE NVP FROM
            NameValuePair_Latvian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 27
    BEGIN
        DELETE NVP FROM
            NameValuePair_Lithuanian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 28
    BEGIN
        DELETE NVP FROM
            NameValuePair_Lithuanian_Classic_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 29
    BEGIN
        DELETE NVP FROM
            NameValuePair_Traditional_Spanish_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 30
    BEGIN
        DELETE NVP FROM
            NameValuePair_Modern_Spanish_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 31
    BEGIN
        DELETE NVP FROM
            NameValuePair_Polish_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 32
    BEGIN
        DELETE NVP FROM
            NameValuePair_Romanian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 33
    BEGIN
        DELETE NVP FROM
            NameValuePair_Slovak_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 34
    BEGIN
        DELETE NVP FROM
            NameValuePair_Slovenian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 35
    BEGIN
        DELETE NVP FROM
            NameValuePair_Thai_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 36
    BEGIN
        DELETE NVP FROM
            NameValuePair_Turkish_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 37
    BEGIN
        DELETE NVP FROM
            NameValuePair_Ukrainian_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
    ELSE
    IF @Collation = 38
    BEGIN
        DELETE NVP FROM
            NameValuePair_Vietnamese_CI_AS AS NVP
        INNER JOIN @DocList DocList ON NVP.SiteId = @SiteId AND NVP.ListId = DocList.ListId AND NVP.ItemId = DocList.DoclibRowId WHERE NVP.ListId = @OldListId AND DocList.DoclibRowId IS NOT NULL
    END
                DELETE
                    UserDataVersioned
                FROM
                    UserDataVersioned INNER JOIN @DocList DocList
                ON
                    UserDataVersioned.tp_ListId = DocList.ListId AND
                    UserDataVersioned.tp_Id = Doclist.DoclibRowId
                WHERE
                    UserDataVersioned.tp_ListId = @OldListId AND
                    DocList.DoclibRowId IS NOT NULL
                IF @@ROWCOUNT <> @RowDelta
                    RETURN 87
                UPDATE
                    Lists
                SET
                    tp_ItemCount = tp_ItemCount -
                        @OldListDoclibItemDelta,
                    tp_LastDeleted = @Now,
                    tp_Modified = @Now
                WHERE
                    tp_WebID = @SubWebID AND
                    tp_ID = @OldListID
                UPDATE
                    @DocList
                SET
                    DoclibRowId =
                    CASE
                        WHEN DoclibRowId IS NOT NULL
                    THEN
                        CASE
                            @UseRowIds
                        WHEN
                            1
                        THEN
                            @NewDoclibRowId +
                            DoclibRowId -
                            @OldListMinDoclibRowId
                        ELSE
                            @NewDoclibRowId +
                            IdVal -
                            @OldListMinIdVal
                        END
                    ELSE
                        NULL
                    END
            END
            UPDATE
                @DocList
            SET
                ListId = @NewListId
        END
        IF (@RenamingList = 1 AND
            (@OldUrlLeafName <> @NewUrlLeafName) AND
            (@OldUrlLeafName = @OldListTitle))
        BEGIN
            UPDATE
                Lists
            SET
                tp_Title = @NewUrlLeafName,
                tp_Version = tp_Version + 1
            WHERE
                tp_WebId = @SubWebId AND
                tp_Id = @OldListID AND
                tp_Version = @OldListVersion
            IF ((@@ROWCOUNT <> 1) OR (@@ERROR <> 0))
            BEGIN
                RETURN 1150
            END
            EXEC proc_LogChange @SiteId, @SubWebId, @OldListId, NULL, NULL,
                NULL, NULL, NULL, 32768,
                2, @Now
            EXEC proc_UpdateSubsListSettings @SiteId, @OldListID, 
                @NewUrlLeafName, NULL, 0
        END
    END
    IF (@OldUrlDirName != @NewUrlDirName)
    BEGIN
        DECLARE @tmpDirName nvarchar(256)
        DECLARE @tmpLeafName nvarchar(128)
        EXEC proc_SplitUrl @OldUrlDirName,
            @tmpDirName OUTPUT, @tmpLeafName OUTPUT
        UPDATE
            Docs
        SET
            TimeLastModified = @Now
        WHERE
            SiteId = @SiteId AND
            DirName = @tmpDirName AND
            LeafName = @tmpLeafName AND
            WebId = @SubWebId
    END
    DECLARE @CtoMask int
    IF (@OldListId IS NOT NULL AND
        @NewListId IS NOT NULL AND 
        @OldListId = @NewListId)
    BEGIN    
        SET @CtoMask = ~0
    END
    ELSE
    BEGIN
        SET @CtoMask = ~8192
    END
    IF @NewListId IS NULL
    BEGIN
        IF @OldListId IS NOT NULL
        BEGIN
            UPDATE
                @DocList
            SET
                CtoOffset = NULL
        END
    END
    ELSE
    BEGIN
        DECLARE @NewParentDirName nvarchar(256)
        DECLARE @NewParentLeafName nvarchar(128)
        EXEC proc_SplitUrl
            @NewUrlDirName,
            @NewParentDirName OUTPUT,
            @NewParentLeafName OUTPUT
        DECLARE @NewCtoOffset int
        SELECT
            @NewCtoOffset = CtoOffset
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @NewParentDirName AND
            LeafName = @NewParentLeafName
        IF @OldListId = @NewListId
        BEGIN
            DECLARE @OldParentDirName nvarchar(256)
            DECLARE @OldParentLeafName nvarchar(128)
            EXEC proc_SplitUrl
                @OldUrlDirName,
                @OldParentDirName OUTPUT,
                @OldParentLeafName OUTPUT
            DECLARE @OldCtoOffset int
            SELECT
                @OldCtoOffset = CtoOffset
            FROM
                Docs
            WHERE
                SiteId = @SiteId AND
                DirName = @OldParentDirName AND
                LeafName = @OldParentLeafName
            DECLARE @Delta int
            SET @Delta = (DATALENGTH(@NewUrl)-DATALENGTH(@OldUrl))/2
            UPDATE
                @DocList
            SET
                CtoOffset = 
                    CASE 
                    WHEN CtoOffset IS NULL THEN @NewCtoOffset
                    WHEN CtoOffset = @OldCtoOffset THEN @NewCtoOffset 
                    ELSE CtoOffset + @Delta
                    END    
        END
        ELSE
        BEGIN
            UPDATE
                @DocList
            SET
                CtoOffset = @NewCtoOffset
        END
    END
    DECLARE @OldDoclibRowId int
    UPDATE
        Docs
    SET
        Docs.DirName = DocList.NewDirName,
        Docs.LeafName = DocList.NewLeafName,
        Docs.NextToLastTimeModified = Docs.TimeLastModified,
        Docs.TimeLastModified = CASE WHEN
            Docs.TimeLastModified IS NULL
            THEN
                NULL            
            ELSE
                @Now
            END,
        Docs.MetaInfoTimeLastModified = DocList.MetaInfoTimeLastModified,
        Docs.ListId = DocList.ListId,
        Docs.ParentId = @NewDocParentId,
        @OldDoclibRowId = Docs.DoclibRowId,
        Docs.DoclibRowId = DocList.DoclibRowId,
        Docs.Dirty = CASE
            WHEN
                Docs.DocFlags & 4 = 4
            THEN
                1
            ELSE
                Docs.Dirty
            END,
        Docs.CacheParseId = NULL,
        Docs.Version = CASE
            WHEN
                Docs.Version IS NULL
            THEN
                NULL
            ELSE
                Docs.Version + 1
            END,
        Docs.ScopeId = CASE
            WHEN
                @bRemoveFGP = 1
            THEN
                @WebScope
            ELSE
                ScopeId
            END,
        Docs.BuildDependencySet = NULL,        
        Docs.DocFlags = Docs.DocFlags & @CtoMask,
        Docs.CtoOffset = DocList.CtoOffset    
    FROM
        Docs INNER JOIN @DocList DocList
    ON
        Docs.SiteId = @SiteId AND
        Docs.DirName = DocList.OldDirName AND
        Docs.LeafName = DocList.OldLeafName AND
        Docs.Level = DocList.Level
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @OldUrlDirName AND
        Docs.LeafName = @OldUrlLeafName
    SET @NumDocsRenamed1 = @@ROWCOUNT
    DELETE FROM
        BuildDependencies
    WHERE
        SiteId = @SiteId AND
        DirName = @OldUrlDirName AND
        LeafName = @OldUrlLeafName
    IF (@NumDocsRenamed1 > 0)    
    BEGIN
    UPDATE
        Docs
    SET
        Docs.DirName = DocList.NewDirName,
        Docs.NextToLastTimeModified = Docs.TimeLastModified,
        Docs.TimeLastModified = CASE WHEN
            Docs.TimeLastModified IS NULL
            THEN
                NULL            
            ELSE
                @Now
            END,
        Docs.MetaInfoTimeLastModified = DocList.MetaInfoTimeLastModified,
        Docs.ListId = DocList.ListId,
        Docs.DoclibRowId = DocList.DoclibRowId,
        Docs.Dirty = CASE
            WHEN
                Docs.DocFlags & 4 = 4
            THEN
                1
            ELSE
                Docs.Dirty
            END,
        Docs.CacheParseId = NULL,
        Docs.Version = CASE
            WHEN
                Docs.Version IS NULL
            THEN
                NULL
            ELSE
                Docs.Version + 1
            END,
        Docs.ScopeId = CASE
            WHEN
                @bRemoveFGP = 1
            THEN
                @WebScope
            ELSE
                ScopeId
            END,
        Docs.BuildDependencySet = NULL,
        Docs.DocFlags = Docs.DocFlags & @CtoMask,
        Docs.CtoOffset = DocList.CtoOffset
    FROM
        Docs INNER JOIN @DocList DocList
    ON
        Docs.SiteId = @SiteId AND
        Docs.DirName = DocList.OldDirName AND
        Docs.LeafName = DocList.OldLeafName AND
        Docs.Level = DocList.Level
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @OldUrl
    SET @NumDocsRenamed2 = @@ROWCOUNT
    DELETE FROM
        BuildDependencies
    WHERE
        SiteId = @SiteId AND
        DirName = @OldUrl
    END
    IF (@NumDocsRenamed2 > 0)    
    BEGIN
    UPDATE
        Docs
    SET
        Docs.DirName = DocList.NewDirName,
        Docs.NextToLastTimeModified = Docs.TimeLastModified,
        Docs.TimeLastModified = CASE WHEN
            Docs.TimeLastModified IS NULL
            THEN
                NULL            
            ELSE
                @Now
            END,
        Docs.MetaInfoTimeLastModified = DocList.MetaInfoTimeLastModified,
        Docs.ListId = DocList.ListId,
        Docs.DoclibRowId = DocList.DoclibRowId,
        Docs.Dirty = CASE
            WHEN
                Docs.DocFlags & 4 = 4
            THEN
                1
            ELSE
                Docs.Dirty
            END,
        Docs.CacheParseId = NULL,
        Docs.Version = CASE
            WHEN
                Docs.Version IS NULL
            THEN
                NULL
            ELSE
                Docs.Version + 1
            END,
        Docs.ScopeId = CASE
            WHEN
                @bRemoveFGP = 1
            THEN
                @WebScope
            ELSE
                ScopeId
            END,
        Docs.BuildDependencySet = NULL,
        Docs.DocFlags = Docs.DocFlags & @CtoMask,
        Docs.CtoOffset = DocList.CtoOffset
    FROM
        Docs INNER JOIN @DocList DocList
    ON
        Docs.SiteId = @SiteId AND
        Docs.DirName = DocList.OldDirName AND
        Docs.LeafName = DocList.OldLeafName AND
        Docs.Level = DocList.Level
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName LIKE @OldUrlLike
    SET @NumDocsRenamed3 = @@ROWCOUNT
    DELETE FROM
        BuildDependencies
    WHERE
        SiteId = @SiteId AND
        DirName LIKE @OldUrlLike
    END
    IF ((@NumDocsRenamed1 + @NumDocsRenamed2 + @NumDocsRenamed3) <>
        @NumDocsToRename) OR (@@ERROR <> 0)
    BEGIN
        RETURN 1150
    END
    UPDATE
        UserData
    SET
        UserData.tp_DirName = DocList.NewDirName,
        UserData.tp_LeafName = DocList.NewLeafName
    FROM
        UserData INNER JOIN @DocList DocList
    ON
        UserData.tp_DirName = DocList.OldDirName AND
        UserData.tp_LeafName = DocList.OldLeafName
    WHERE
        UserData.tp_SiteId = @SiteId
    UPDATE
        UserDataVersioned
    SET
        UserDataVersioned.tp_DirName = DocList.NewDirName,
        UserDataVersioned.tp_LeafName = DocList.NewLeafName
    FROM
        UserDataVersioned INNER JOIN @DocList DocList
    ON
        UserDataVersioned.tp_DirName = DocList.OldDirName AND
        UserDataVersioned.tp_LeafName = DocList.OldLeafName
    WHERE
        UserDataVersioned.tp_SiteId = @SiteId AND
        UserDataVersioned.tp_IsCurrentVersion = CONVERT(bit, 0)
    IF (@OldDoclibRowId IS NOT NULL AND @NewListId IS NOT NULL)
    BEGIN
        IF (@OldListId = @NewListId)
        BEGIN
            EXEC proc_AddEventToCache
                @SiteId, 
                @SubWebId, 
                @OldListId,
                @OldDoclibRowId,
                @OldUrlLeafName,
                @NewUrl,
                @DirId,
                32768,
                N'',     
                @Now,
                NULL,
                NULL
        END        
        ELSE
        BEGIN
            EXEC proc_LogChange @SiteId, @SubWebId, @OldListId,
                @OldDoclibRowId, @DirId, @NewListId, @NewDoclibRowId, NULL,
                67108864,  1, @Now
            EXEC proc_LogChange @SiteId, @SubWebId, @NewListId,
                @NewDoclibRowId, @DirId, @OldListId, @OldDoclibRowId, NULL,
                65536,  1, @Now
        END
    END
    ELSE
    BEGIN
        IF (@OldUrlDirName = @NewUrlDirName)
        BEGIN
            EXEC proc_LogChange @SiteId, @SubWebId, NULL, NULL, @DirId, NULL,
                NULL, @NewUrl, 32768,
                32, @Now
        END
        ELSE
        BEGIN
            EXEC proc_LogChange @SiteId, @SubWebId, @OldListId, @OldDoclibRowId, @DirId, NULL,
                NULL, @NewUrl, 67108864, 32, @Now
            EXEC proc_LogChange @SiteId, @SubWebId, @NewListId, @NewDoclibRowId, @DirId, NULL,
                NULL, @NewUrl, 65536, 32, @Now
        END
    END
    DECLARE @OldWebUrl nvarchar(1024)
    IF (@RenamingWeb = 1)
    BEGIN
        DECLARE @NewWebUrl nvarchar(1024)
        DECLARE @OldWebUrlLike nvarchar(1024)
        SET @OldWebUrl = N'/' + @OldUrl
        SET @NewWebUrl = N'/' + @NewUrl
        SET @OldWebUrlLike = N'/' + @OldUrlLike
        UPDATE
            ImmedSubscriptions
        SET
            WebUrl = @NewWebUrl
        WHERE
            SiteId = @SiteId AND
            WebUrl = @OldWebUrl
        UPDATE
            ImmedSubscriptions
        SET
            WebUrl = STUFF(WebUrl, 1, LEN(@OldWebUrl), @NewWebUrl)
        WHERE
            SiteId = @SiteId AND
            WebUrl LIKE @OldWebUrlLike
        UPDATE
            SchedSubscriptions
        SET
            WebUrl = @NewWebUrl
        WHERE
            SiteId = @SiteId AND
            WebUrl = @OldWebUrl
        UPDATE
            SchedSubscriptions
        SET
            WebUrl = STUFF(WebUrl, 1, LEN(@OldWebUrl), @NewWebUrl)
        WHERE
            SiteId = @SiteId AND
            WebUrl LIKE @OldWebUrlLike
    END
    ELSE
    BEGIN
        DECLARE @LenWebUrl int
        DECLARE @OldListUrl nvarchar(256)
        DECLARE @NewListUrl nvarchar(256)
        DECLARE @OldListUrlLike nvarchar(1024)
        IF (@SubWebUrl = N'')
        BEGIN
            SET @OldWebUrl = N''
            SET @LenWebUrl = 0
        END
        ELSE
        BEGIN
            SET @OldWebUrl = N'/' + @SubWebUrl
            SET @LenWebUrl = LEN(@SubWebUrl) + 1
        END
        SET @OldListUrl = STUFF(@OldUrl, 1, @LenWebUrl, N'')
        SET @NewListUrl = STUFF(@NewUrl, 1, @LenWebUrl, N'')
        SET @OldListUrlLike = STUFF(@OldUrlLike, 1, @LenWebUrl, N'')
        UPDATE
            ImmedSubscriptions
        SET
            ListUrl = @NewListUrl
        WHERE
            SiteId = @SiteId AND
            WebUrl = @OldWebUrl AND
            ListUrl = @OldListUrl
        UPDATE
            ImmedSubscriptions
        SET
            ListUrl = STUFF(ListUrl, 1, LEN(@OldListUrl), @NewListUrl)
        WHERE
            SiteId = @SiteId AND
            WebUrl = @OldWebUrl AND
            ListUrl LIKE @OldListUrlLike
        UPDATE
            SchedSubscriptions
        SET
            ListUrl = @NewListUrl
        WHERE
            SiteId = @SiteId AND
            WebUrl = @OldWebUrl AND
            ListUrl = @OldListUrl
        UPDATE
            SchedSubscriptions
        SET
            ListUrl = STUFF(ListUrl, 1, LEN(@OldListUrl), @NewListUrl)
        WHERE
            SiteId = @SiteId AND
            WebUrl = @OldWebUrl AND
            ListUrl LIKE @OldListUrlLike
    END
    EXEC proc_DirtyDependents @SiteId, 1, @OldUrl, @OldUrlLike
    EXEC proc_NavStructDirtyNodesByUrl @SiteId, @NewUrl, NULL, @NewUrlLike,
        @Now
    UPDATE
        Links
    SET
        DirName = @NewUrlDirName,
        LeafName = @NewUrlLeafName
    WHERE
        SiteId = @SiteId AND
        DirName = @OldUrlDirName AND
        LeafName = @OldUrlLeafName
    UPDATE
        Links
    SET
        DirName = STUFF(DirName, 1, LEN(@OldUrl), @NewUrl)
    WHERE
        SiteId = @SiteId AND
        DirName = @OldUrl
    UPDATE
        Links
    SET
        DirName = STUFF(DirName, 1, LEN(@OldUrl), @NewUrl)
    WHERE
        SiteId = @SiteId AND
        DirName LIKE @OldUrlLike
    IF (@RenameFlags & 4 = 4)
    BEGIN
        UPDATE
            Links
        SET
            TargetDirName = LEFT(@NewUrlDirName, 256),
            TargetLeafName = @NewUrlLeafName
        WHERE
            SiteId = @SiteId AND
            TargetDirName = @OldUrlDirName AND
            TargetLeafName = @OldUrlLeafName
        IF (@@ERROR <> 0 )
        BEGIN
            RETURN 1150
        END
        UPDATE
            Docs
        SET
            Docs.Dirty = CASE
                WHEN
                    Docs.DocFlags & 4 =
                        4
                THEN
                    1
                ELSE
                    Docs.Dirty
                END,
            Docs.NextToLastTimeModified = Docs.TimeLastModified,
            Docs.TimeLastModified = CASE
                WHEN
                    Docs.TimeLastModified IS NULL
                THEN
                    Docs.TimeLastModified
                ELSE
                    @Now
                END,
            Docs.MetaInfoTimeLastModified = CASE
                WHEN
                    Docs.MetaInfoTimeLastModified IS NULL
                THEN
                    Docs.MetaInfoTimeLastModified
                ELSE
                    @Now
                END,
            Docs.Version = CASE
                WHEN
                    Docs.Version IS NULL
                THEN
                    Docs.Version
                ELSE
                    Docs.Version + 1
                END,
            Docs.CacheParseId = NULL
        FROM
            Docs INNER JOIN Links
        ON
            Docs.SiteId = Links.SiteId AND
            Docs.DirName = Links.DirName AND
            Docs.LeafName = Links.LeafName
        WHERE
            Links.SiteId = @SiteId AND
            Links.TargetDirName = LEFT(@NewUrlDirName, 256) AND
            Links.TargetLeafName = @NewUrlLeafName AND
            Links.Type <> 86 
        IF (@@ERROR <> 0 )
        BEGIN
            RETURN 1150
        END
        UPDATE
            Webs
        SET
            Webs.MetaInfoVersion = Webs.MetaInfoVersion + 1,
            Webs.MasterUrl = CASE WHEN (DATALENGTH(@NewUrlDirName) = 0) THEN @NewUrlLeafName WHEN (DATALENGTH(@NewUrlLeafName) = 0) THEN @NewUrlDirName ELSE @NewUrlDirName + N'/' + @NewUrlLeafName END,
            Webs.LastMetaDataChange = @Now
        FROM
            Webs
        WHERE
            Webs.SiteId = @SiteId AND
            Webs.MasterUrl = @OldUrl
        IF (@@ERROR <> 0 )
        BEGIN
            RETURN 1150
        END
        UPDATE
            Webs
        SET
            Webs.MetaInfoVersion = Webs.MetaInfoVersion + 1,
            Webs.CustomMasterUrl = CASE WHEN (DATALENGTH(@NewUrlDirName) = 0) THEN @NewUrlLeafName WHEN (DATALENGTH(@NewUrlLeafName) = 0) THEN @NewUrlDirName ELSE @NewUrlDirName + N'/' + @NewUrlLeafName END,
            Webs.LastMetaDataChange = @Now
        FROM
            Webs
        WHERE
            Webs.SiteId = @SiteId AND
            Webs.CustomMasterUrl = @OldUrl
        IF (@@ERROR <> 0 )
        BEGIN
            RETURN 1150
        END
        UPDATE
            Links
        SET
            TargetDirName = LEFT(STUFF(TargetDirName, 1, LEN(@OldUrl), @NewUrl), 256)
        WHERE
            SiteId = @SiteId AND
            TargetDirName = @OldUrl
        IF (@@ERROR <> 0 )
        BEGIN
            RETURN 1150
        END
        UPDATE 
            Docs
        SET
            Docs.BuildDependencySet = NULL
        FROM 
            Docs INNER JOIN BuildDependencies
        ON
            BuildDependencies.SiteId = Docs.SiteId AND
            BuildDependencies.LeafName = Docs.LeafName AND
            BuildDependencies.DirName = Docs.DirName
        WHERE 
            BuildDependencies.SiteId = @SiteId AND
            BuildDependencies.TargetDirName = @OldUrl AND
            Docs.BuildDependencySet IS NOT NULL
        IF (@@ERROR <> 0 )
        BEGIN
            RETURN 1150
        END
        UPDATE
            Docs
        SET
            Docs.Dirty = CASE
                WHEN
                    Docs.DocFlags & 4 =
                        4
                THEN
                    1
                ELSE
                    Docs.Dirty
                END,
            Docs.NextToLastTimeModified = Docs.TimeLastModified,
            Docs.TimeLastModified = CASE
                WHEN
                    Docs.TimeLastModified IS NULL
                THEN
                    Docs.TimeLastModified
                ELSE
                    @Now
                END,
            Docs.MetaInfoTimeLastModified = CASE
                WHEN
                    Docs.MetaInfoTimeLastModified IS NULL
                THEN
                    Docs.MetaInfoTimeLastModified
                ELSE
                    @Now
                END,
            Docs.Version = CASE
                WHEN
                    Docs.Version IS NULL
                THEN
                    Docs.Version
                ELSE
                    Docs.Version + 1
                END,
            Docs.CacheParseId = NULL
        FROM
            Docs INNER JOIN Links
        ON
            Docs.SiteId = Links.SiteId AND
            Docs.DirName = Links.DirName AND
            Docs.LeafName = Links.LeafName
        WHERE
            Links.SiteId = @SiteId AND
            Links.TargetDirName = @NewUrl AND
            Links.Type <> 86 
        IF (@@ERROR <> 0 )
        BEGIN
            RETURN 1150
        END
        UPDATE
            Webs
        SET
            Webs.MetaInfoVersion = Webs.MetaInfoVersion + 1,
            Webs.MasterUrl = STUFF(MasterUrl, 1, LEN(@OldUrl), @NewUrl),
            Webs.LastMetaDataChange = @Now
        FROM
            Webs
        WHERE
            Webs.SiteId = @SiteId AND
            Webs.MasterUrl LIKE @OldUrlLike
        IF (@@ERROR <> 0 )
        BEGIN
            RETURN 1150
        END
        UPDATE
            Webs
        SET
            Webs.MetaInfoVersion = Webs.MetaInfoVersion + 1,
            Webs.CustomMasterUrl = STUFF(CustomMasterUrl, 1, LEN(@OldUrl), @NewUrl),
            Webs.LastMetaDataChange = @Now
        FROM
            Webs
        WHERE
            Webs.SiteId = @SiteId AND
            Webs.CustomMasterUrl LIKE @OldUrlLike
        IF (@@ERROR <> 0 )
        BEGIN
            RETURN 1150
        END
        UPDATE 
            Docs
        SET
            Docs.BuildDependencySet = NULL
        FROM 
            Docs INNER JOIN BuildDependencies
        ON
            BuildDependencies.SiteId = Docs.SiteId AND
            BuildDependencies.LeafName = Docs.LeafName AND
            BuildDependencies.DirName = Docs.DirName
        WHERE 
            BuildDependencies.SiteId = @SiteId AND
            BuildDependencies.TargetDirName LIKE @OldUrlLike AND
            Docs.BuildDependencySet IS NOT NULL
        IF (@@ERROR <> 0 )
        BEGIN
            RETURN 1150
        END
        UPDATE
            Links
        SET
            TargetDirName = LEFT(STUFF(TargetDirName, 1, LEN(@OldUrl), @NewUrl), 256)
        WHERE
            SiteId = @SiteId AND
            TargetDirName LIKE @OldUrlLike
        IF (@@ERROR <> 0 )
        BEGIN
            RETURN 1150
        END
        UPDATE
            Docs
        SET
            Docs.Dirty = CASE
                WHEN
                    Docs.DocFlags & 4 =
                        4
                THEN
                    1
                ELSE
                    Docs.Dirty
                END,
            Docs.NextToLastTimeModified = Docs.TimeLastModified,
            Docs.TimeLastModified = CASE
                WHEN
                    Docs.TimeLastModified IS NULL
                THEN
                    Docs.TimeLastModified
                ELSE
                    @Now
                END,
            Docs.MetaInfoTimeLastModified = CASE
                WHEN
                    Docs.MetaInfoTimeLastModified IS NULL
                THEN
                    Docs.MetaInfoTimeLastModified
                ELSE
                    @Now
                END,
            Docs.CacheParseId = NULL,
            Docs.Version = CASE
                WHEN
                    Docs.Version IS NULL
                THEN
                    Docs.Version
                ELSE
                    Docs.Version + 1
                END
        FROM
            Docs INNER JOIN Links
        ON
            Docs.SiteId = Links.SiteId AND
            Docs.DirName = Links.DirName AND
            Docs.LeafName = Links.LeafName
        WHERE
            Links.SiteId = @SiteId AND
            Links.TargetDirName LIKE @NewUrlLike AND
            Links.Type = 86 
        IF (@@ERROR <> 0 )
        BEGIN
            RETURN 1150
        END
    END
    DECLARE @IterCount int SELECT @IterCount = 0 WHILE @IterCount < 32 BEGIN INSERT INTO @DepList (DocUrl, Level) SELECT DISTINCT Deps.FullUrl,Deps.Level FROM @DepList DepList1 INNER JOIN Deps ON Deps.DepType = 1 AND Deps.DepDesc = DepList1.DocUrl AND DepList1.Level = 1 LEFT OUTER JOIN @DepList DepList2 ON DepList2.DocUrl = Deps.FullUrl WHERE Deps.SiteId = @SiteId AND Deps.DeleteTransactionId = 0x AND DepList2.DocUrl IS NULL IF @@RowCount = 0 BREAK SELECT @IterCount = @IterCount + 1 END IF @IterCount >= 32 BEGIN INSERT INTO @DepList (DocUrl,Level) SELECT DISTINCT FullUrl,Level FROM Deps WHERE DepType = 1 AND SiteId = @SiteId AND DeleteTransactionId = 0x AND FullUrl NOT IN (SELECT DocUrl FROM @DepList) END UPDATE Docs SET Docs.Dirty = 1, Docs.CacheParseId = NULL FROM Docs INNER JOIN @DepList DepList1 ON Docs.SiteId = @SiteId AND Docs.DirName = DepList1.DirName AND Docs.LeafName = DepList1.LeafName AND Docs.Level = DepList1.Level
    IF (@RenameFlags & 4 = 4) AND
        (@ReturnFlags & 0x02) = 0x02
    BEGIN
        SELECT DocUrl FROM @DepList
    END
    UPDATE
        Deps
    SET
        FullUrl = STUFF(FullUrl, 1, LEN(@OldUrl), @NewUrl)
    WHERE
        SiteId = @SiteId AND
        DeleteTransactionId = 0x AND
        (FullUrl = @OldUrl OR
            FullUrl LIKE @OldUrlLike)
    IF (@@ERROR <> 0 )
    BEGIN
        RETURN 1150
    END
    UPDATE
        Deps
    SET
        DepDesc = STUFF(DepDesc, 1, LEN(@OldUrl), @NewUrl)
    WHERE
        SiteId = @SiteId AND
        DeleteTransactionId = 0x AND
        (DepDesc = @OldUrl OR
            DepDesc LIKE @OldUrlLike) AND
        (DepType = 1 OR DepType = 8)
    IF (@@ERROR <> 0 )
    BEGIN
        RETURN 1150
    END
    EXEC proc_ResyncWelcomeLinks @SiteId, @OldUrl, NULL, NULL
    EXEC proc_ResyncWelcomeLinks @SiteId, @NewUrl, NULL, NULL
    IF (@bRemoveFGP = 1)
    BEGIN
        DELETE FROM 
            Perms
        WHERE
            SiteId = @SiteId AND
            DelTransId = 0x AND
                (ScopeUrl = @OldUrl OR ScopeUrl LIKE @OldUrlLike)
    END
    ELSE
    BEGIN
        UPDATE
            Perms
        Set
            ScopeUrl = STUFF(ScopeUrl, 1, Len(@OldUrl), @NewUrl)
        WHERE
            SiteId = @SiteId AND
            DelTransId = 0x AND
                (ScopeUrl = @OldUrl OR ScopeUrl LIKE @OldUrlLike)
    END
    IF (@bRemoveFGP = 0 AND @RenamingList = 0 AND @RenamingWeb = 0 AND @OldUrlDirName != @NewUrlDirName)
    BEGIN        
        EXEC proc_SplitUrl @NewUrlDirName,
            @tmpDirName OUTPUT, @tmpLeafName OUTPUT
        SELECT
            @DestScopeId  = ScopeId
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            WebId = @SubWebId AND
            DirName = @tmpDirName AND
            LeafName = @tmpLeafName
        IF (@bWasUnique = 1)
        BEGIN
            EXEC proc_SecFixScope @SiteId, @SubWebId, @SrcScopeId
            IF @bResetDestFGP = 1
                EXEC proc_DirtyListFGPData @SiteId, @SubWebId, @NewListId    
        END
        IF (@bWasUnique = 0 AND @SrcScopeId <> @DestScopeId)
        BEGIN
            UPDATE Docs
            SET 
                ScopeId = @DestScopeId
            WHERE 
                SiteId = @SiteId AND
                WebId = @SubWebId AND
                ScopeId = @SrcScopeId AND
                ( (DirName = @NewUrlDirName AND LeafName = @NewUrlLeafName) OR
                   DirName = @NewUrl OR DirName LIKE @NewUrlLike)
        END        
    END
    IF (@RenamingWeb = 1)
    BEGIN
        DECLARE @OldRelUrl nvarchar(260)
        DECLARE @NewRelUrl nvarchar(260)
        DECLARE @UrlStart int
        IF (@ParentWebId = @DstUrlParentWebId)
        BEGIN
            DECLARE @ParentFullUrl nvarchar(260)
            SELECT
                @ParentFullUrl = FullUrl
            FROM
                Webs
            WHERE
                Id = @ParentWebId
            SET @OldRelUrl = CASE WHEN (DATALENGTH(@ParentFullUrl) = 0) THEN @OldUrl ELSE SUBSTRING(@OldUrl, LEN(@ParentFullUrl) + 2, 260) END
            SET @NewRelUrl = CASE WHEN (DATALENGTH(@ParentFullUrl) = 0) THEN @NewUrl ELSE SUBSTRING(@NewUrl, LEN(@ParentFullUrl) + 2, 260) END
            SET @UrlStart = 1 + @SubWebAncestrySize
                            + DATALENGTH(CONVERT(varbinary(8), N';#;#'))
                            + DATALENGTH(CONVERT(varbinary(16), @SubWebId))
                            + DATALENGTH(CONVERT(varbinary(4), N';#'))
                            + DATALENGTH(N'U')
                            + DATALENGTH(CONVERT(varbinary(4), N';#'))
                            + DATALENGTH(REPLACE(@WebTitle, N';', N';;'))
                            + DATALENGTH(CONVERT(varbinary(4), N';#'))
        END
        UPDATE
            Webs
        SET
            FullUrl = STUFF(FullUrl, 1, LEN(@OldUrl), @NewUrl),
            Ancestry = CASE
                WHEN
                    @ParentWebId <> @DstUrlParentWebId
                THEN
                    NULL
                WHEN
                    Id = @SubWebId
                THEN
                    Ancestry
                ELSE
                    STUFF(SUBSTRING(Webs.Ancestry, 1, DATALENGTH(Webs.Ancestry)), @UrlStart,
                          DATALENGTH(REPLACE(@OldRelUrl, N';', N';;')),
                          CONVERT(varbinary(520), REPLACE(@NewRelUrl, N';', N';;')))
                END
        WHERE
            SiteId = @SiteId AND
            (FullUrl = @OldUrl OR
                FullUrl LIKE @OldUrlLike)
        IF ((@@ROWCOUNT = 0) OR (@@ERROR <> 0))
        BEGIN
            RETURN 1150
        END
        IF (@RenamingWebDir = 1)
        BEGIN
            DECLARE @NewFirstUniqueAncestorWebId uniqueidentifier
            DECLARE @NewNavParentWebId uniqueidentifier
            DECLARE @NewScopeId uniqueidentifier
            SELECT
                @NewFirstUniqueAncestorWebId = FirstUniqueAncestorWebId,
                @NewNavParentWebId = ISNULL(NavParentWebId, Id),
                @NewScopeId = ScopeId
            FROM
                Webs
            WHERE
                SiteId = @SiteId AND
                Id = @DstUrlParentWebId
            IF (@@ROWCOUNT = 0)
            BEGIN
                RETURN 2
            END
            IF (@SubWebId <> @FirstUniqueAncestorWebId AND
                @ScopeId <> @NewScopeId)
            BEGIN
                UPDATE
                    Webs
                SET
                    ScopeId = @NewScopeId,
                    FirstUniqueAncestorWebId = @NewFirstUniqueAncestorWebId
                WHERE
                    SiteId = @SiteId AND
                    ScopeId = @ScopeId AND
                    (FullUrl = @NewUrl OR FullUrl LIKE @NewUrlLike)
                UPDATE Docs
                SET 
                    ScopeId = @NewScopeId
                WHERE 
                    SiteId = @SiteId AND
                    ScopeId = @ScopeId AND
                    ( (DirName = @NewUrlDirName AND LeafName = @NewUrlLeafName) OR
                       DirName = @NewUrl OR DirName LIKE @NewUrlLike)
                UPDATE Lists
                SET 
                    tp_ScopeId = @NewScopeId
                WHERE
                    tp_ScopeId = @ScopeId AND
                    tp_WebId IN
                        (SELECT Id
                         FROM Webs
                         WHERE
                            SiteId = @SiteId AND
                            ScopeId = @NewScopeId)
                EXEC proc_SecUpdateSiteLevelSecurityMetadata @SiteId, 0, 0
            END
            IF (@NavParentWebId IS NOT NULL AND
                @NavParentWebId <> @NewNavParentWebId)
            BEGIN
                UPDATE
                    Webs
                SET
                    NavParentWebId = @NewNavParentWebId
                WHERE
                    SiteId = @SiteId AND
                    (FullUrl = @NewUrl OR FullUrl LIKE @NewUrlLike) AND
                    NavParentWebId = @NavParentWebId
            END
            UPDATE
                Webs
            SET
                ParentWebId = @DstUrlParentWebId
            WHERE
                SiteId = @SiteId AND
                Id = @SubWebId
            IF ((@@ROWCOUNT = 0) OR (@@ERROR <> 0))
            BEGIN
                RETURN 1150
            END
        END
        EXEC proc_LogChange @SiteId, @SubWebId, NULL, NULL, NULL, NULL, NULL,
            NULL, 32768,  4, @Now
        UPDATE
            ContentTypes
        SET
            ContentTypes.Scope = STUFF(ContentTypes.Scope, 1,
                LEN(@OldUrl), @NewUrl)
        WHERE
            ContentTypes.SiteId = @SiteId AND
            ContentTypes.Class = 0 AND
            (ContentTypes.Scope = @OldUrl OR
                ContentTypes.Scope LIKE @OldUrlLike)
        UPDATE
            ContentTypes
        SET
            ContentTypes.Scope = STUFF(ContentTypes.Scope, 1,
                LEN(@OldUrl), @NewUrl)
        WHERE
            ContentTypes.SiteId = @SiteId AND
            ContentTypes.Class = 1 AND
            (ContentTypes.Scope = @OldUrl OR
                ContentTypes.Scope LIKE @OldUrlLike)
    END
    EXEC proc_RenameDirJunctions @SiteId, @OldUrl, @OldUrlLike, @NewUrl
    EXEC proc_UpdateDiskUsed @SiteId, 1
    RETURN 0

GO
