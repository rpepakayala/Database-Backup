/****** Object:  StoredProcedure [dbo].[proc_DeplGetSystemObjects]    Script Date: 5/15/2018 12:11:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetSystemObjects(
    @SiteId uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @SystemObjects TABLE (
        Id uniqueidentifier not null,
        Type tinyint not null,
        Url nvarchar(260) not null)
    DECLARE @RootWebId uniqueidentifier
    DECLARE @RootWebUrl nvarchar(260)
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    DECLARE @FullUrl nvarchar(260)
    SELECT
        @RootWebId = Id,
        @RootWebUrl = FullUrl
    FROM Webs
    WHERE
        SiteId = @SiteId AND
        ParentWebId IS NULL
    INSERT INTO @SystemObjects
    VALUES(@RootWebId, 1, @RootWebUrl)
    INSERT INTO @SystemObjects(
        Id,
        Type,
        Url)
    SELECT
        Id,
        2,
        CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        WebId = @RootWebId AND
        Type = 2
    INSERT INTO @SystemObjects(
        Id,
        Type,
        Url)
    SELECT
        Id,
        CASE
            WHEN Docs.Type = 1 AND Docs.DocLibRowId IS NOT NULL THEN 6
            WHEN Docs.Type = 1 THEN 2
            WHEN Docs.DocLibRowId IS NOT NULL THEN 7
            ELSE 5
        END,
        CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @RootWebUrl AND
        LeafName IN
        ('_catalogs',
         'Lists',
         '_cts',
         'm',
         'default.aspx')
    DECLARE @UserInfoListId uniqueidentifier
    DECLARE @UserInfoListUrl nvarchar(260)
    SELECT
        @UserInfoListId = UserInfoListId
    FROM
        Sites
    WHERE
        Sites.Id = @SiteId
    SELECT @DirName = Docs.DirName,
           @LeafName = Docs.LeafName,
           @UserInfoListUrl = CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
    FROM
        Docs
    INNER JOIN
        Lists
    ON
        Docs.Id = Lists.tp_RootFolder
    WHERE
        Lists.tp_ID = @UserInfoListId AND
        Lists.tp_WebId = @RootWebId
    INSERT INTO @SystemObjects(
        Id,
        Type,
        Url)
    SELECT
        Id,
        2,
        @UserInfoListUrl
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName
    INSERT INTO @SystemObjects(
        Id,
        Type,
        Url)
     VALUES(
        @UserInfoListId,
        3,
        @UserInfoListUrl
      )
    INSERT INTO @SystemObjects(
        Id,
        Type,
        Url)
    SELECT
        Id,
        CASE
            WHEN Docs.Type = 1 AND Docs.DocLibRowId IS NOT NULL THEN 6
            WHEN Docs.Type = 1 THEN 2
            WHEN Docs.DocLibRowId IS NOT NULL THEN 7
            ELSE 5
        END,
        CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @UserInfoListUrl AND
        LeafName IN (
            'detail.aspx',
            'simple.aspx',
            'AllGroups.aspx',
            'Attachments',
            'DomainGroup',
            'Person',
            'SharePointGroup')
    SET @FullUrl = CASE WHEN (DATALENGTH(@RootWebUrl) = 0) THEN '_catalogs/masterpage' WHEN (DATALENGTH('_catalogs/masterpage') = 0) THEN @RootWebUrl ELSE @RootWebUrl + N'/' + '_catalogs/masterpage' END
    EXEC proc_SplitUrl @FullUrl,
                        @DirName OUTPUT,
                        @LeafName OUTPUT
    IF EXISTS(
        SELECT 1
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName)
    BEGIN
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            2,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Lists.tp_ID,
            3,
            CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
        FROM
            Docs
        INNER JOIN
            Lists
        ON
            Docs.SiteId = @SiteId AND
            Docs.DirName = @DirName AND
            Docs.LeafName = @LeafName AND
            Lists.tp_RootFolder = Docs.Id AND
            Lists.tp_WebId = @RootWebId
        SET @FullUrl = CASE WHEN (DATALENGTH(@RootWebUrl) = 0) THEN '_catalogs/masterpage/Forms' WHEN (DATALENGTH('_catalogs/masterpage/Forms') = 0) THEN @RootWebUrl ELSE @RootWebUrl + N'/' + '_catalogs/masterpage/Forms' END
        EXEC proc_SplitUrl @FullUrl,
                            @DirName OUTPUT,
                            @LeafName OUTPUT
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            2,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            CASE
            WHEN Docs.Type = 1 AND Docs.DocLibRowId IS NOT NULL THEN 6
                WHEN Docs.Type = 1 THEN 2
                WHEN Docs.DocLibRowId IS NOT NULL THEN 7
                ELSE 5
            END,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @FullUrl AND
            LeafName IN (
                'AllItems.aspx',
                'DispForm.aspx',
                'EditForm.aspx',
                'Upload.aspx',
                'MasterPage')
    END
    SET @FullUrl = CASE WHEN (DATALENGTH(@RootWebUrl) = 0) THEN '_catalogs/wt' WHEN (DATALENGTH('_catalogs/wt') = 0) THEN @RootWebUrl ELSE @RootWebUrl + N'/' + '_catalogs/wt' END
    EXEC proc_SplitUrl @FullUrl,
                        @DirName OUTPUT,
                        @LeafName OUTPUT
    IF EXISTS(
        SELECT 1
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName)
    BEGIN
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            2,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Lists.tp_ID,
            3,
            CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
        FROM
            Docs
        INNER JOIN
            Lists
        ON
            Docs.SiteId = @SiteId AND
            Docs.DirName = @DirName AND
            Docs.LeafName = @LeafName AND
            Lists.tp_RootFolder = Docs.Id AND
            Lists.tp_WebId = @RootWebId
    END
    SET @FullUrl = CASE WHEN (DATALENGTH(@RootWebUrl) = 0) THEN '_catalogs/wt/Forms' WHEN (DATALENGTH('_catalogs/wt/Forms') = 0) THEN @RootWebUrl ELSE @RootWebUrl + N'/' + '_catalogs/wt/Forms' END
    EXEC proc_SplitUrl @FullUrl,
                        @DirName OUTPUT,
                        @LeafName OUTPUT
    IF EXISTS(
        SELECT 1
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName)
    BEGIN
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            2,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            CASE
                WHEN Docs.DocLibRowId IS NOT NULL THEN 7
                ELSE 5
            END,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @FullUrl AND
            LeafName IN (
                'allitems.aspx',
                'Common.aspx',
                'DispForm.aspx',
                'EditForm.aspx',
                'Upload.aspx')
    END
    SET @FullUrl = CASE WHEN (DATALENGTH(@RootWebUrl) = 0) THEN '_catalogs/lt' WHEN (DATALENGTH('_catalogs/lt') = 0) THEN @RootWebUrl ELSE @RootWebUrl + N'/' + '_catalogs/lt' END
    EXEC proc_SplitUrl @FullUrl,
                        @DirName OUTPUT,
                        @LeafName OUTPUT
    IF EXISTS(
        SELECT 1
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName)
    BEGIN
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            2,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Lists.tp_ID,
            3,
            CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
        FROM
            Docs
        INNER JOIN
            Lists
        ON
            Docs.SiteId = @SiteId AND
            Docs.DirName = @DirName AND
            Docs.LeafName = @LeafName AND
            Lists.tp_RootFolder = Docs.Id AND
            Lists.tp_WebId = @RootWebId
    END
    SET @FullUrl = CASE WHEN (DATALENGTH(@RootWebUrl) = 0) THEN '_catalogs/lt/Forms' WHEN (DATALENGTH('_catalogs/lt/Forms') = 0) THEN @RootWebUrl ELSE @RootWebUrl + N'/' + '_catalogs/lt/Forms' END
    EXEC proc_SplitUrl @FullUrl,
                        @DirName OUTPUT,
                        @LeafName OUTPUT
    IF EXISTS(
        SELECT 1
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName)
    BEGIN
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            2,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            CASE
                WHEN Docs.DocLibRowId IS NOT NULL THEN 7
                ELSE 5
            END,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @FullUrl AND
            LeafName IN (
                'AllItems.aspx',
                'DispForm.aspx',
                'EditForm.aspx',
                'Upload.aspx')
    END
    SET @FullUrl = CASE WHEN (DATALENGTH(@RootWebUrl) = 0) THEN '_catalogs/wp' WHEN (DATALENGTH('_catalogs/wp') = 0) THEN @RootWebUrl ELSE @RootWebUrl + N'/' + '_catalogs/wp' END
    EXEC proc_SplitUrl @FullUrl,
                        @DirName OUTPUT,
                        @LeafName OUTPUT
    IF EXISTS(
        SELECT 1
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName)
    BEGIN
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            2,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Lists.tp_ID,
            3,
            CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
        FROM
            Docs
        INNER JOIN
            Lists
        ON
            Docs.SiteId = @SiteId AND
            Docs.DirName = @DirName AND
            Docs.LeafName = @LeafName AND
            Lists.tp_RootFolder = Docs.Id AND
            Lists.tp_WebId = @RootWebId
    END
    SET @FullUrl = CASE WHEN (DATALENGTH(@RootWebUrl) = 0) THEN '_catalogs/wp/Forms' WHEN (DATALENGTH('_catalogs/wp/Forms') = 0) THEN @RootWebUrl ELSE @RootWebUrl + N'/' + '_catalogs/wp/Forms' END
    EXEC proc_SplitUrl @FullUrl,
                        @DirName OUTPUT,
                        @LeafName OUTPUT
    IF EXISTS(
        SELECT 1
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName)
    BEGIN
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            2,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            CASE
                WHEN Docs.DocLibRowId IS NOT NULL THEN 7
                ELSE 5
            END,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @FullUrl AND
            LeafName IN (
                'AllItems.aspx',
                'DispForm.aspx',
                'EditForm.aspx',
                'Upload.aspx')
    END
    SET @FullUrl = CASE WHEN (DATALENGTH(@RootWebUrl) = 0) THEN '_catalogs/wp' WHEN (DATALENGTH('_catalogs/wp') = 0) THEN @RootWebUrl ELSE @RootWebUrl + N'/' + '_catalogs/wp' END
    EXEC proc_SplitUrl @FullUrl,
                        @DirName OUTPUT,
                        @LeafName OUTPUT
    IF EXISTS(
        SELECT 1
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName)
    BEGIN
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            CASE
                WHEN Docs.DocLibRowId IS NOT NULL THEN 7
                ELSE 5
            END,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @FullUrl AND
            LeafName IN(
                'MSContentEditor.dwp',
                'MSImage.dwp',
                'MSMembers.dwp',
                'MSPageViewer.dwp',
                'MSUserDocs.dwp',
                'MSUserTasks.dwp',
                'MSSimpleForm.dwp',
                'MSXml.dwp') AND
            Level = 1
    END
    SET @FullUrl = CASE WHEN (DATALENGTH(@RootWebUrl) = 0) THEN '_cts' WHEN (DATALENGTH('_cts') = 0) THEN @RootWebUrl ELSE @RootWebUrl + N'/' + '_cts' END
    EXEC proc_SplitUrl @FullUrl,
                        @DirName OUTPUT,
                        @LeafName OUTPUT
    IF EXISTS(
        SELECT 1
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName)
    BEGIN
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            2,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @FullUrl
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            2,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            Type = 1 AND
            LeafName IN
                ('_private',
                'images') AND
            (EXISTS (
                SELECT 1 FROM #ExportObjects e
                WHERE Id = e.Id) OR
            EXISTS (
                SELECT 1 FROM #ExportObjects e
                WHERE ParentId = e.Id) )
    END
    SET @FullUrl = CASE WHEN (DATALENGTH(@RootWebUrl) = 0) THEN '_catalogs/masterpage' WHEN (DATALENGTH('_catalogs/masterpage') = 0) THEN @RootWebUrl ELSE @RootWebUrl + N'/' + '_catalogs/masterpage' END
    EXEC proc_SplitUrl @FullUrl,
                        @DirName OUTPUT,
                        @LeafName OUTPUT
    IF EXISTS(
        SELECT 1
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName)
    BEGIN
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            CASE
                WHEN Docs.DocLibRowId IS NOT NULL THEN 7
                ELSE 5
            END,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @FullUrl AND
            LeafName = 'default.master' AND
            Level = 1
    END
    SET @FullUrl = CASE WHEN (DATALENGTH(@RootWebUrl) = 0) THEN 'm' WHEN (DATALENGTH('m') = 0) THEN @RootWebUrl ELSE @RootWebUrl + N'/' + 'm' END
    EXEC proc_SplitUrl @FullUrl,
                        @DirName OUTPUT,
                        @LeafName OUTPUT
    IF EXISTS(
        SELECT 1
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName)
    BEGIN
        INSERT INTO @SystemObjects(
            Id,
            Type,
            Url)
        SELECT
            Id,
            CASE
            WHEN Docs.Type = 1 AND Docs.DocLibRowId IS NOT NULL THEN 6
                WHEN Docs.Type = 1 THEN 2
                WHEN Docs.DocLibRowId IS NOT NULL THEN 7
                ELSE 5
            END,
            CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @FullUrl AND
            Level = 1
    END
    SELECT DISTINCT
        Id,
        Type,
        '/' + Url
    FROM @SystemObjects
    WHERE
        Id IN (
            SELECT Id FROM #ExportObjects) OR
        Id IN (
            SELECT ParentId FROM #ExportObjects) OR
        Id IN (
            SELECT ParentWebId FROM #ExportObjects) OR
        Id = @UserInfoListId

GO
