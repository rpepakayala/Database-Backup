/****** Object:  StoredProcedure [dbo].[proc_ListChildWebsFiltered]    Script Date: 5/15/2018 12:12:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ListChildWebsFiltered(
    @SiteId                 uniqueidentifier,
    @ParentWebId            uniqueidentifier,
    @UserId                 int,
    @Collation              nvarchar(32) = '',
    @WebTemplate            int = NULL,
    @ProvisionConfig        smallint = NULL,
    @ToLinkRecurringMeeting bit = NULL)
AS
BEGIN
    SET NOCOUNT ON
    IF (@Collation = N'Latin1_General_CI_AS')
    BEGIN 
        SELECT
            Webs.FullUrl,
            Webs.Id,            
            ISNULL(Webs.Title, ''),
            ISNULL(Webs.Description, ''),
            Webs.Language,
            Webs.WebTemplate,
            Webs.ProvisionConfig,
            Webs.MeetingCount,
            CASE WHEN Webs.FirstUniqueAncestorWebId = Webs.Id   
                 THEN Perms.Acl
                 ELSE NULL
            END,
            Perms.AnonymousPermMask,
            Webs.FirstUniqueAncestorWebId,
            Webs.SecurityProvider,
            Webs.TimeCreated,
            (SELECT MAX(tp_Modified) FROM Lists WITH (NOLOCK) WHERE Lists.tp_WebId = Webs.Id)
        FROM
            Webs WITH (NOLOCK)
        INNER JOIN
            Perms WITH (NOLOCK)
        ON
            Perms.SiteId = Webs.SiteId AND
            Perms.ScopeId = Webs.ScopeId
        LEFT OUTER JOIN
            UserInfo with (NOLOCK)
        ON
            Webs.FirstUniqueAncestorWebId = Webs.Id AND     
            UserInfo.tp_SiteID = @SiteId AND
            UserInfo.tp_ID = @UserId
        WHERE
            Webs.SiteId = @SiteId AND
            Webs.ParentWebId = @ParentWebId AND
            (@WebTemplate IS NULL OR
             (Webs.WebTemplate = @WebTemplate AND   
              (@ProvisionConfig IS NULL OR
               Webs.ProvisionConfig = @ProvisionConfig))) AND   
            (@ToLinkRecurringMeeting IS NULL OR
             (Webs.WebTemplate = 2 AND    
              (@ToLinkRecurringMeeting = 1 AND Webs.MeetingCount = 0) OR    
              (@ToLinkRecurringMeeting = 0 AND Webs.MeetingCount <> -1)))   
        ORDER BY
            Webs.Title COLLATE Latin1_General_CI_AS
    END
    ELSE IF (@Collation = N'Japanese_CI_AS')
    BEGIN 
        SELECT
            Webs.FullUrl,
            Webs.Id,            
            ISNULL(Webs.Title, ''),
            ISNULL(Webs.Description, ''),
            Webs.Language,
            Webs.WebTemplate,
            Webs.ProvisionConfig,
            Webs.MeetingCount,
            CASE WHEN Webs.FirstUniqueAncestorWebId = Webs.Id   
                 THEN Perms.Acl
                 ELSE NULL
            END,
            Perms.AnonymousPermMask,
            Webs.FirstUniqueAncestorWebId,
            Webs.SecurityProvider,
            Webs.TimeCreated,
            (SELECT MAX(tp_Modified) FROM Lists WITH (NOLOCK) WHERE Lists.tp_WebId = Webs.Id)
        FROM
            Webs WITH (NOLOCK)
        INNER JOIN
            Perms WITH (NOLOCK)
        ON
            Perms.SiteId = Webs.SiteId AND
            Perms.ScopeId = Webs.ScopeId
        LEFT OUTER JOIN
            UserInfo with (NOLOCK)
        ON
            Webs.FirstUniqueAncestorWebId = Webs.Id AND     
            UserInfo.tp_SiteID = @SiteId AND
            UserInfo.tp_ID = @UserId
        WHERE
            Webs.SiteId = @SiteId AND
            Webs.ParentWebId = @ParentWebId AND
            (@WebTemplate IS NULL OR
             (Webs.WebTemplate = @WebTemplate AND   
              (@ProvisionConfig IS NULL OR
               Webs.ProvisionConfig = @ProvisionConfig))) AND   
            (@ToLinkRecurringMeeting IS NULL OR
             (Webs.WebTemplate = 2 AND    
              (@ToLinkRecurringMeeting = 1 AND Webs.MeetingCount = 0) OR    
              (@ToLinkRecurringMeeting = 0 AND Webs.MeetingCount <> -1)))   
        ORDER BY
            Webs.Title COLLATE Japanese_CI_AS
    END
    ELSE IF (@Collation = N'Modern_Spanish_CI_AS')
    BEGIN 
        SELECT
            Webs.FullUrl,
            Webs.Id,            
            ISNULL(Webs.Title, ''),
            ISNULL(Webs.Description, ''),
            Webs.Language,
            Webs.WebTemplate,
            Webs.ProvisionConfig,
            Webs.MeetingCount,
            CASE WHEN Webs.FirstUniqueAncestorWebId = Webs.Id   
                 THEN Perms.Acl
                 ELSE NULL
            END,
            Perms.AnonymousPermMask,
            Webs.FirstUniqueAncestorWebId,
            Webs.SecurityProvider,
            Webs.TimeCreated,
            (SELECT MAX(tp_Modified) FROM Lists WITH (NOLOCK) WHERE Lists.tp_WebId = Webs.Id)
        FROM
            Webs WITH (NOLOCK)
        INNER JOIN
            Perms WITH (NOLOCK)
        ON
            Perms.SiteId = Webs.SiteId AND
            Perms.ScopeId = Webs.ScopeId
        LEFT OUTER JOIN
            UserInfo with (NOLOCK)
        ON
            Webs.FirstUniqueAncestorWebId = Webs.Id AND     
            UserInfo.tp_SiteID = @SiteId AND
            UserInfo.tp_ID = @UserId
        WHERE
            Webs.SiteId = @SiteId AND
            Webs.ParentWebId = @ParentWebId AND
            (@WebTemplate IS NULL OR
             (Webs.WebTemplate = @WebTemplate AND   
              (@ProvisionConfig IS NULL OR
               Webs.ProvisionConfig = @ProvisionConfig))) AND   
            (@ToLinkRecurringMeeting IS NULL OR
             (Webs.WebTemplate = 2 AND    
              (@ToLinkRecurringMeeting = 1 AND Webs.MeetingCount = 0) OR    
              (@ToLinkRecurringMeeting = 0 AND Webs.MeetingCount <> -1)))   
        ORDER BY
            Webs.Title COLLATE Modern_Spanish_CI_AS
    END
    ELSE IF (@Collation = N'French_CI_AS')
    BEGIN 
        SELECT
            Webs.FullUrl,
            Webs.Id,            
            ISNULL(Webs.Title, ''),
            ISNULL(Webs.Description, ''),
            Webs.Language,
            Webs.WebTemplate,
            Webs.ProvisionConfig,
            Webs.MeetingCount,
            CASE WHEN Webs.FirstUniqueAncestorWebId = Webs.Id   
                 THEN Perms.Acl
                 ELSE NULL
            END,
            Perms.AnonymousPermMask,
            Webs.FirstUniqueAncestorWebId,
            Webs.SecurityProvider,
            Webs.TimeCreated,
            (SELECT MAX(tp_Modified) FROM Lists WITH (NOLOCK) WHERE Lists.tp_WebId = Webs.Id)
        FROM
            Webs WITH (NOLOCK)
        INNER JOIN
            Perms WITH (NOLOCK)
        ON
            Perms.SiteId = Webs.SiteId AND
            Perms.ScopeId = Webs.ScopeId
        LEFT OUTER JOIN
            UserInfo with (NOLOCK)
        ON
            Webs.FirstUniqueAncestorWebId = Webs.Id AND     
            UserInfo.tp_SiteID = @SiteId AND
            UserInfo.tp_ID = @UserId
        WHERE
            Webs.SiteId = @SiteId AND
            Webs.ParentWebId = @ParentWebId AND
            (@WebTemplate IS NULL OR
             (Webs.WebTemplate = @WebTemplate AND   
              (@ProvisionConfig IS NULL OR
               Webs.ProvisionConfig = @ProvisionConfig))) AND   
            (@ToLinkRecurringMeeting IS NULL OR
             (Webs.WebTemplate = 2 AND    
              (@ToLinkRecurringMeeting = 1 AND Webs.MeetingCount = 0) OR    
              (@ToLinkRecurringMeeting = 0 AND Webs.MeetingCount <> -1)))   
        ORDER BY
            Webs.Title COLLATE French_CI_AS
    END
    ELSE IF (@Collation <> '')
    BEGIN
    DECLARE @param1 nvarchar(40)
       SET @param1 = CASE WHEN @SiteId IS NULL THEN N'NULL' ELSE N'''' + CAST(@SiteId AS nvarchar(40)) + N'''' END
    DECLARE @param2 nvarchar(40)
       SET @param2 = CASE WHEN @ParentWebId IS NULL THEN N'NULL' ELSE N'''' + CAST(@ParentWebId AS nvarchar(40)) + N'''' END
    DECLARE @param3 nvarchar(40)
       SET @param3 = CASE WHEN @UserId IS NULL THEN N'NULL' ELSE CAST(@UserId AS nvarchar(40)) END
    DECLARE @param4 nvarchar(40)
       SET @param4 = CASE WHEN @WebTemplate IS NULL THEN N'NULL' ELSE CAST(@WebTemplate AS nvarchar(40)) END
    DECLARE @param5 nvarchar(40)
       SET @param5 = CASE WHEN @ProvisionConfig IS NULL THEN N'NULL' ELSE CAST(@ProvisionConfig AS nvarchar(40)) END
    DECLARE @param6 nvarchar(40)
       SET @param6 = CASE WHEN @ToLinkRecurringMeeting IS NULL THEN N'NULL' ELSE CAST(@ToLinkRecurringMeeting AS nvarchar(40)) END
    EXEC(N'
        DECLARE @SiteId uniqueidentifier
        DECLARE @ParentWebId uniqueidentifier
        DECLARE @UserId int
        DECLARE @WebTemplate int
        DECLARE @ProvisionConfig smallint
        DECLARE @ToLinkRecurringMeeting bit
        SET @SiteId = ' + @param1 + N'
        SET @ParentWebId = ' + @param2 + N'
        SET @UserId = ' + @param3 + N'
        SET @WebTemplate = ' + @param4 + N'
        SET @ProvisionConfig = ' + @param5 + N'
        SET @ToLinkRecurringMeeting = ' + @param6 + N'
        SELECT
            Webs.FullUrl,
            Webs.Id,            
            ISNULL(Webs.Title, ''''),
            ISNULL(Webs.Description, ''''),
            Webs.Language,
            Webs.WebTemplate,
            Webs.ProvisionConfig,
            Webs.MeetingCount,
            CASE WHEN Webs.FirstUniqueAncestorWebId = Webs.Id   
                 THEN Perms.Acl
                 ELSE NULL
            END,
            Perms.AnonymousPermMask,
            Webs.FirstUniqueAncestorWebId,
            Webs.SecurityProvider,
            Webs.TimeCreated,
            (SELECT MAX(tp_Modified) FROM Lists WITH (NOLOCK) WHERE Lists.tp_WebId = Webs.Id)
        FROM
            Webs WITH (NOLOCK)
        INNER JOIN
            Perms WITH (NOLOCK)
        ON
            Perms.SiteId = Webs.SiteId AND
            Perms.ScopeId = Webs.ScopeId
        LEFT OUTER JOIN
            UserInfo with (NOLOCK)
        ON
            Webs.FirstUniqueAncestorWebId = Webs.Id AND     
            UserInfo.tp_SiteID = @SiteId AND
            UserInfo.tp_ID = @UserId
        WHERE
            Webs.SiteId = @SiteId AND
            Webs.ParentWebId = @ParentWebId AND
            (@WebTemplate IS NULL OR
             (Webs.WebTemplate = @WebTemplate AND   
              (@ProvisionConfig IS NULL OR
               Webs.ProvisionConfig = @ProvisionConfig))) AND   
            (@ToLinkRecurringMeeting IS NULL OR
             (Webs.WebTemplate = 2 AND    
              (@ToLinkRecurringMeeting = 1 AND Webs.MeetingCount = 0) OR    
              (@ToLinkRecurringMeeting = 0 AND Webs.MeetingCount <> -1)))   
        ORDER BY
            Webs.Title COLLATE ' + @Collation)
    END
    ELSE
    BEGIN 
        SELECT
            Webs.FullUrl,
            Webs.Id,            
            ISNULL(Webs.Title, ''),
            ISNULL(Webs.Description, ''),
            Webs.Language,
            Webs.WebTemplate,
            Webs.ProvisionConfig,
            Webs.MeetingCount,
            CASE WHEN Webs.FirstUniqueAncestorWebId = Webs.Id   
                 THEN Perms.Acl
                 ELSE NULL
            END,
            Perms.AnonymousPermMask,
            Webs.FirstUniqueAncestorWebId,
            Webs.SecurityProvider,
            Webs.TimeCreated,
            (SELECT MAX(tp_Modified) FROM Lists WITH (NOLOCK) WHERE Lists.tp_WebId = Webs.Id)
        FROM
            Webs WITH (NOLOCK)
        INNER JOIN
            Perms WITH (NOLOCK)
        ON
            Perms.SiteId = Webs.SiteId AND
            Perms.ScopeId = Webs.ScopeId
        LEFT OUTER JOIN
            UserInfo with (NOLOCK)
        ON
            Webs.FirstUniqueAncestorWebId = Webs.Id AND     
            UserInfo.tp_SiteID = @SiteId AND
            UserInfo.tp_ID = @UserId
        WHERE
            Webs.SiteId = @SiteId AND
            Webs.ParentWebId = @ParentWebId AND
            (@WebTemplate IS NULL OR
             (Webs.WebTemplate = @WebTemplate AND   
              (@ProvisionConfig IS NULL OR
               Webs.ProvisionConfig = @ProvisionConfig))) AND   
            (@ToLinkRecurringMeeting IS NULL OR
             (Webs.WebTemplate = 2 AND    
              (@ToLinkRecurringMeeting = 1 AND Webs.MeetingCount = 0) OR    
              (@ToLinkRecurringMeeting = 0 AND Webs.MeetingCount <> -1)))   
    END
    RETURN 0
END

GO
