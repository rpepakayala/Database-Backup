/****** Object:  StoredProcedure [dbo].[proc_GetDocBuildDependencySet]    Script Date: 5/15/2018 12:12:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetDocBuildDependencySet(
    @DocSiteId uniqueidentifier,
    @DocDirName  nvarchar(256),
    @DocLeafName nvarchar(128),
    @Level tinyint,
    @UserId int,
    @BuildDependencySetLength int)
AS
    SET NOCOUNT ON
    IF (@BuildDependencySetLength IS NULL) 
    BEGIN
        SELECT NULL as BuildDependencySet
    END
    ELSE IF (@BuildDependencySetLength = 0) 
    BEGIN
        SELECT img as BuildDependencySet FROM Image0x WITH(NOLOCK)
    END
    ELSE
    BEGIN
        SELECT 
            Docs.BuildDependencySet
        FROM
            Docs
        WHERE
            Docs.SiteId = @DocSiteId AND
            Docs.DirName = @DocDirName AND
            Docs.LeafName = @DocLeafName AND
            Docs.Level = @Level
        SELECT
            Docs.DirName,
            Docs.LeafName,
            Webs.FullUrl as WebsFullUrl,
            Webs.FirstUniqueAncestorWebId,
            Webs.SecurityProvider,
            Perms.Acl,
            Perms.AnonymousPermMask,
            Docs.WebId,
            Docs.ListId, 
            0  AS UniqueList, 
            CASE WHEN Docs.ListId IS NULL THEN 0 ELSE  
                CASE WHEN Docs.DoclibRowId IS NULL THEN 0 ELSE 1 END
                END AS InDocLibrary,
            CASE WHEN Docs.DraftOwnerId IS NULL THEN 0 ELSE Docs.DraftOwnerId END AS DraftOwnerId,
            COALESCE(Lists.tp_Flags, 0) As ListFlags,
            Docs.ProgId,
            Docs.SetupPathVersion AS SetupPathVersion,
            CASE WHEN Docs.HasStream = 0 THEN Docs.SetupPath ELSE NULL END AS SetupPath,
            Docs.TimeLastWritten,
            Webs.MasterUrl,
            Webs.CustomMasterUrl,
            Docs.Version,
            Docs.Id,
            Docs.BuildDependencySet
         FROM
            BuildDependencies
        INNER JOIN
            Docs WITH(NOLOCK)
        ON
            BuildDependencies.SiteId = Docs.SiteId AND
            BuildDependencies.TargetLeafName = Docs.LeafName AND
            BuildDependencies.TargetDirName = Docs.DirName
        INNER JOIN
            Webs 
        ON 
            Docs.WebId = Webs.Id
        INNER JOIN 
            Perms 
        ON
            Docs.SiteID = Perms.SiteId AND
            Docs.ScopeId = Perms.ScopeId
        LEFT OUTER JOIN 
            Lists WITH (NOLOCK)
        ON
            Lists.tp_ID = Docs.ListId AND
            Lists.tp_WebId = Docs.WebId
        WHERE
            BuildDependencies.SiteId = @DocSiteId AND
            BuildDependencies.DirName = @DocDirName AND
            BuildDependencies.LeafName = @DocLeafName AND
            Docs.Level = 1 AND
           (Docs.Dirty IS NULL OR Docs.Dirty = 0) AND 
           (Docs.LTCheckOutUserid IS NULL OR @UserId IS NULL OR Docs.LTCheckOutUserid <> @UserId)
        OPTION (FORCE ORDER)
    END
    RETURN 0

GO
