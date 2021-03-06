/****** Object:  StoredProcedure [dbo].[proc_ValidateRenameDir]    Script Date: 5/15/2018 12:13:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ValidateRenameDir(
    @SiteId                uniqueidentifier,
    @SubWebId              uniqueidentifier,
    @DstUrlParentWebId     uniqueidentifier,
    @SubWebUrl             nvarchar(256),
    @OldUrl                nvarchar(260),
    @NewUrl                nvarchar(260),
    @UserId                int,
    @RenameFlags           int,
    @OldListId             uniqueidentifier OUTPUT,
    @OldBaseType           int OUTPUT,
    @OldListExcludedType   int OUTPUT,
    @NewListId             uniqueidentifier OUTPUT,
    @NewBaseType           int OUTPUT,
    @NewListExcludedType   int OUTPUT,
    @FailedDirName         nvarchar(256) OUTPUT,
    @FailedLeafName        nvarchar(128) OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @OldUrlDirName nvarchar(256)
    DECLARE @NewUrlDirName nvarchar(256)
    DECLARE @OldUrlLeafName nvarchar(128)
    DECLARE @NewUrlLeafName nvarchar(128)
    DECLARE @WantFlags int
    DECLARE @ReturnStatus int
    DECLARE @IsAttachment      bit
    SET @OldBaseType = -1
    SET @NewBaseType = -1
    SET @WantFlags = 0
    SET @ReturnStatus = 0
    EXEC proc_SplitUrl
        @OldUrl,
        @OldUrlDirName OUTPUT,
        @OldUrlLeafName OUTPUT
    EXEC proc_SplitUrl
        @NewUrl,
        @NewUrlDirName OUTPUT,
        @NewUrlLeafName OUTPUT
    DECLARE @RenamingWeb bit
    DECLARE @RenamingWebDir bit
    DECLARE @CheckLock bit
    SET @CheckLock = 1
    SELECT @RenamingWeb = @RenameFlags & 32
    SELECT @RenamingWebDir = @RenameFlags & 256
    EXEC proc_GetContainingListOutput @SiteId, @SubWebId, @OldUrl,
        @OldListId OUTPUT, @OldBaseType OUTPUT,
        @OldListExcludedType OUTPUT
    IF (@RenamingWebDir = 1)
    BEGIN
        EXEC proc_GetContainingListOutput @SiteId, @DstUrlParentWebId, @NewUrl,
            @NewListId OUTPUT, @NewBaseType OUTPUT,
            @NewListExcludedType OUTPUT
        IF @NewListId IS NOT NULL
        BEGIN
            RETURN 50
        END
    END
    ELSE
    BEGIN
        EXEC proc_GetContainingListOutput @SiteId, @SubWebId, @NewUrl,
            @NewListId OUTPUT, @NewBaseType OUTPUT,
            @NewListExcludedType OUTPUT
    END
    IF (@OldListExcludedType = 0x04 OR @RenamingWeb = 1
        OR @RenamingWebDir = 1)
    BEGIN
        SET @CheckLock = 0
    END
    IF (@OldListExcludedType <> 0x00 AND
        @OldListExcludedType <> 0x04) OR
        (@NewListExcludedType <> 0x00 AND
            @NewListExcludedType <> 0x04)
    BEGIN                
        IF (@OldListExcludedType = 0x01 AND 
            @OldBaseType = 1 OR
            @NewListExcludedType = 0x01 AND
            @NewBaseType= 1) AND
            (@OldUrlDirName <> @NewUrlDirName)
        BEGIN
            RETURN 15
        END
        IF (@OldListExcludedType = 0x01 OR
            @NewListExcludedType = 0x01) AND
            (@OldUrlLeafName = N'Forms')
        BEGIN
            RETURN 51
        END
        IF (@OldListExcludedType = 0x02 OR
            @NewListExcludedType = 0x02) OR
            (@OldListExcludedType = 0x03 OR
            @NewListExcludedType = 0x03)
        BEGIN
            RETURN 130
        END
    END
    IF (@OldListExcludedType = 0x00 AND
    	@OldBaseType <> 1 AND
    	@OldListId IS NOT NULL  AND 
    	(@NewListId IS NULL OR @NewListId <> @OldListId))
    BEGIN
    	    RETURN 34
    END
    SELECT @WantFlags = @WantFlags | CASE
        WHEN
            @NewListId IS NOT NULL AND
            (@OldListExcludedType <> 0x04 OR
                @NewListExcludedType <> 0x04 OR
                @OldUrl <> @NewUrl)
        THEN
            0x0020
        ELSE
            0
        END
        | CASE
            WHEN
                @RenamingWeb = 1
            THEN
                0
            ELSE
                0x0080
            END
    SELECT @WantFlags = @WantFlags | CASE
        WHEN
            DATALENGTH(@OldUrl) < DATALENGTH(@NewUrl)
        THEN
            0x0100
        ELSE
            0
        END
    SELECT @WantFlags = @WantFlags | CASE
        WHEN
            @CheckLock = 1
        THEN
            0x0010
        ELSE
            0
        END
        | 0x0002
    EXEC @ReturnStatus = proc_CheckDirectoryTree @SiteId, @OldUrl, @NewUrl,
        @UserId,  @WantFlags,
        @FailedDirName OUTPUT,
        @FailedLeafName OUTPUT
    RETURN @ReturnStatus

GO
