/****** Object:  StoredProcedure [dbo].[proc_SetWebMetainfo]    Script Date: 5/15/2018 12:12:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SetWebMetainfo(
    @WebSiteId uniqueidentifier,
    @WebUrl nvarchar(260),
    @MetaInfo image,
    @Flags int,
    @DefTheme nvarchar(64),
    @IncrementSiteTimeStamp bit,
    @MasterUrl nvarchar(260),
    @CustomMasterUrl nvarchar(260),    
    @@WebId uniqueidentifier OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    EXEC proc_SplitUrl @Weburl, @DirName OUTPUT, @LeafName OUTPUT
    SELECT
        @@WebId = WebId
    FROM
        Docs
    WHERE
        SiteId = @WebSiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        Type = 2 
    IF @@WebId IS NULL
    BEGIN
        RETURN 3
    END
    DECLARE @quotaOrLockStatus int
    SELECT  @quotaOrLockStatus = dbo.fn_IsOverQuotaOrWriteLocked(@WebSiteId)
    IF (@quotaOrLockStatus > 1)
    BEGIN
        RETURN 212
    END
    IF (@quotaOrLockStatus = 1 AND @IncrementSiteTimeStamp <> 0)
    BEGIN
        RETURN 212
    END
    DECLARE @PreviousMasterUrl nvarchar(260)
    DECLARE @PreviousCustomMasterUrl nvarchar(260)
    IF @MasterUrl IS NOT NULL OR
       @CustomMasterUrl IS NOT NULL
    BEGIN
        SELECT
            @PreviousMasterUrl = MasterUrl,
            @PreviousCustomMasterUrl = CustomMasterUrl
        FROM
            Webs
        WHERE
            Id = @@WebId
    END
    DECLARE @Now datetime
    SET @Now = GETUTCDATE()
    UPDATE
        Webs
    SET
        DefTheme = @DefTheme,
        MetaInfo = @MetaInfo,
        Flags = CASE WHEN @Flags IS NULL THEN Flags ELSE @Flags END,
        MasterUrl = CASE WHEN @MasterUrl IS NULL 
            THEN MasterUrl ELSE @MasterUrl END,
        CustomMasterUrl = CASE WHEN @CustomMasterUrl IS NULL 
            THEN CustomMasterUrl ELSE @CustomMasterUrl END,
        LastMetadataChange = @Now
    WHERE
        Id = @@WebId
    IF @@ROWCOUNT = 1 
    BEGIN
        IF @IncrementSiteTimeStamp = 1
        BEGIN
            EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @WebSiteId, 0, 1
            EXEC proc_LogChange @WebSiteId, @@WebId, NULL, NULL, NULL, NULL, NULL,
                NULL, 8192,  4, @Now
        END
        IF @MasterUrl IS NOT NULL OR @CustomMasterUrl IS NOT NULL
        BEGIN
            DECLARE @MasterUrlInDb nvarchar(260)
            DECLARE @CustomMasterUrlInDb nvarchar(260)
            SELECT @MasterUrlInDb = ISNULL(@MasterUrl, @PreviousMasterUrl)
            SELECT @CustomMasterUrlInDb = ISNULL(@CustomMasterUrl, @PreviousCustomMasterUrl)
            EXEC proc_RecordWebLinks @WebSiteId, @DirName, @LeafName,
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
                    BuildDependencies.SiteId = @WebSiteId AND
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
                    BuildDependencies.SiteId = @WebSiteId AND
                    BuildDependencies.TargetDirName = @PreviousCustomMasterDir AND
                    BuildDependencies.TargetLeafName = @PreviousCustomMasterLeaf AND
                    Docs.BuildDependencySet IS NOT NULL
            END        
        END
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN 3
    END

GO
