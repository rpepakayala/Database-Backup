/****** Object:  StoredProcedure [dbo].[proc_MiniSproc]    Script Date: 5/15/2018 12:12:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MiniSproc(
    @WebSiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @Url nvarchar(260),
    @DGCacheVersion bigint,
    @SystemId tSystemID = NULL)
AS
    SET NOCOUNT ON
    IF @WebId IS NULL
    BEGIN
        DECLARE @ret int
        DECLARE @WebDirName nvarchar(256)
        DECLARE @WebLeafName nvarchar(128)
        EXEC @ret = proc_UrlToWebUrlOutput @WebSiteId, @Url, 
            @WebDirName OUTPUT, @WebLeafName OUTPUT
        IF (@ret <> 0)
        BEGIN
            RETURN @ret
        END
        SELECT CASE WHEN (DATALENGTH(@WebDirName) = 0) THEN @WebLeafName WHEN (DATALENGTH(@WebLeafName) = 0) THEN @WebDirName ELSE @WebDirName + N'/' + @WebLeafName END
        EXEC @ret = proc_GetTpWebMetaData
            @WebSiteId,
            @WebDirName,
            @WebLeafName,
            @DGCacheVersion,
            @SystemId
        IF (@ret <> 0)
        BEGIN
            RETURN @ret
        END
    END
    DECLARE @DocDirName nvarchar(256)
    DECLARE @DocLeafName nvarchar(128)
    DECLARE @CheckoutUserId int
    DECLARE @DraftOwnerId int
    DECLARE @ScopeId uniqueidentifier
    DECLARE @Lists_Flags    bigint 
    DECLARE @Level tinyint
    DECLARE @IsListItem bit
    SET @IsListItem = 0
    EXEC proc_SplitUrl @Url, @DocDirName OUTPUT, @DocLeafName OUTPUT
    DECLARE @UserId int
    SELECT
        @UserId = UserInfo.tp_Id
    FROM
        UserInfo WITH(NOLOCK)
    WHERE
        UserInfo.tp_SiteId = @WebSiteId AND
        UserInfo.tp_SystemId = @SystemId
     EXEC proc_GetLevel  
            @WebSiteId, 
            @DocDirName, 
            @DocLeafName, 
            @UserId,
            1,
            @Level OUTPUT
    IF @Level IS NULL
    	RETURN 2
    DECLARE @DocId uniqueidentifier
    SELECT   TOP 1
        @CheckoutUserId = LTCheckoutUserId,
        @DraftOwnerId = DraftOwnerId,
        @Lists_Flags = Lists.tp_Flags,
        @WebId = WebId,
        @ScopeId = Docs.ScopeId
    FROM 
    	Docs WITH (NOLOCK)
    LEFT OUTER JOIN
        Lists WITH(NOLOCK) 
    ON
        Lists.tp_ID = Docs.ListId AND
        Lists.tp_WebId = Docs.WebId AND
        Docs.DocLibRowId IS NOT NULL
   WHERE
        Docs.SiteId = @WebSiteId AND
        Docs.DirName = @DocDirName AND
        Docs.LeafName = @DocLeafName AND
        Docs.Level = @Level  AND
        WebId = CASE WHEN @WebId IS NULL THEN WebId ELSE @WebId END
    IF (@@ROWCOUNT <> 1)
        RETURN 2
    IF @Lists_Flags IS NOT NULL
    	SET @IsListItem = 1
    DECLARE @PersonalPartsExist int
    IF EXISTS(
        SELECT
           *
        FROM
            WebParts WITH (NOLOCK)
        WHERE
            tp_SiteId = @WebSiteId AND
            tp_PageUrlID = @DocId AND
            tp_Level = 1 AND
            tp_UserID = @UserId)
    BEGIN
        SET @PersonalPartsExist = 1
    END
    ELSE
    BEGIN
    	SET @PersonalPartsExist = 0
    END
    SELECT 
    	@PersonalPartsExist, 
      	CASE WHEN @DraftOwnerId IS NULL THEN 0 ELSE @DraftOwnerId END,
      	CASE WHEN @Lists_Flags IS NULL THEN 0 ELSE @Lists_Flags END,
       Perms.Acl,
       Perms.AnonymousPermMask,
       @Level,
       @IsListItem
   FROM
       Perms
   WHERE
       SiteId = @WebSiteId AND
       ScopeId = @ScopeId
    RETURN 0

GO
