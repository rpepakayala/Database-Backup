/****** Object:  StoredProcedure [dbo].[proc_RenameUrl]    Script Date: 5/15/2018 12:12:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_RenameUrl(
    @SiteId                uniqueidentifier,
    @SubWebId              uniqueidentifier,
    @OldUrl                nvarchar(260),
    @NewUrl                nvarchar(260),
    @UserId                int,
    @RenameFlags           int = 0,
    @PutFlags              int = 0,
    @ReturnFlags           int = 0,
    @AttachmentOpOldUrl    int = 3,
    @AttachmentOpNewUrl    int = 3,
    @ParseDocsNow          tinyint = NULL OUTPUT,
    @FailedUrl             nvarchar(260) = NULL OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @WebUrl nvarchar(256)
    DECLARE @SrcUrlType tinyint
    DECLARE @DstUrlType tinyint
    DECLARE @DstUrlParentType tinyint
    DECLARE @DstUrlParentWebId uniqueidentifier
    DECLARE @DstUrlParentDocId uniqueidentifier
    DECLARE @ParentWebId uniqueidentifier
    DECLARE @DstWebId uniqueidentifier    
    DECLARE @AncestrySize int
    DECLARE @ReturnStatus int
    DECLARE @UrlsAreEquivalent bit
    DECLARE @RenamingWeb bit
    DECLARE @MakingThicket bit
    DECLARE @ThicketFlag bit
    DECLARE @OldDirName nvarchar(256)
    DECLARE @OldLeafName nvarchar(128)
    DECLARE @SrcDoclibRowId int
    DECLARE @NewDirName nvarchar(256)
    DECLARE @NewLeafName nvarchar(128)
    DECLARE @NewDirDirName nvarchar(256)
    DECLARE @NewDirLeafName nvarchar(128)
    DECLARE @FailedDirName nvarchar(256)
    DECLARE @FailedLeafName nvarchar(128)
    DECLARE @ScopeId uniqueidentifier
    DECLARE @FirstUniqueAncestorWebId uniqueidentifier   
    SELECT @RenamingWeb = @RenameFlags & 32
    SELECT @MakingThicket =
        CASE
            WHEN ((@PutFlags & 128) =
                128)
        THEN
            1
        ELSE
            0
        END
    SET @ParseDocsNow = 0
    SELECT
        @WebUrl = FullUrl,
        @ScopeId = ScopeId,
        @ParentWebId = ParentWebId,
        @FirstUniqueAncestorWebId = FirstUniqueAncestorWebId,
        @AncestrySize = ISNULL(DATALENGTH(Ancestry), 0)
    FROM
        Webs
    WHERE
        SiteId = @SiteId AND
        Id = @SubWebId
    IF @@ROWCOUNT = 0
    BEGIN
        RETURN 3
    END
    EXEC proc_SplitUrl @OldUrl, @OldDirName OUTPUT, @OldLeafName OUTPUT
    EXEC proc_SplitUrl @NewUrl, @NewDirName OUTPUT, @NewLeafName OUTPUT
    IF (@RenamingWeb = 1 AND
        @OldDirName <> @NewDirName)
    BEGIN
        SET @RenameFlags = @RenameFlags | 256
    END
    EXEC proc_SplitUrl @NewDirName,
        @NewDirDirName OUTPUT,
        @NewDirLeafName OUTPUT
    SELECT
        @SrcUrlType = Type,
        @ThicketFlag = ThicketFlag,
        @SrcDoclibRowId = DoclibRowId
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @OldDirName AND
        LeafName = @OldLeafName AND
        (Type = 0 OR Type = 1 OR
        (Type = 2 AND @RenamingWeb = 1)) AND
        WebId = @SubWebId
    IF @@ROWCOUNT = 0
    BEGIN
        IF EXISTS(
            SELECT 
                * 
            FROM 
                Docs 
            WHERE 
                SiteId = @SiteId AND
                DirName = @OldDirName AND
                LeafName = @OldLeafName AND
                WebId = @SubWebId )
        BEGIN
            RETURN 50
        END
        ELSE
        BEGIN
            RETURN 3
        END
    END
    IF @ThicketFlag IS NULL OR (@ThicketFlag = 1 AND NOT
            (@SrcUrlType = 0 AND
            (@RenameFlags & 2048) =
                2048))
    BEGIN
        RETURN 214
    END
    IF @MakingThicket = 1
    BEGIN
        RETURN 190
    END
    SET @UrlsAreEquivalent = CASE WHEN (@OldUrl = @NewUrl) THEN 1 ELSE 0 END
    BEGIN TRAN
    DECLARE @guidT uniqueidentifier
    DECLARE @guidTOld uniqueidentifier
    DECLARE @count int
    EXEC proc_GetContainingListOutput
            @SiteId,
            @SubWebId,
            @NewUrl,
            @guidT OUTPUT
    EXEC proc_GetContainingListOutput
            @SiteId,
            @SubWebId,
            @OldUrl,
            @guidTOld OUTPUT
    IF @guidT IS NOT NULL
    BEGIN
    SELECT
        @guidT = tp_Id
    FROM
        Lists WITH(UPDLOCK)
    WHERE
        Lists.tp_WebId = @SubWebId AND
        Lists.tp_Id = @guidT
    END 
    IF @guidTOld IS NOT NULL
    BEGIN
    SELECT
        @guidTOld = tp_Id
    FROM
        Lists WITH(UPDLOCK)
    WHERE
        Lists.tp_WebId = @SubWebId AND
       Lists.tp_Id = @guidTOld
    END    
    SELECT
        @DstUrlParentType = Type,
        @DstUrlParentWebId = WebId,
        @DstUrlParentDocId = Id,
        @NewDirDirName = DirName,
        @NewDirLeafName = LeafName
    FROM
        Docs WITH (REPEATABLEREAD)
    WHERE
        SiteId = @SiteId AND
        DirName = @NewDirDirName AND
        LeafName = @NewDirLeafName
    IF @DstUrlParentType IS NULL OR
       (@DstUrlParentWebId <> @SubWebId AND @RenamingWeb = 0) OR
       (@NewDirDirName = @OldDirName AND
        @NewDirLeafName = @OldLeafName)
    BEGIN
        SET @ReturnStatus = 2
        GOTO CLEANUP
    END
    SET @NewDirName = CASE WHEN (DATALENGTH(@NewDirDirName) = 0) THEN @NewDirLeafName WHEN (DATALENGTH(@NewDirLeafName) = 0) THEN @NewDirDirName ELSE @NewDirDirName + N'/' + @NewDirLeafName END
    SET @NewUrl = CASE WHEN (DATALENGTH(@NewDirName) = 0) THEN @NewLeafName WHEN (DATALENGTH(@NewLeafName) = 0) THEN @NewDirName ELSE @NewDirName + N'/' + @NewLeafName END
    SELECT
        @DstUrlType = Type,
        @DstWebId = WebId
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @NewDirName AND
        LeafName = @NewLeafName
    IF @DstUrlType IS NOT NULL
    BEGIN
        IF (@UrlsAreEquivalent = 0)
        BEGIN
            IF (@PutFlags & 2 = 2 AND
                @SrcUrlType = 0 AND
                @DstUrlType = 0)
            BEGIN
                EXEC @ReturnStatus = proc_DeleteUrl
                    @SiteId,
                    @DstWebId,
                    @NewUrl,
                    @UserId,
                    1, 
                    0,
                    0,
                    0,
                    3,
                    0,
                    3,
                    0,
                    @FailedUrl OUTPUT
                IF (@ReturnStatus <> 0) AND
                    (@ReturnStatus <> 3)
                BEGIN
                    EXEC proc_SplitUrl @FailedUrl,
                        @FailedDirName OUTPUT,
                        @FailedLeafName OUTPUT
                    GOTO CLEANUP
                END
            END
            ELSE
            BEGIN
                IF (@SrcUrlType = 0 AND
                    @DstUrlType = 0)
                BEGIN
                    SET @ReturnStatus = 80
                    GOTO CLEANUP
                END
                ELSE
                BEGIN
                    SET @ReturnStatus = 144
                    GOTO CLEANUP
                END
            END
        END
    END
    IF (@OldDirName <> @NewDirName)
    BEGIN
        EXEC proc_UpdateChildCount @SiteId, @OldDirName, @OldLeafName,
                                   @SrcDoclibRowId, 0, @SrcUrlType, -1
        EXEC proc_UpdateChildCount @SiteId, @NewDirName, @NewLeafName,
                                   @SrcDoclibRowId, 0, @SrcUrlType, 1
    END
    IF @SrcUrlType = 0
        BEGIN
            EXEC @ReturnStatus = proc_RenameFile @SiteId,
                @SubWebId,
                @WebUrl,
                @OldUrl,
                @NewUrl,
                @DstUrlParentDocId,
                @UserId,
                @RenameFlags,
                @PutFlags,
                @ReturnFlags,
                @AttachmentOpOldUrl,
                @AttachmentOpNewUrl,
                @ParseDocsNow OUTPUT,
                @FailedDirName OUTPUT,
                @FailedLeafName OUTPUT
        END
    ELSE 
        BEGIN
            EXEC @ReturnStatus = proc_RenameDir @SiteId,
                @SubWebId,
                @ParentWebId,
                @ScopeId,
                @FirstUniqueAncestorWebId,
                @DstUrlParentWebId,
                @WebUrl,
                @OldUrl,
                @NewUrl,
                @DstUrlParentDocId,
                @AncestrySize,
                @UserId,
                @RenameFlags,
                @PutFlags,
                @ReturnFlags,
                @ParseDocsNow OUTPUT,
                @FailedDirName OUTPUT,
                @FailedLeafName OUTPUT
        END
CLEANUP:
    IF (@ReturnStatus <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    IF @FailedDirName IS NOT NULL AND @FailedLeafName IS NOT NULL
    BEGIN
        SET @FailedUrl = CASE WHEN (DATALENGTH(@FailedDirName) = 0) THEN @FailedLeafName WHEN (DATALENGTH(@FailedLeafName) = 0) THEN @FailedDirName ELSE @FailedDirName + N'/' + @FailedLeafName END
    END
    RETURN @ReturnStatus

GO
