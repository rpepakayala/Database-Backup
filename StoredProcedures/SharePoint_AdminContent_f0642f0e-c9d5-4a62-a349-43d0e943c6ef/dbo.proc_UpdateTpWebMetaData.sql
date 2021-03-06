/****** Object:  StoredProcedure [dbo].[proc_UpdateTpWebMetaData]    Script Date: 5/15/2018 12:13:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateTpWebMetaData(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @Title nvarchar(255),
    @Description ntext,
    @Version int,
    @WebTemplate int,
    @Language int,
    @Locale int,
    @Collation smallint,
    @TimeZone smallint,
    @Time24 bit,
    @CalendarType smallint,
    @AdjustHijriDays smallint,    
    @AltCalendarType tinyint,
    @CalendarViewOptions tinyint,
    @WorkDays smallint,
    @WorkDayStartHour smallint,
    @WorkDayEndHour smallint,
    @Config smallint,
    @Flags int,
    @Author int,
    @AlternateCSSUrl nvarchar(260),
    @CustomizedCss nvarchar(260),
    @CustomJSUrl nvarchar(260),
    @AlternateHeaderUrl nvarchar(260),
    @ExternalSecurityProvider uniqueidentifier,
    @MasterUrl nvarchar(260),
    @CustomMasterUrl nvarchar(260),
    @SiteLogoUrl nvarchar(260),
    @SiteLogoDescription nvarchar(255),
    @TemplateVersion smallint,
    @TimeCreated datetime = NULL,
    @TimeLastModified datetime = NULL)
AS
    SET NOCOUNT ON
    DECLARE @PreviousTitle nvarchar(255)
    DECLARE @PreviousMasterUrl nvarchar(260)
    DECLARE @PreviousCustomMasterUrl nvarchar(260)
    DECLARE @WebUrl nvarchar(260)
    DECLARE @WebDir nvarchar(256)
    DECLARE @WebLeaf nvarchar(128)
    DECLARE @AncestrySize int
    IF @Title IS NOT NULL OR 
        @MasterUrl IS NOT NULL OR 
        @CustomMasterUrl IS NOT NULL
    BEGIN
        SELECT
            @PreviousTitle = Title,
            @PreviousMasterUrl = MasterUrl,
            @PreviousCustomMasterUrl = CustomMasterUrl,
            @WebUrl = FullUrl,
            @AncestrySize = ISNULL(DATALENGTH(Ancestry), 0)
        FROM
            Webs
        WHERE
            Id = @WebId
    END
    DECLARE @Now datetime
    SET @Now = GETUTCDATE()
    UPDATE
        Webs
    SET
        Title = CASE WHEN @Title IS NULL THEN Title ELSE @Title END,
        Description = CASE WHEN @Description IS NULL THEN Description ELSE
            @Description END,
        MetaInfoVersion = @Version + 1,
        WebTemplate = CASE WHEN @WebTemplate = -1 THEN WebTemplate ELSE
            @WebTemplate END,
        TemplateVersion = CASE WHEN @TemplateVersion = -1 THEN TemplateVersion ELSE
            @TemplateVersion END,
        Language = CASE WHEN @Language = 0 THEN Language ELSE
            @Language END,
        Locale = CASE WHEN @Locale = 0 THEN Locale ELSE
            @Locale END,
        Collation = CASE WHEN @Collation = -1 THEN Collation ELSE
            @Collation END,
        TimeZone = CASE WHEN @TimeZone = -1 THEN TimeZone ELSE
            @TimeZone END,
        Time24 = @Time24,
        CalendarType = CASE WHEN @CalendarType = -1 THEN CalendarType ELSE
            @CalendarType END,
        AdjustHijriDays = @AdjustHijriDays,            
        AltCalendarType = CASE WHEN @AltCalendarType = -1 THEN AltCalendarType ELSE
            @AltCalendarType END,
        CalendarViewOptions = @CalendarViewOptions,
        WorkDays = @WorkDays,        
        WorkDayStartHour = @WorkDayStartHour,  
        WorkDayEndHour = @WorkDayEndHour,  
        ProvisionConfig = CASE WHEN @Config = -1 THEN ProvisionConfig ELSE
            @Config END,
        Flags = CASE When @Flags IS NULL THEN Flags ELSE
            @Flags END, 
        Author = CASE WHEN @Author IS NULL THEN Author ELSE
            @Author END,
        AlternateCSSUrl = @AlternateCSSUrl,
        CustomizedCss = @CustomizedCss,
        CustomJSUrl = @CustomJSUrl,
        AlternateHeaderUrl = @AlternateHeaderUrl,
        SecurityProvider = @ExternalSecurityProvider,
        MasterUrl = CASE WHEN @MasterUrl IS NULL THEN MasterUrl ELSE
            @MasterUrl END,
        CustomMasterUrl = CASE WHEN @CustomMasterUrl IS NULL THEN CustomMasterUrl ELSE
            @CustomMasterUrl END,
        SiteLogoUrl = @SiteLogoUrl,
        SiteLogoDescription = @SiteLogoDescription,
        TimeCreated = ISNULL(@TimeCreated, TimeCreated),
        LastMetadataChange = ISNULL(@TimeLastModified, @Now)
    WHERE
        Id = @WebId AND
        MetaInfoVersion = @Version
    IF @@ROWCOUNT <> 1
    BEGIN
        IF EXISTS (SELECT * FROM Webs WHERE Id = @WebId)
        BEGIN
            RETURN 1150
        END
        ELSE
        BEGIN
            RETURN 3
        END
    END
    IF (@Title IS NOT NULL AND @Title <> @PreviousTitle)
    BEGIN
        DECLARE @IsEmptyUrl bit
        DECLARE @TitleStart int
        DECLARE @WebUrlLike nvarchar(1024)
        IF (DATALENGTH(@WebUrl) = 0)
        BEGIN
            SET @IsEmptyUrl = 1
        END
        ELSE
        BEGIN
            SET @IsEmptyUrl = 0
            EXEC proc_EscapeForLike @WebUrl, @WebUrlLike OUTPUT
        END
        SET @TitleStart = 1 + @AncestrySize
                            + CASE WHEN @AncestrySize = 0
                                   THEN 0
                                   ELSE DATALENGTH(CONVERT(varbinary(8), N';#;#'))
                                   END
                            + DATALENGTH(CONVERT(varbinary(16), @WebId))
                            + DATALENGTH(CONVERT(varbinary(4), N';#'))
                            + DATALENGTH(N'U')
                            + DATALENGTH(CONVERT(varbinary(4), N';#'))
        UPDATE
            Webs
        SET
            Ancestry = STUFF(SUBSTRING(Webs.Ancestry, 1, DATALENGTH(Webs.Ancestry)), @TitleStart,
                             DATALENGTH(REPLACE(@PreviousTitle, N';', N';;')),
                             CONVERT(varbinary(520),
                                     REPLACE(@Title, N';', N';;')))
        WHERE
            SiteId = @SiteId AND
            Id <> @WebId AND
            (@IsEmptyUrl = 1 OR
             FullUrl LIKE @WebUrlLike)
    END
    IF @MasterUrl IS NOT NULL OR @CustomMasterUrl IS NOT NULL
    BEGIN
        DECLARE @MasterUrlInDb nvarchar(260)
        DECLARE @CustomMasterUrlInDb nvarchar(260)
        SELECT @MasterUrlInDb = ISNULL(@MasterUrl, @PreviousMasterUrl)
        SELECT @CustomMasterUrlInDb = ISNULL(@CustomMasterUrl, @PreviousCustomMasterUrl)
        EXEC proc_SplitUrl @WebUrl, @WebDir OUTPUT, @WebLeaf OUTPUT
        EXEC proc_RecordWebLinks @SiteId, @WebDir, @WebLeaf, 
            @MasterUrlInDb, @CustomMasterUrlInDb
        IF @MasterUrl IS NOT NULL AND @MasterUrl <> @PreviousMasterUrl
        BEGIN
            DECLARE @PreviousMasterDir nvarchar(256)
            DECLARE @PreviousMasterLeaf nvarchar(128)
            EXEC proc_SplitUrl @PreviousMasterUrl, @PreviousMasterDir OUTPUT, @PreviousMasterLeaf OUTPUT
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
                BuildDependencies.TargetDirName = @PreviousMasterDir AND
                BuildDependencies.TargetLeafName = @PreviousMasterLeaf AND
                Docs.BuildDependencySet IS NOT NULL
        END
        IF @CustomMasterUrl IS NOT NULL AND
           @CustomMasterUrl <> @PreviousCustomMasterUrl
        BEGIN
            DECLARE @PreviousCustomMasterDir nvarchar(256)
            DECLARE @PreviousCustomMasterLeaf nvarchar(128)
            EXEC proc_SplitUrl @PreviousCustomMasterUrl, @PreviousCustomMasterDir OUTPUT, @PreviousCustomMasterLeaf OUTPUT
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
                BuildDependencies.TargetDirName = @PreviousCustomMasterDir AND
                BuildDependencies.TargetLeafName = @PreviousCustomMasterLeaf AND
                Docs.BuildDependencySet IS NOT NULL
        END        
    END
    EXEC proc_LogChange @SiteId, @WebId, NULL, NULL, NULL, NULL, NULL, NULL,
        8192, 4, @Now
    IF
        @Title IS NOT NULL OR
        @Language <> 0 OR
        @TimeZone <> -1
    BEGIN        
        UPDATE
            ImmedSubscriptions
        SET
            WebTitle = ISNULL(@Title, WebTitle),
            WebLanguage = CASE WHEN @Language = 0 THEN WebLanguage 
                ELSE @Language END,
            WebLocale = CASE WHEN @Locale = 0 THEN WebLocale
                ELSE @Locale END,
            WebTimeZone = CASE WHEN @TimeZone = -1 THEN WebTimeZone 
                ELSE @TimeZone END,
            WebTime24 = @Time24,
            WebCalendarType = CASE WHEN @CalendarType = -1 THEN WebCalendarType 
                ELSE @CalendarType END,
            WebAdjustHijriDays = @AdjustHijriDays
        WHERE
            SiteId = @SiteId AND
            WebId = @WebId 
        UPDATE
            SchedSubscriptions
        SET
            WebTitle = ISNULL(@Title, WebTitle),
            WebLanguage = CASE WHEN @Language = 0 THEN WebLanguage 
                ELSE @Language END,
            WebLocale = CASE WHEN @Locale = 0 THEN WebLocale
                ELSE @Locale END,
            WebTimeZone = CASE WHEN @TimeZone = -1 THEN WebTimeZone 
                ELSE @TimeZone END,
            WebTime24 = @Time24,
            WebCalendarType = CASE WHEN @CalendarType = -1 THEN WebCalendarType 
                ELSE @CalendarType END,
            WebAdjustHijriDays = @AdjustHijriDays
        WHERE
            SiteId = @SiteId AND
            WebId = @WebId 
    END
    EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, 0, 1
    RETURN 0             

GO
