/****** Object:  StoredProcedure [dbo].[proc_GetMetaInfoForSingleDoc]    Script Date: 5/15/2018 12:12:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetMetaInfoForSingleDoc(
    @DocSiteId uniqueidentifier,
    @DocDirName nvarchar(256),
    @DocLeafName nvarchar(128),
    @UserId int,
    @Level tinyint,
    @CheckCacheParseId bit = 0,       
    @DocWebId uniqueidentifier = NULL)
AS
    DECLARE @DocId uniqueidentifier
    SELECT
        Docs.Id,                                        
        CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END,          
        Docs.Type,                                      
        Docs.MetaInfoTimeLastModified,                  
        Docs.MetaInfo,                                  
        Size,                                           
        Docs.TimeCreated,                               
        TimeLastModified,                               
        Docs.Version,                                   
        Docs.DocFlags,                                  
        NULL, 
        NULL, 
        NULL, 
        CASE WHEN @CheckCacheParseId = 1                
        THEN
            CacheParseId
        ELSE
            NULL
        END,
        NULL, 
        NULL, 
        UserInfo.tp_Login,                              
        Docs.CheckoutDate,                              
        CASE WHEN LTCheckoutUserId IS NULL              
        THEN 
            Docs.CheckoutExpires
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
        NULL,    
        Perms.Acl,          
        Perms.AnonymousPermMask, 
        Docs.DraftOwnerId,  
        Docs.Level,                                     
        Docs.ParentVersion,                             
        Docs.TransformerId,                             
        Docs.ParentLeafName,                            
        Docs.ProgId,                                    
        Docs.DoclibRowId,                               
        NULL,     
        Docs.ListId                                     
    FROM
        Docs
    INNER JOIN
        Perms
    ON
        Docs.SiteId = Perms.SiteId AND
        Docs.ScopeId = Perms.ScopeId
    LEFT OUTER JOIN
        UserInfo
    ON
        Docs.CheckoutUserId = UserInfo.tp_Id AND
        Docs.SiteId = UserInfo.tp_SiteID
    WHERE
        Docs.SiteId = @DocSiteId AND
        Docs.DirName = @DocDirName AND 
        Docs.LeafName = @DocLeafName AND
        Docs.Level = @Level AND 
        (@DocWebId IS NULL OR Docs.WebId = @DocWebId)
    IF @@ROWCOUNT > 0
    BEGIN
        IF (@DocWebId IS NULL)
        BEGIN
            SELECT
                NULL
            WHERE
                1 = 0
        END
        ELSE
        BEGIN
            SELECT TOP 1
                @DocId = Id
            FROM
                Docs
            WHERE
                Docs.SiteId = @DocSiteId AND
                Docs.DirName = @DocDirName AND 
                Docs.LeafName = @DocLeafName
            EXEC proc_GetEventReceivers @DocSiteId, @DocWebId, @DocId, 3
        END
    END

GO
