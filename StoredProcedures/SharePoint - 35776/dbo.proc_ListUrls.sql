/****** Object:  StoredProcedure [dbo].[proc_ListUrls]    Script Date: 5/15/2018 12:12:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ListUrls(
    @DirSiteId uniqueidentifier,
    @DirWebId    uniqueidentifier,
    @DirFullUrl nvarchar(260),
    @AttachmentsFlag tinyint,
    @ClientTimeStamp datetime,
    @FetchLinkInfo bit,
    @IncludeThicketDirs bit,
    @IncludeListItems bit,
    @UserId int)
AS
    SET NOCOUNT ON
    DECLARE @DirDirName nvarchar(256)
    DECLARE @DirLeafName nvarchar(128)
    DECLARE @Level tinyint
    DECLARE @iRet int
    SET @iRet = 0
    EXEC proc_SplitUrl @DirFullUrl, @DirDirName OUTPUT, @DirLeafName OUTPUT
    EXEC proc_GetLevel  @DirSiteId, 
        @DirDirName, 
        @DirLeafName, 
        @UserId,
        1,
        @Level OUTPUT
IF 0 = 1
BEGIN
    EXEC @iRet = proc_GetContainingListIfDirty @DirSiteId,
        @DirWebId, @DirFullUrl
    IF @iRet <> 0
        RETURN @iRet
END
    BEGIN TRAN  
    EXEC proc_SecGetIndividualUrlSecurity @DirSiteId, @DirWebId,
        @DirFullUrl, @DirDirName, @DirLeafName, @UserId, @AttachmentsFlag, 0, 0, 0, 1, @Level
    SELECT dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    IF NOT EXISTS (
        SELECT
            *
        FROM
            Docs
        WHERE
            SiteId = @DirSiteId AND
            DirName = @DirDirName AND
            LeafName = @DirLeafName AND
            Level = @Level AND
            (Type = 1 OR Type = 2) AND
            WebId = @DirWebId
            )
    BEGIN
        IF (3 <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
        RETURN 3
    END
    SELECT
        FullUrl
    FROM
        Webs
    WHERE
        ParentWebId = @DirWebId AND
        SiteId = @DirSiteId
    IF (NOT (DATALENGTH(@DirFullUrl) = 0))
    BEGIN
        SELECT 
            Docs.Id,                                    
            CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END,      
            Docs.Type,                                  
            Docs.MetaInfoTimeLastModified,              
            CASE WHEN                                   
                (Docs.MetaInfoTimeLastModified <= @ClientTimeStamp AND
                Docs.Type = 0)
            THEN
                NULL
            ELSE
                Docs.MetaInfo
            END AS MetaInfo,
            Size,                                       
            Docs.TimeCreated,                           
            Docs.TimeLastModified AS TimeLastModified,  
            Docs.Version,                               
            Docs.DocFlags,                              
            Lists.tp_BaseType + Lists.tp_ServerTemplate * 256, 
            N'{' + CAST(Lists.tp_ID AS nvarchar(36)) + N'}' AS tp_Name,
            CASE WHEN                                   
                (Lists.tp_RootFolder = Docs.Id )
            THEN
                Lists.tp_Title
            ELSE
                NULL
            END,                                                  
            NULL AS CacheParseId,                       
            NULL, 
            NULL, 
            NULL, 
            NULL, 
            NULL,  
            Docs.VirusStatus,                           
            Docs.VirusInfo,                             
            SetupPathVersion,                           
            SetupPath,                                  
            SetupPathUser,                              
            Docs.NextToLastTimeModified,                
            Docs.UIVersion,                             
            Docs.CheckinComment, 
            Docs.WelcomePageUrl,                        
            Docs.WelcomePageParameters,                 
            Lists.tp_Flags,                             
            Perms.Acl,          
            Perms.AnonymousPermMask, 
            Docs.DraftOwnerId,                          
            Docs.Level,                                 
            Docs.ParentVersion,                         
            Docs.TransformerId,                         
            Docs.ParentLeafName,                        
            Docs.ProgId,                                
            Docs.DoclibRowId,                           
            Lists.tp_DefaultWorkflowId,                 
            Docs.ListId                                 
        FROM
            Docs
        INNER JOIN
            Perms
        ON
            Docs.SiteId = Perms.SiteId AND
            Docs.ScopeId = Perms.ScopeId
        LEFT OUTER JOIN
            Lists WITH(NOLOCK) 
        ON
            Lists.tp_WebId = @DirWebId AND
            Docs.Type = 1 AND
            ( Lists.tp_RootFolder = Docs.Id OR
              Lists.tp_ID = Docs.ListId AND
              Docs.DoclibRowId IS NOT NULL)
        WHERE
            Docs.SiteId = @DirSiteId AND 
            Docs.DirName = @DirDirName AND 
            Docs.LeafName = @DirLeafName AND
            Docs.Level = @Level
    END    
    IF @FetchLinkInfo = 1
    BEGIN
        EXEC proc_GetLinkInfo @DirSiteId, @DirFullUrl, 
            @ClientTimeStamp, @IncludeListItems, @UserId 
    END
    SELECT 
        Docs.Id,                                        
        CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END,          
        Docs.Type,                                      
        Docs.MetaInfoTimeLastModified,                  
        CASE WHEN                                       
            (Docs.MetaInfoTimeLastModified <= @ClientTimeStamp AND
            Docs.Type = 0)
        THEN
            NULL
        ELSE
            Docs.MetaInfo
        END AS MetaInfo,
        Size,                                           
        Docs.TimeCreated,                               
        Docs.TimeLastModified,                          
        Docs.Version,                                   
        Docs.DocFlags,                                  
        Lists.tp_BaseType + Lists.tp_ServerTemplate * 256, 
        N'{' + CAST(Lists.tp_ID AS nvarchar(36)) + N'}' AS tp_Name, 
        CASE WHEN                                   
                (Lists.tp_RootFolder = Docs.Id )
            THEN
                Lists.tp_Title
            ELSE
                NULL
        END,                                                  
        NULL AS CacheParseId,                           
        NULL, 
        NULL, 
        UserInfo.tp_Login,                              
        Docs.CheckoutDate,                              
        CASE WHEN LTCheckoutUserId IS NULL              
        THEN Docs.CheckoutExpires
        ELSE NULL
        END,
        Docs.VirusStatus,                               
        Docs.VirusInfo,                                 
        SetupPathVersion,                               
        SetupPath,                                      
        SetupPathUser,                                  
        Docs.NextToLastTimeModified,                    
        Docs.UIVersion,                                 
        Docs.CheckinComment, 
        Docs.WelcomePageUrl,                            
        Docs.WelcomePageParameters,                     
        Lists.tp_Flags,                                 
        Perms.Acl,          
        Perms.AnonymousPermMask, 
        Docs.DraftOwnerId,                              
        Docs.Level,                                     
        Docs.ParentVersion,                             
        Docs.TransformerId,                             
        Docs.ParentLeafName,                            
        Docs.ProgId,                                    
        Docs.DoclibRowId,                               
        Lists.tp_DefaultWorkflowId,                     
        Docs.ListId                                     
    FROM
        Docs
    INNER JOIN
        Perms WITH (INDEX=Perms_Url)
    ON
        Docs.SiteId = Perms.SiteId AND
        Docs.ScopeId = Perms.ScopeId
    LEFT OUTER JOIN
        Lists WITH (NOLOCK)
    ON
        Lists.tp_WebId = @DirWebId AND
        Lists.tp_ID = Docs.ListId AND
        (Docs.Type = 1 AND
        Lists.tp_RootFolder = Docs.Id OR
          Docs.DoclibRowId IS NOT NULL)
    LEFT OUTER JOIN
        UserInfo
    ON
        Docs.CheckoutUserId = UserInfo.tp_Id AND
        Docs.SiteId = UserInfo.tp_SiteID
    WHERE
        Docs.SiteId = @DirSiteId AND
        Docs.DirName = @DirFullUrl AND
        ((Docs.Type = 0 AND
        (@IncludeListItems = 1 OR
         Docs.DocFlags & 2048 = 0 OR
          Docs.DocFlags & 256 = 256)) OR
            (Docs.Type <> 0 AND
          Docs.ThicketFlag IS NOT NULL AND
            (Docs.ThicketFlag = 0 OR
                Docs.ThicketFlag = @IncludeThicketDirs))) AND
        (Docs.Level = 255 AND 
            Docs.LTCheckoutUserId = @UserId OR
        (Docs.Level = 1 OR 
          Docs.Level = 2) AND
        (Docs.LTCheckoutUserId IS NULL OR 
            Docs.LTCheckoutUserId <> @UserId))
    ORDER BY
        Docs.Type, Docs.Id
    OPTION (FORCE ORDER)
    IF (0 <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN 0

GO
