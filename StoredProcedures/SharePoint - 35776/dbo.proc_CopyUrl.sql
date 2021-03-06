/****** Object:  StoredProcedure [dbo].[proc_CopyUrl]    Script Date: 5/15/2018 12:11:47 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CopyUrl(
    @SiteId          uniqueidentifier,
    @SubWebId        uniqueidentifier,
    @OldUrl          nvarchar(260),
    @NewUrl          nvarchar(260),
    @UserId          int,
    @RenameFlags     int = 0,
    @PutFlags        int = 0,
    @ReturnFlags     int = 0,
    @AttachmentOp    int = 3,
    @ParseDocsNow    tinyint = NULL OUTPUT,
    @FailedUrl       nvarchar(260) = NULL OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @WebUrl nvarchar(256)
    DECLARE @ReturnStatus int
    DECLARE @OldDirName nvarchar(256)
    DECLARE @OldLeafName nvarchar(128)
    DECLARE @NewDirName nvarchar(256)
    DECLARE @NewLeafName nvarchar(128)
    DECLARE @NewDirDirName nvarchar(256)
    DECLARE @NewDirLeafName nvarchar(128)
    DECLARE @FailedDirName nvarchar(256)
    DECLARE @FailedLeafName nvarchar(128)
    DECLARE @SrcUrlType tinyint
    DECLARE @DstUrlType tinyint
    DECLARE @DstUrlParentType tinyint
    DECLARE @DstUrlParentWebId uniqueidentifier
    DECLARE @DstUrlParentDocId uniqueidentifier
    DECLARE @ThicketFlag bit
    DECLARE @MakingThicket bit
    DECLARE @UrlsAreEquivalent bit
    DECLARE @bDeletedUrl bit
    DECLARE @SrcWebId uniqueidentifier
    DECLARE @DstWebId uniqueidentifier
    SET @ParseDocsNow = 0
    SET @FailedDirName = NULL
    SET @FailedLeafName = NULL
    SET @bDeletedUrl = 0
    SELECT
        @WebUrl = FullUrl
    FROM
        Webs WITh (NOLOCK)
    WHERE
        SiteId = @SiteId AND
        Id = @SubWebId
    IF @@ROWCOUNT = 0
    BEGIN
        RETURN 3
    END
    EXEC proc_SplitUrl @OldUrl, @OldDirName OUTPUT, @OldLeafName OUTPUT
    EXEC proc_SplitUrl @NewUrl, @NewDirName OUTPUT, @NewLeafName OUTPUT
    EXEC proc_SplitUrl @NewDirName,
        @NewDirDirName OUTPUT,
        @NewDirLeafName OUTPUT
    SELECT @MakingThicket =
        CASE
            WHEN ((@PutFlags & 128) =
                128)
        THEN
            1
        ELSE
            0
        END
    SELECT
        @SrcUrlType = Type,
        @SrcWebId = WebId,
        @ThicketFlag = ThicketFlag       
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @OldDirName AND
        LeafName = @OldLeafName AND
        (Type = 0 OR Type = 1)
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
                LeafName = @OldLeafName)
        BEGIN
            RETURN 50
        END
        ELSE
        BEGIN
            RETURN 3
        END
    END
    IF @ThicketFlag IS NULL OR @ThicketFlag = 1
    BEGIN
        RETURN 214
    END
    IF @MakingThicket = 1
    BEGIN
        RETURN 190
    END
    IF @SrcWebId <> @SubWebId AND (@RenameFlags & 512) = 0
    BEGIN
        RETURN 53
    END
    SET @UrlsAreEquivalent = CASE WHEN (@OldUrl = @NewUrl) THEN 1 ELSE 0 END
    IF @UrlsAreEquivalent = 1
    BEGIN
        RETURN 266
    END
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
        @DstUrlParentDocId = Id
    FROM
        Docs WITH (REPEATABLEREAD)
    WHERE
        SiteId = @SiteId AND
        DirName = @NewDirDirName AND
        LeafName = @NewDirLeafName
    IF @DstUrlParentType IS NULL OR @DstUrlParentWebId <> @SubWebId
    BEGIN
        IF (@RenameFlags & 512) = 0
        BEGIN
            SET @ReturnStatus = 2
            GOTO CLEANUP
        END
    END
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
        IF (@DstUrlType <> @SrcUrlType)
        BEGIN
            SET @ReturnStatus = 144
            GOTO CLEANUP
        END
        IF (@PutFlags & 2 = 2 AND
            (@SrcUrlType = 0 OR
                @SrcUrlType = 1))
        BEGIN
            EXEC @ReturnStatus = proc_DeleteUrlCore
                @SiteId,
                @DstWebId,
                @NewUrl,
                @UserId,
                1, 
                NULL,
                0,
                0,
                0,
                3,
                0,
                3,
                0x,
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
            SET @bDeletedUrl = 1
        END
        ELSE
        BEGIN
            IF (@SrcUrlType = 0)
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
    IF @SrcUrlType = 0
        BEGIN
            EXEC @ReturnStatus = proc_CopyFile @SiteId,
                @SubWebId,
                @WebUrl,
                @OldUrl,
                @NewUrl,
                @DstUrlParentDocId,
                @UserId,
                @RenameFlags,
                @PutFlags,
                @ReturnFlags,
                @AttachmentOp,
                @ParseDocsNow OUTPUT,
                @FailedDirName OUTPUT,
                @FailedLeafName OUTPUT
        END
    ELSE 
        BEGIN
            EXEC @ReturnStatus = proc_CopyDir @SiteId,
                @SubWebId,
                @WebUrl,
                @OldUrl,
                @NewUrl,
                @DstUrlParentDocId,
                @UserId,
                @RenameFlags,
                @PutFlags,
                @ReturnFlags,
                @ParseDocsNow OUTPUT,
                @FailedDirName OUTPUT,
                @FailedLeafName OUTPUT
        END
CLEANUP:
    IF @ReturnStatus = 0
    BEGIN
        IF @bDeletedUrl = 1
        BEGIN
            EXEC proc_UpdateDiskUsed @SiteId
        END
    END
    IF (@ReturnStatus <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    IF @FailedDirName IS NOT NULL AND @FailedLeafName IS NOT NULL
    BEGIN
        SET @FailedUrl = CASE WHEN (DATALENGTH(@FailedDirName) = 0) THEN @FailedLeafName WHEN (DATALENGTH(@FailedLeafName) = 0) THEN @FailedDirName ELSE @FailedDirName + N'/' + @FailedLeafName END
    END
    RETURN @ReturnStatus

GO
