/****** Object:  StoredProcedure [dbo].[proc_DeleteWeb]    Script Date: 5/15/2018 12:11:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteWeb(
    @WebSiteId uniqueidentifier,
    @WebUrl nvarchar(260),
    @FailedUrl nvarchar(260) = NULL OUTPUT,
    @DeleteFlags int = 0,
    @WebIdDelete uniqueidentifier = null)
AS
    SET NOCOUNT ON
    DECLARE @ReturnStatus int
    SET @ReturnStatus = 0
    DECLARE @WebId                    uniqueidentifier
    DECLARE @WebParentWebId           uniqueidentifier
    DECLARE @WebParentDocId           uniqueidentifier
    DECLARE @guidT                    uniqueidentifier
    DECLARE @WebDirName nvarchar(256)
    DECLARE @WebLeafName nvarchar(128)
    DECLARE @FailedDirName nvarchar(256)
    DECLARE @FailedLeafName nvarchar(128)
    DECLARE @OrphanDelete bit
    DECLARE @ParentDirName nvarchar(256)
    DECLARE @ParentLeafName nvarchar(128)
    DECLARE @UrlLike nvarchar(1024)
    EXEC proc_EscapeForLike @WebUrl, @UrlLike OUTPUT
    EXEC proc_SplitUrl @WebUrl, @WebDirName OUTPUT, 
        @WebLeafName OUTPUT
    EXEC proc_GetAuditMask 6, @WebSiteId, 
        @WebDirName, @WebLeafName        
    SET @OrphanDelete = @DeleteFlags & 8
    BEGIN TRAN
    SELECT
        @WebId  = Docs.WebId
    FROM
         Docs WITH (NOLOCK)
    WHERE
        Docs.SiteId = @WebSiteId AND
        Docs.DirName = @WebDirName AND
        Docs.LeafName = @WebLeafName AND
        Docs.Type = 2
    IF @OrphanDelete = 1 AND @WebId IS NULL
    BEGIN
        SELECT
            @WebId                    = Webs.Id,
            @WebParentWebId           = Webs.ParentWebId
        FROM
            Webs WITH (NOLOCK)
        WHERE
            Webs.FullUrl = @WebUrl
    END
    IF @WebId IS NULL
    BEGIN
        IF (@WebIdDelete IS NULL)
        BEGIN
            SET @ReturnStatus = 3
            GOTO cleanup
        END
        ELSE
        BEGIN
            SET @WebId = @WebIdDelete
        END
    END
    EXEC proc_SplitUrl @WebDirName,
        @ParentDirName OUTPUT, @ParentLeafName OUTPUT
    SELECT
        @WebParentDocId = Docs.Id
    FROM
        Docs WITH (UPDLOCK)
    WHERE
        Docs.SiteId = @WebSiteId AND
        Docs.DirName = @ParentDirName AND
        Docs.LeafName = @ParentLeafName
    SELECT
        @guidT = tp_WebId
    FROM
        Lists WITH(XLOCK)
    WHERE
        tp_WebId = @WebId
    DECLARE @Collation smallint
    SELECT
        @Collation = Collation,
        @WebParentWebId = ParentWebId
    FROM
        Webs WITH (XLOCK)
    WHERE
        Id = @WebId   
    DELETE
        Webs 
    WHERE
        Webs.Id = @WebId
    SELECT
        @WebParentDocId  = Docs.ParentId
    FROM
        Docs WITH (XLOCK)
    WHERE
        Docs.SiteId = @WebSiteId AND
        Docs.DirName = @WebDirName AND
        Docs.LeafName = @WebLeafName AND
        Docs.Type = 2
    IF @WebParentWebId IS NULL AND @OrphanDelete = 0
    BEGIN
        SET @ReturnStatus = 5
        GOTO cleanup
    END
    IF (@OrphanDelete = 0)
    BEGIN
        DECLARE @WantFlags int
        SET @WantFlags = 0x0080
        EXEC @ReturnStatus = proc_CheckDirectoryTree @WebSiteId,
            @WebUrl, @WebUrl, NULL, @WantFlags,
            @FailedDirName OUTPUT,
            @FailedLeafName OUTPUT
        IF @ReturnStatus <> 0
        BEGIN
            IF @FailedDirName IS NOT NULL AND @FailedLeafName IS NOT NULL
            BEGIN
                SET @FailedUrl = CASE WHEN (DATALENGTH(@FailedDirName) = 0) THEN @FailedLeafName WHEN (DATALENGTH(@FailedLeafName) = 0) THEN @FailedDirName ELSE @FailedDirName + N'/' + @FailedLeafName END
            END
            GOTO cleanup
        END
    END    
    DECLARE @DocsDeleted table (
        Id uniqueidentifier NOT NULL)
    INSERT INTO @DocsDeleted(
        Id)
    SELECT
        Id
    FROM
        Docs
    WHERE        
        SiteId = @WebSiteId AND
        (DirName = @WebUrl OR
            DirName LIKE @UrlLike)
    INSERT INTO @DocsDeleted(
        Id)
    SELECT
        Id
    FROM
        Docs
    WHERE
        SiteId = @WebSiteId AND
        DirName = @WebDirName AND
        LeafName = @WebLeafName
    INSERT INTO @DocsDeleted(
        Id)
    SELECT
        Id
    FROM
        AllDocs
    WHERE
        SiteId = @WebSiteId AND
        DeleteTransactionId <> 0x AND
        WebId = @WebId
    DELETE FROM
        Categories
    WHERE
        DocId
    IN
        (SELECT Id FROM @DocsDeleted)
    DELETE FROM
        WebCat
    WHERE
        WebCat.WebId = @WebId
    DELETE FROM
        WebPartLists
    WHERE
        tp_SiteId = @WebSiteId AND
        tp_PageUrlId
    IN
        (SELECT Id FROM @DocsDeleted)
    DELETE
        WebPartLists
    FROM
        AllLists
    INNER JOIN
        WebPartLists
    ON
        WebPartLists.tp_ListId = AllLists.tp_Id
    WHERE
        AllLists.tp_WebId = @WebId    
    DELETE FROM
        DocVersions
    WHERE
        Id
    IN
        (SELECT Id FROM @DocsDeleted)
    DELETE 
        AllUserData 
    FROM
        AllLists, AllUserData
    WHERE
        AllLists.tp_WebId = @WebId AND
        AllUserData.tp_ListId = AllLists.tp_ID
    DELETE
        NVP
    FROM
        NameValuePair AS NVP, AllLists
    WHERE
        SiteId = @WebSiteId AND
        AllLists.tp_WebId = @WebId AND
        NVP.ListId = AllLists.tp_ID
    IF @Collation = 0
    BEGIN
        DELETE NVP FROM
            NameValuePair_Albanian_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 1
    BEGIN
        DELETE NVP FROM
            NameValuePair_Arabic_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 2
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_PRC_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 3
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_PRC_Stroke_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 4
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_Taiwan_Bopomofo_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 5
    BEGIN
        DELETE NVP FROM
            NameValuePair_Chinese_Taiwan_Stroke_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 6
    BEGIN
        DELETE NVP FROM
            NameValuePair_Croatian_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 7
    BEGIN
        DELETE NVP FROM
            NameValuePair_Cyrillic_General_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 8
    BEGIN
        DELETE NVP FROM
            NameValuePair_Czech_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 9
    BEGIN
        DELETE NVP FROM
            NameValuePair_Danish_Norwegian_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 10
    BEGIN
        DELETE NVP FROM
            NameValuePair_Estonian_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 11
    BEGIN
        DELETE NVP FROM
            NameValuePair_Finnish_Swedish_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 12
    BEGIN
        DELETE NVP FROM
            NameValuePair_French_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 13
    BEGIN
        DELETE NVP FROM
            NameValuePair_Georgian_Modern_Sort_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 14
    BEGIN
        DELETE NVP FROM
            NameValuePair_German_PhoneBook_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 15
    BEGIN
        DELETE NVP FROM
            NameValuePair_Greek_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 16
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hebrew_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 17
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hindi_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 18
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hungarian_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 19
    BEGIN
        DELETE NVP FROM
            NameValuePair_Hungarian_Technical_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 20
    BEGIN
        DELETE NVP FROM
            NameValuePair_Icelandic_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 21
    BEGIN
        DELETE NVP FROM
            NameValuePair_Japanese_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 22
    BEGIN
        DELETE NVP FROM
            NameValuePair_Japanese_Unicode_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 23
    BEGIN
        DELETE NVP FROM
            NameValuePair_Korean_Wansung_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 24
    BEGIN
        DELETE NVP FROM
            NameValuePair_Korean_Wansung_Unicode_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 25
    BEGIN
        DELETE NVP FROM
            NameValuePair_Latin1_General_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 26
    BEGIN
        DELETE NVP FROM
            NameValuePair_Latvian_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 27
    BEGIN
        DELETE NVP FROM
            NameValuePair_Lithuanian_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 28
    BEGIN
        DELETE NVP FROM
            NameValuePair_Lithuanian_Classic_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 29
    BEGIN
        DELETE NVP FROM
            NameValuePair_Traditional_Spanish_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 30
    BEGIN
        DELETE NVP FROM
            NameValuePair_Modern_Spanish_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 31
    BEGIN
        DELETE NVP FROM
            NameValuePair_Polish_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 32
    BEGIN
        DELETE NVP FROM
            NameValuePair_Romanian_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 33
    BEGIN
        DELETE NVP FROM
            NameValuePair_Slovak_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 34
    BEGIN
        DELETE NVP FROM
            NameValuePair_Slovenian_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 35
    BEGIN
        DELETE NVP FROM
            NameValuePair_Thai_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 36
    BEGIN
        DELETE NVP FROM
            NameValuePair_Turkish_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 37
    BEGIN
        DELETE NVP FROM
            NameValuePair_Ukrainian_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    ELSE
    IF @Collation = 38
    BEGIN
        DELETE NVP FROM
            NameValuePair_Vietnamese_CI_AS AS NVP
        , AllLists WHERE SiteId = @WebSiteId AND AllLists.tp_WebId = @WebId AND NVP.ListId = AllLists.tp_ID
    END
    DELETE
        WebParts
    WHERE
        tp_SiteId = @WebSiteId AND
        tp_PageUrlId
    IN
        (SELECT Id FROM @DocsDeleted)
    DELETE
        WebParts
    FROM
        AllLists
    INNER JOIN
        WebParts
    ON
        WebParts.tp_ListId = AllLists.tp_Id
    WHERE
        AllLists.tp_WebId = @WebId
    DELETE FROM
        AllLists
    WHERE
        tp_WebId = @WebId
    DELETE
        DocStreams
    FROM
        Docs WITH (XLOCK) 
    INNER JOIN 
        DocStreams
    ON
        Docs.SiteId = DocStreams.SiteId AND
        Docs.ParentId = DocStreams.ParentId AND
        Docs.Id = DocStreams.Id AND
        Docs.Level = DocStreams.Level
    WHERE        
        Docs.SiteId = @WebSiteId AND
        (Docs.DirName = @WebUrl OR
            Docs.DirName LIKE @UrlLike)
    DELETE
        AllDocStreams
    FROM
        AllDocs WITH (XLOCK) 
    INNER JOIN 
        RecycleBin
    ON
        AllDocs.SiteId = RecycleBin.SiteId AND
        AllDocs.DeleteTransactionId = RecycleBin.DeleteTransactionId AND
        AllDocs.WebId = RecycleBin.WebId
    INNER JOIN
        AllDocStreams
    ON
        AllDocs.SiteId = AllDocStreams.SiteId AND
        AllDocs.DeleteTransactionId = AllDocStreams.DeleteTransactionId AND
        AllDocs.ParentId = AllDocStreams.ParentId AND
        AllDocs.Id = AllDocStreams.Id AND
        AllDocs.Level = AllDocStreams.Level
    WHERE
        AllDocs.SiteId = @WebSiteId AND
        AllDocs.DeleteTransactionId <> 0x AND
        (AllDocs.DirName = @WebUrl OR
            AllDocs.DirName LIKE @UrlLike) AND
        AllDocs.WebId = @WebId
    DELETE FROM
        Docs
    WHERE        
        SiteId = @WebSiteId AND
        (DirName = @WebUrl OR
            DirName LIKE @UrlLike)
    DELETE FROM
        Docs
    WHERE
        SiteId = @WebSiteId AND
        DirName = @WebDirName AND
        LeafName = @WebLeafName
    DELETE FROM
        AllDocs
    WHERE
        SiteId = @WebSiteId AND
        DeleteTransactionId <> 0x AND
        WebId = @WebId
    DELETE FROM
        Links
    WHERE
        SiteId = @WebSiteId AND
        (DirName = @WebUrl OR
            DirName LIKE @UrlLike) 
    DELETE FROM
        AllLinks
    WHERE
        SiteId = @WebSiteId AND
        DeleteTransactionId IN (
            SELECT 
                DeleteTransactionId 
            FROM 
                RecycleBin
            WHERE
                SiteId = @WebSiteId AND
                WebId = @WebId)    
    DELETE FROM 
        BuildDependencies
    WHERE
        SiteId = @WebSiteId AND
        (DirName = @WebUrl OR
            DirName LIKE @UrlLike) 
    DELETE FROM
        Deps
    WHERE
        SiteId = @WebSiteId AND
        DeleteTransactionId = 0x AND
        (FullUrl = @WebUrl OR
            FullUrl LIKE @UrlLike)
    DELETE FROM
        Deps
    WHERE
        SiteId = @WebSiteId AND
        DeleteTransactionId IN (
            SELECT 
                DeleteTransactionId 
            FROM 
                RecycleBin
            WHERE
                SiteId = @WebSiteId AND
                WebId = @WebId)    
    DELETE RoleAssignment
    FROM
        RoleAssignment, Perms
    WHERE
        RoleAssignment.SiteId = @WebSiteId AND
        RoleAssignment.ScopeId = Perms.ScopeId AND
        Perms.SiteId = @WebSiteId AND
        Perms.WebId = @WebId
    DELETE FROM 
        Perms
    WHERE
        Perms.SiteId = @WebSiteId AND 
        Perms.WebId = @WebId
    DELETE FROM
        Roles
    WHERE
        WebId = @WebId
    DELETE FROM
        EventReceivers
    WHERE
        SiteId = @WebSiteId AND
        WebId = @WebId
    DELETE FROM
         WebMembers
    WHERE
         WebId = @WebId
    DELETE FROM
        Webs
    WHERE
        Id = @WebId
    EXEC proc_LogChange @WebSiteId, @WebId, NULL, NULL, NULL, NULL, NULL, @WebUrl,
        16384,  4, NULL
    DELETE FROM
        ImmedSubscriptions
    WHERE
        SiteId = @WebSiteId AND
        WebId = @WebId
    DELETE FROM
        SchedSubscriptions
    WHERE
        SiteId = @WebSiteId AND
        WebId = @WebId
    DELETE FROM
        NavNodes
    WHERE
        SiteId = @WebSiteId AND
        WebId = @WebId
    DECLARE @DeletedParentEids table ( Eid int, EidParent int, RankChild int, WebId uniqueidentifier, UNIQUE(EidParent, RankChild, WebId))
    INSERT INTO @DeletedParentEids (Eid, EidParent, RankChild, WebId)
        SELECT
            Eid,
            EidParent,
            RankChild,
            WebId
        FROM
            NavNodes
        WHERE
            SiteId = @WebSiteId AND
            DocId
        IN
            (SELECT Id FROM @DocsDeleted)
    IF @@ROWCOUNT <> 0
    BEGIN
        DECLARE @SiteId uniqueidentifier
        SET @SiteId = @WebSiteId
    DECLARE @DeletedEids TABLE ( Eid int, WebId uniqueidentifier, EidParent int, NavCacheMask int, DocId uniqueidentifier NULL, Stage tinyint, UNIQUE(WebId, Eid, Stage))
    INSERT INTO @DeletedEids (
        Eid,
        WebId,
        EidParent,
        NavCacheMask,
        DocId,
        Stage)
        SELECT
            Eid,
            WebId,
            EidParent,
            dbo.fn_NavCacheMask(EidParent),
            NULL, 
            0
        FROM
            @DeletedParentEids
    WHILE @@RowCount > 0
    BEGIN
        INSERT INTO @DeletedEids (
            Eid,
            WebId,
            EidParent,
            NavCacheMask,
            DocId,
            Stage)
            SELECT
                NavNodes.Eid,
                NavNodes.WebId,
                NavNodes.EidParent,
                dbo.fn_NavCacheMask(NavNodes.EidParent),
                NavNodes.DocId,
                0
            FROM
                NavNodes
            INNER JOIN
                @DeletedEids Deleted1
            ON
                NavNodes.WebId = Deleted1.WebId AND
                NavNodes.EidParent = Deleted1.Eid
            LEFT OUTER JOIN
                @DeletedEids Deleted2
            ON
                NavNodes.Eid = Deleted2.Eid AND
                NavNodes.WebId = Deleted2.WebId
            WHERE
                NavNodes.SiteId = @SiteId AND
                Deleted2.Eid IS NULL
    END
    DECLARE @WebCount int SELECT @WebCount = COUNT(*) FROM Webs WITH (UPDLOCK) WHERE Webs.Id IN (SELECT WebId FROM @DeletedEids) OR (Webs.NavParentWebId IN (SELECT WebId FROM @DeletedEids))
    DELETE
        NavNodes
    FROM
        NavNodes, @DeletedEids Deleted
    WHERE
        NavNodes.SiteId = @SiteId AND
        NavNodes.WebId = Deleted.WebId AND
        NavNodes.Eid = Deleted.Eid
    DECLARE @Now datetime
    SET @Now = GETUTCDATE()
    INSERT INTO EventCache(
        EventTime, 
        SiteId, 
        WebId,
        ListId,
        ItemId,
        DocId,
        Guid0,
        Int0,
        ItemFullUrl,
        EventType,
        ObjectType,
        TimeLastModified)
    SELECT DISTINCT
        @Now,
        @SiteId,
        WebId,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        134217728,
        4,
        @Now
    FROM
        @DeletedEids
    UPDATE
        NavNodes
    SET
        NumChildren = NumChildren - (
        SELECT
            COUNT(*)
        FROM
            @DeletedParentEids DeletedParents
        WHERE
            DeletedParents.WebId = NavNodes.WebId AND
            DeletedParents.EidParent = NavNodes.Eid)
    FROM
        NavNodes
    INNER JOIN
        @DeletedParentEids DeletedParents
    ON
        NavNodes.WebId = DeletedParents.WebId AND
        NavNodes.Eid = DeletedParents.EidParent
    WHERE
        NavNodes.SiteId = @SiteId
    UPDATE
        NavNodes
    SET
        RankChild = NavNodes.RankChild - (
        SELECT
            COUNT(*)
        FROM
            @DeletedParentEids DeletedParents
        WHERE
            DeletedParents.WebId = NavNodes.WebId AND
            DeletedParents.EidParent = NavNodes.EidParent AND
            DeletedParents.RankChild < NavNodes.RankChild)
    FROM
        NavNodes
    INNER JOIN
        @DeletedParentEids DeletedParents
    ON
        NavNodes.WebId = DeletedParents.WebId AND
        NavNodes.EidParent = DeletedParents.EidParent
    WHERE
        NavNodes.SiteId = @SiteId
    DECLARE @DepList table (DocUrl nvarchar(260) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL, Level tinyint DEFAULT 1 NOT NULL, DirName AS ISNULL(CASE WHEN (CHARINDEX(N'/', REVERSE(DocUrl)) > 0) THEN LEFT(DocUrl, DATALENGTH(DocUrl)/2 - CHARINDEX(N'/', REVERSE(DocUrl) COLLATE Latin1_General_BIN)) ELSE N'' END, N''), LeafName AS ISNULL(CASE WHEN (CHARINDEX(N'/', REVERSE(DocUrl) COLLATE Latin1_General_BIN) > 0) THEN RIGHT(DocUrl, CHARINDEX(N'/', REVERSE(DocUrl) COLLATE Latin1_General_BIN) - 1) ELSE DocUrl END, DocUrl), UNIQUE (DocUrl,Level)) INSERT INTO @DepList (DocUrl,Level) SELECT DISTINCT Deps.FullUrl,Deps.Level FROM Deps INNER JOIN @DeletedEids DeletedEids ON Deps.DepDesc = N'P:C|' + CAST(DeletedEids.EidParent AS nvarchar(32)) WHERE Deps.SiteId = @SiteId AND Deps.DeleteTransactionId = '00000000-0000-0000-0000-000000000000' AND Deps.DepType = 4 UPDATE Webs SET CachedNavDirty = 1 WHERE Webs.Id IN (SELECT WebId FROM @DeletedEids) OR (Webs.NavParentWebId IN (SELECT WebId FROM @DeletedEids)) DECLARE @IterCount int SELECT @IterCount = 0 WHILE @IterCount < 32 BEGIN INSERT INTO @DepList (DocUrl, Level) SELECT DISTINCT Deps.FullUrl,Deps.Level FROM @DepList DepList1 INNER JOIN Deps ON Deps.DepType = 1 AND Deps.DepDesc = DepList1.DocUrl AND DepList1.Level = 1 LEFT OUTER JOIN @DepList DepList2 ON DepList2.DocUrl = Deps.FullUrl WHERE Deps.SiteId = @SiteId AND Deps.DeleteTransactionId = 0x AND DepList2.DocUrl IS NULL IF @@RowCount = 0 BREAK SELECT @IterCount = @IterCount + 1 END IF @IterCount >= 32 BEGIN INSERT INTO @DepList (DocUrl,Level) SELECT DISTINCT FullUrl,Level FROM Deps WHERE DepType = 1 AND SiteId = @SiteId AND DeleteTransactionId = 0x AND FullUrl NOT IN (SELECT DocUrl FROM @DepList) END UPDATE Docs SET Docs.Dirty = 1, Docs.CacheParseId = NULL FROM Docs INNER JOIN @DepList DepList1 ON Docs.SiteId = @SiteId AND Docs.DirName = DepList1.DirName AND Docs.LeafName = DepList1.LeafName AND Docs.Level = DepList1.Level
    DELETE Deps FROM Deps, @DeletedEids DeletedEids WHERE SiteId = @SiteId AND DeleteTransactionId = '00000000-0000-0000-0000-000000000000' AND DepType = 4 AND Deps.DepDesc = N'P:C|' + CAST(DeletedEids.Eid AS nvarchar(32))
    UPDATE
        Docs
    SET
        Docs.Dirty = 1,
        Docs.CacheParseId = NULL
    FROM
        Docs
    INNER JOIN
        @DeletedEids DeletedEids
    ON
        Docs.Id = DeletedEids.DocId
    WHERE
        Docs.HasStream = 1
    UPDATE
        Docs
    SET
        Docs.Dirty = 1,
        Docs.CacheParseId = NULL
    FROM
        Docs
    INNER JOIN
        NavNodes
    ON
        Docs.Id = NavNodes.DocId
    INNER JOIN
        @DeletedParentEids DeletedParents
    ON
        DeletedParents.EidParent = NavNodes.Eid AND
        DeletedParents.WebId = NavNodes.WebId
    WHERE
        NavNodes.SiteId = @SiteId AND
        Docs.HasStream = 1
    UPDATE
        Docs
    SET
        Docs.Dirty = 1,
        Docs.CacheParseId = NULL
    FROM
        Docs
    INNER JOIN
        NavNodes
    ON
        Docs.Id = NavNodes.DocId
    INNER JOIN
        @DeletedParentEids DeletedParents
    ON
        DeletedParents.EidParent = NavNodes.EidParent AND
        DeletedParents.WebId = NavNodes.WebId
    WHERE
        NavNodes.SiteId = @SiteId AND
        Docs.HasStream = 1
    END
    DECLARE @FreedSpace bigint
    SET @FreedSpace = ISNULL((
        SELECT
            SUM(Size)
        FROM
            RecycleBin
        WHERE
            SiteId = @WebSiteId AND
            WebId = @WebId AND
            (BinId = 1)),0)
    IF @FreedSpace > 0
    BEGIN
        SET @FreedSpace = -@FreedSpace
        EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @WebSiteId, @FreedSpace, 1
    END    
    DELETE FROM
        Features
    WHERE
        SiteId = @WebSiteId AND
        WebId = @WebId
    DELETE FROM
        RecycleBin
    WHERE
        SiteId = @WebSiteId AND
        WebId = @WebId
    DELETE FROM
        WorkflowAssociation
    WHERE
        SiteId = @WebSiteId AND
        WebId = @WebId
    DELETE FROM
        Workflow
    WHERE
        SiteId = @WebSiteId AND
        WebId = @WebId
    DELETE FROM
        ScheduledWorkitems
    WHERE
        SiteId = @WebSiteId AND
        (WebId = @WebId OR
            ParentId = @WebId)
    DELETE FROM
        ContentTypes
    WHERE
        ContentTypes.SiteId = @WebSiteId AND
        ContentTypes.Class = 0 AND
        ContentTypes.Scope = @WebUrl
    DELETE FROM
        ContentTypes
    WHERE
        ContentTypes.SiteId = @WebSiteId AND
        ContentTypes.Class = 1 AND
        ContentTypes.Scope = @WebUrl
    DELETE FROM
        ContentTypeUsage
    WHERE
        SiteId = @WebSiteId AND
        WebId = @WebId
cleanup:
    IF (@ReturnStatus = 0)
    BEGIN
        EXEC proc_UpdateDiskUsed @WebSiteId
    END
    IF (@ReturnStatus <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @ReturnStatus

GO
