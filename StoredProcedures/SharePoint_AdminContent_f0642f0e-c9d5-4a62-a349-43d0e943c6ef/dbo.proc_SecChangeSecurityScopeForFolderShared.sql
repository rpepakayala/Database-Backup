/****** Object:  StoredProcedure [dbo].[proc_SecChangeSecurityScopeForFolderShared]    Script Date: 5/15/2018 12:12:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecChangeSecurityScopeForFolderShared(
    @SiteId  uniqueidentifier,
    @WebId   uniqueidentifier,
    @ListId  uniqueidentifier,
    @ListBaseType int,
    @DirName   nvarchar(256),
    @LeafName  nvarchar(128),
    @Url     nvarchar(260),
    @UrlLike nvarchar(1024),
    @ThicketFlag bit,
    @OldScopeId uniqueidentifier,
    @NewScopeId uniqueidentifier)
AS
    UPDATE Docs
    SET 
        ScopeId = @NewScopeId
    WHERE 
        SiteId = @SiteId AND
        ScopeId = @OldScopeId AND
        ( (DirName = @DirName AND LeafName = @LeafName) OR
           DirName = @Url OR DirName LIKE @UrlLike)
    DECLARE @ThumbnailDirName nvarchar(256)
    DECLARE @WebImageDirName nvarchar(256)
    DECLARE @SubImgLeafName nvarchar(128)
    EXEC proc_GetSubImageUrls
        @Url,
        @ThumbnailDirName OUTPUT,
        @WebImageDirName OUTPUT,
        @SubImgLeafName OUTPUT
    DECLARE @ThicketLeaf   nvarchar(128)
    DECLARE @ThicketFolder nvarchar(260)
    IF @ThicketFlag = 1
        EXEC proc_GetThicketFolder @SiteId, @DirName, @LeafName, @ThicketLeaf OUTPUT, @ThicketFolder OUTPUT
    UPDATE Docs
    SET 
        ScopeId = @NewScopeId
    WHERE 
        SiteId = @SiteId AND
        DirName = @ThumbnailDirName AND 
        LeafName = @SubImgLeafName
    UPDATE Docs
    SET 
        ScopeId = @NewScopeId
    WHERE 
        SiteId = @SiteId AND
        DirName = @WebImageDirName AND 
        LeafName = @SubImgLeafName
    UPDATE Docs
    SET 
        ScopeId = @NewScopeId
    WHERE 
        SiteId = @SiteId AND
        DirName = @ThicketFolder
    UPDATE Docs
    SET 
        ScopeId = @NewScopeId
    WHERE 
        SiteId = @SiteId AND
        DirName = @DirName AND 
        LeafName = @ThicketLeaf
    EXEC proc_SecFixAttachments @SiteId, @WebId, @ListId, @ListBaseType, @Url, @OldScopeId, @NewScopeId

GO
