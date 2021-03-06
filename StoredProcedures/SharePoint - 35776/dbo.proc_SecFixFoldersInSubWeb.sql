/****** Object:  StoredProcedure [dbo].[proc_SecFixFoldersInSubWeb]    Script Date: 5/15/2018 12:12:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecFixFoldersInSubWeb(
    @WebId uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @SiteId uniqueidentifier
    DECLARE @RootFolderScopeId uniqueidentifier
    DECLARE @ScopeId uniqueidentifier
    DECLARE @FullUrl nvarchar(260)
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    SELECT 
        @SiteId = Webs.SiteId,
        @FullUrl = Webs.FullUrl,
        @ScopeId = Webs.ScopeId,
        @RootFolderScopeId = Docs.ScopeId,
        @DirName = Docs.DirName,
        @LeafName = Docs.LeafName
    FROM
        Webs, Docs
    WHERE 
        Webs.SiteId = Docs.SiteId AND
        Webs.Id = @WebId AND
        Webs.FullUrl = dbo.fn_GetFullUrl(Docs.DirName, Docs.LeafName)        
    IF @ScopeId <> @RootFolderScopeId
    BEGIN
        BEGIN TRAN
        UPDATE
            Docs
        SET
            ScopeId = @ScopeId
        WHERE
            SiteId = @SiteId AND
            WebId = @WebId AND
            ScopeId = @RootFolderScopeId AND
            ((DirName = @DirName AND LeafName = @LeafName) OR
             DirName = @FullUrl OR
             DirName LIKE dbo.fn_EscapeForLike(@FullUrl, 1))
        UPDATE
            Lists
        SET
            tp_ScopeId = @ScopeId
        WHERE
            tp_WebId = @WebId AND
            tp_ScopeId = @RootFolderScopeId
        COMMIT
    END

GO
