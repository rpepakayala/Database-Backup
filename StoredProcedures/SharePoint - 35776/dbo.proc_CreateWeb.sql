/****** Object:  StoredProcedure [dbo].[proc_CreateWeb]    Script Date: 5/15/2018 12:11:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CreateWeb(
    @WebSiteId                  uniqueidentifier,
    @WebId                      uniqueidentifier,
    @WebDirName                 nvarchar(256),
    @WebLeafName                nvarchar(128),
    @WebFullUrl                 nvarchar(260),
    @ProductVersion             smallint,
    @TemplateVersion            smallint,
    @Language                   int,
    @Collation                  smallint,
    @CalendarType               smallint,
    @AuthorID                   int,
    @Time24                     bit,
    @ConvertIfThere             bit,
    @UniqueWeb                  bit,
    @NewWebId                   uniqueidentifier = NULL,
    @DocId                      uniqueidentifier = NULL)
AS
    SET NOCOUNT ON
    DECLARE @FirstUniqueAncestorWebId uniqueidentifier
    DECLARE @GrandParentWebId uniqueidentifier
    DECLARE @Now datetime
    DECLARE @ParentTimeZone smallint
    DECLARE @ParentLocale int
    DECLARE @ParentCollation smallint
    DECLARE @ParentLanguage int
    DECLARE @ParentAdjHijri smallint
    DECLARE @ParentCalendarType smallint
    DECLARE @ParentTime24 bit
    DECLARE @ParentAltCalendarType tinyint
    DECLARE @ParentCalendarViewOptions tinyint
    DECLARE @ParentWorkDays smallint
    DECLARE @ParentWorkDayStartHour smallint
    DECLARE @ParentWorkDayEndHour smallint
    DECLARE @ParentProvisionConfig smallint
    DECLARE @WebLanguage int
    DECLARE @WebLocale int
    DECLARE @WebCollation smallint
    DECLARE @WebCalendarType smallint
    DECLARE @WebTime24 bit
    DECLARE @ExistingUrlType int
    DECLARE @ParentDirName nvarchar(256)
    DECLARE @ParentLeafName nvarchar(128)
    DECLARE @ParentFullUrl nvarchar(260)
    DECLARE @RelativeUrlOfParent nvarchar(260)
    DECLARE @ListId   uniqueidentifier
    DECLARE @WebParentDocId uniqueidentifier
    DECLARE @ScopeId  uniqueidentifier
    DECLARE @iRet int
    DECLARE @bAddDocsOverheadToQuota bit
    SET @iRet = 0
    SET @bAddDocsOverheadToQuota = 0
    DECLARE @quotaOrLockStatus int
    SELECT @quotaOrLockStatus = dbo.fn_IsOverQuotaOrWriteLocked(@WebSiteId)
    IF (@quotaOrLockStatus = 1)
    BEGIN
        RETURN 1816
    END
    ELSE IF (@quotaOrLockStatus > 1)
    BEGIN
        RETURN 212
    END
    BEGIN TRAN
    EXEC @iRet = proc_CanonicalDirNameFromUserInput
        @WebSiteId,
        @WebId,
        @WebDirName OUTPUT,
        @WebParentDocId OUTPUT,
        @ScopeId OUTPUT
    IF 0 <> @iRet
    BEGIN
        GOTO cleanup;
    END
    EXEC proc_SplitUrl @WebDirName,
        @ParentDirName OUTPUT, @ParentLeafName OUTPUT
    SELECT
        @ListId = Docs.ListId,
        @ScopeId = Webs.ScopeId,
        @WebParentDocId = Docs.Id
    FROM
        Docs WITH (UPDLOCK)
    JOIN Webs ON Webs.Id = Docs.WebId
    WHERE
        Docs.SiteId = @WebSiteId AND
        Docs.DirName = @ParentDirName AND
        Docs.LeafName = @ParentLeafName
    SET @WebFullUrl = CASE WHEN (DATALENGTH(@WebDirName) = 0) THEN @WebLeafName WHEN (DATALENGTH(@WebLeafName) = 0) THEN @WebDirName ELSE @WebDirName + N'/' + @WebLeafName END
    DECLARE @UrlLike nvarchar(1024)
    EXEC proc_EscapeForLike @WebFullUrl, @UrlLike OUTPUT
    SELECT
        @FirstUniqueAncestorWebId = FirstUniqueAncestorWebId,
        @GrandParentWebId = ParentWebId,
        @ParentFullUrl = FullUrl,
        @ParentTimeZone = TimeZone, 
        @ParentLocale = Locale,
        @ParentLanguage = Language,
        @ParentCollation = Collation,
        @ParentAdjHijri = AdjustHijriDays,        
        @ParentCalendarType = CalendarType,
        @ParentTime24 = Time24,
        @ParentAltCalendarType = AltCalendarType,
        @ParentCalendarViewOptions = CalendarViewOptions,
        @ParentWorkDays = WorkDays,
        @ParentWorkDayStartHour = WorkDayStartHour,
        @ParentWorkDayEndHour = WorkDayEndHour,
        @ParentProvisionConfig = ProvisionConfig
    FROM
        Webs WITH (UPDLOCK)
    WHERE
        Id = @WebId
    IF @Language = @ParentLanguage AND 
        @ParentProvisionConfig != -1
    BEGIN
        SET @WebLocale = @ParentLocale
        SET @WebLanguage = @ParentLanguage 
        SET @WebCollation = @ParentCollation
        SET @WebCalendarType = @ParentCalendarType
        SET @WebTime24 = @ParentTime24
    END
    ELSE
    BEGIN
        SET @WebLocale = @Language  
        SET @WebLanguage = @Language 
        SET @WebCollation = @Collation
        SET @WebCalendarType = @CalendarType
        SET @WebTime24 = @Time24
    END
    SELECT 
        @WebDirName = DirName,
        @WebLeafName = LeafName,
        @ExistingUrlType = Type,
        @ListId = ListId
    FROM
        Docs WITH (UPDLOCK)
    WHERE
        SiteId = @WebSiteId AND
        DirName = @WebDirName AND
        LeafName = @WebLeafName
    IF @ExistingUrlType = 2 OR
        @ExistingUrlType = 0
    BEGIN
        SET @iRet = 80
        GOTO CLEANUP
    END
    IF @ListId IS NOT NULL
    BEGIN
        SET @iRet = 80
        GOTO CLEANUP
    END
    IF EXISTS(
    SELECT
        *
    FROM
        Webs WITH (NOLOCK)
    WHERE
        SiteId = @WebSiteId AND
        FullUrl = @WebFullUrl)
    BEGIN
        SET @iRet = 80
        GOTO CLEANUP
    END
    IF @NewWebId IS NULL
        SET @NewWebId = NEWID()
    IF @UniqueWeb = 1
    BEGIN
        DECLARE @RoleDefWebId uniqueidentifier
        SELECT 
            @RoleDefWebId = RoleDefWebId
        FROM
            Perms
        WHERE
            SiteId = @WebSiteId AND
            ScopeId = @ScopeId
        SET @ScopeId = NEWID();            
        EXEC proc_SecAddPermScopeForWeb @WebSiteId, @ScopeId, @RoleDefWebId, @NewWebId, 
            0, @WebFullUrl
    END    
    IF @ListId IS NOT NULL
    BEGIN
        SET @iRet = 3
        GOTO CLEANUP
    END
    IF (@GrandParentWebId IS NOT NULL)
    BEGIN
        SELECT
            @RelativeUrlOfParent = CASE WHEN (DATALENGTH(FullUrl) = 0) THEN @ParentFullUrl ELSE SUBSTRING(@ParentFullUrl, LEN(FullUrl) + 2, 260) END
        FROM
            Webs
        WHERE
            Webs.Id = @GrandParentWebId
    END
    ELSE
    BEGIN
        SET @RelativeUrlOfParent = @ParentFullUrl
    END
    DECLARE @userEmail nvarchar(255)
    SELECT 
        @userEmail = tp_Email 
    FROM 
        UserInfo 
    WHERE 
        tp_ID = @AuthorID AND 
        tp_SiteID = @WebSiteId
    SET @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    INSERT INTO Webs (
        Id,
        SiteId,
        FullUrl,
        ParentWebId,
        ProductVersion,
        TemplateVersion,
        FirstUniqueAncestorWebId,
        ScopeId,
        Author,
        TimeCreated,
        MetaInfoVersion,
        DailyUsageDataVersion,
        MonthlyUsageDataVersion,
        DayLastAccessed,
        WebTemplate,
        Language,
        Locale,
        Collation,
        TimeZone,
        CalendarType,
        Time24,
        AdjustHijriDays,
        AltCalendarType,
        CalendarViewOptions,
        WorkDays,
        WorkDayStartHour,
        WorkDayEndHour,
        MeetingCount,
        NavStructNextEid,
        NavParentWebId,
        NextWebGroupId,
        ProvisionConfig,
        Flags,
        RequestAccessEmail,
        Ancestry)
    SELECT
        @NewWebId,
        @WebSiteId,
        @WebFullUrl,
        @WebId,
        @ProductVersion,
        @TemplateVersion,
        CASE WHEN @UniqueWeb = 1 THEN
            @NewWebId
        ELSE
            @FirstUniqueAncestorWebId
        END,
        @ScopeId,
        @AuthorID,
        @Now,
        0,
        0,
        0,
        0,
        0x1,  
        @WebLanguage,
        @WebLocale,
        @WebCollation,
        @ParentTimeZone,
        @WebCalendarType,
        @WebTime24,
        @ParentAdjHijri,        
        @ParentAltCalendarType,
        @ParentCalendarViewOptions,
        @ParentWorkDays,
        @ParentWorkDayStartHour,
        @ParentWorkDayEndHour,
        0,
        2001, 
        NULL, 
        1073741824 + 100,  
        -1,  
        (0 | 0x01 | 0x02 | 0x20 | 0x100),
        @userEmail,
        CASE WHEN Webs.Ancestry IS NULL THEN
            CONVERT(varbinary(16), Webs.Id) + CONVERT(varbinary(4), N';#') + CONVERT(varbinary(2), CASE WHEN Webs.NavParentWebId IS NULL THEN N'U' ELSE N'I' END) + CONVERT(varbinary(4), N';#') + CONVERT(varbinary(510), REPLACE(Webs.Title, N';', N';;')) + CONVERT(varbinary(4), N';#') + CONVERT(varbinary(520), CASE WHEN (DATALENGTH(@RelativeUrlOfParent) = 0) THEN N'/' ELSE REPLACE(@RelativeUrlOfParent, N';', N';;') END)
        ELSE
            SUBSTRING(Webs.Ancestry, 1, DATALENGTH(Webs.Ancestry)) +
            CONVERT(varbinary(8), N';#;#') +
            CONVERT(varbinary(16), Webs.Id) + CONVERT(varbinary(4), N';#') + CONVERT(varbinary(2), CASE WHEN Webs.NavParentWebId IS NULL THEN N'U' ELSE N'I' END) + CONVERT(varbinary(4), N';#') + CONVERT(varbinary(510), REPLACE(Webs.Title, N';', N';;')) + CONVERT(varbinary(4), N';#') + CONVERT(varbinary(520), CASE WHEN (DATALENGTH(@RelativeUrlOfParent) = 0) THEN N'/' ELSE REPLACE(@RelativeUrlOfParent, N';', N';;') END)
        END
    FROM
        Webs
    WHERE
        Webs.Id = @WebId
    IF @@ROWCOUNT <> 1 OR @@ERROR <> 0
    BEGIN
        SET @iRet = 80
        GOTO CLEANUP
    END            
    EXEC proc_LogChange @WebSiteId, @NewWebId, NULL, NULL, NULL, NULL, NULL,
        NULL, 4096,  4, @Now
    IF @UniqueWeb = 1
    BEGIN
        DECLARE @AdminRoleId int
        SET @AdminRoleId = 1073741824 + 5
        EXEC proc_SecAddPrincipalToRole @WebSiteId, @NewWebId, @ScopeId, 
            @AdminRoleId, @AuthorID
    END    
    IF @ExistingUrlType IS NOT NULL
    BEGIN
        IF (@ConvertIfThere = 0)
        BEGIN
            SET @iRet = 85
            GOTO CLEANUP
        END
        UPDATE
            Webs
        SET
            ParentWebId = @NewWebId
        WHERE
            SiteId = @WebSiteId AND
            FullUrl LIKE @UrlLike AND
            ParentWebId = @WebId
        IF @@ERROR <> 0
        BEGIN
            SET @iRet = 80
            GOTO CLEANUP
        END
        DECLARE @WantFlags int
        SET @WantFlags = 0
        SET @WantFlags = @WantFlags | 0x0020
        EXEC @iRet = proc_CheckDirectoryTree
            @WebSiteId, @WebFullUrl, @WebFullUrl, NULL, @WantFlags,
            NULL, NULL
        IF @iRet <> 0
        BEGIN
            GOTO CLEANUP
        END
        UPDATE
            Docs
        SET
            WebId = @NewWebId,
            Type = 2
        WHERE
            SiteId = @WebSiteId AND
            DirName = @WebDirName AND
            LeafName = @WebLeafName
        UPDATE
            Docs
        SET
            WebId = @NewWebId
        WHERE
            SiteId = @WebSiteId AND
            (DirName = @WebFullUrl OR 
                DirName LIKE @UrlLike) AND
            WebId = @WebId
    END
    ELSE
    BEGIN
        SET @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
        IF @DocId IS NULL
            SET @DocId = NEWID()
        INSERT INTO AllDocs (
            Id,
            ParentId,
            SiteId,
            DirName,
            LeafName,
            WebId,
            Type,
            TimeCreated,
            TimeLastModified,
            ScopeId)
        VALUES (
            @DocId,
            @WebParentDocId,
            @WebSiteId,
            @WebDirName,
            @WebLeafName,
            @NewWebId,
            2,
            @Now,
            @Now,
            @ScopeId)
        SET @bAddDocsOverheadToQuota = 1 
    END
    EXEC proc_CreateWebNavStruct @WebSiteId, @NewWebId
    EXEC proc_ProvisionWeb @WebSiteId, @NewWebId, @WebFullUrl
    IF (@bAddDocsOverheadToQuota = 1)
    BEGIN
        EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp
            @WebSiteId, 152, 1
    END
CLEANUP:
    IF (@iRet <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @iRet

GO
