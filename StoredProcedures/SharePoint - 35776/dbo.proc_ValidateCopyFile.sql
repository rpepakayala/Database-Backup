/****** Object:  StoredProcedure [dbo].[proc_ValidateCopyFile]    Script Date: 5/15/2018 12:12:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ValidateCopyFile(
    @SiteId                uniqueidentifier,
    @SubWebId              uniqueidentifier,
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
    DECLARE @IsAttachment      bit
    DECLARE @WantFlags int
    DECLARE @ReturnStatus int
    SET @WantFlags = 0
    SET @ReturnStatus = 0
    SET @OldBaseType = -1
    SET @NewBaseType = -1
    EXEC proc_SplitUrl
        @OldUrl,
        @OldUrlDirName OUTPUT,
        @OldUrlLeafName OUTPUT
    EXEC proc_SplitUrl
        @NewUrl,
        @NewUrlDirName OUTPUT,
        @NewUrlLeafName OUTPUT
    EXEC proc_GetContainingListOutput @SiteId, @SubWebId, @OldUrl, 
        @OldListId OUTPUT, @OldBaseType OUTPUT,
        @OldListExcludedType OUTPUT
    EXEC proc_GetContainingListOutput @SiteId, @SubWebId, @NewUrl,
        @NewListId OUTPUT, @NewBaseType OUTPUT,
        @NewListExcludedType OUTPUT
    IF (@OldListExcludedType <> 0x00 AND
        @OldListExcludedType <> 0x04) OR
        (@NewListExcludedType <> 0x00 AND
            @NewListExcludedType <> 0x04)
    BEGIN                
        IF (@OldListExcludedType = 0x01 AND 
            @OldBaseType = 1 OR
            @NewListExcludedType = 0x01 AND
            @NewBaseType= 1) AND
            (@OldUrlDirName <> @NewUrlDirName) AND
            (@RenameFlags & 512) = 0
        BEGIN
            RETURN 15
        END
        IF (@OldListExcludedType = 0x02 OR
            @NewListExcludedType = 0x02) OR
            (@OldListExcludedType = 0x03 OR
            @NewListExcludedType = 0x03)
        BEGIN
            RETURN 130
        END
    END
    SELECT @WantFlags = @WantFlags | 0x0002
    SELECT @WantFlags = @WantFlags | CASE
        WHEN
            DATALENGTH(@OldUrl) < DATALENGTH(@NewUrl)
        THEN
            0x0100
        ELSE
            0
        END
    EXEC @ReturnStatus = proc_CheckDirectoryTree @SiteId, @OldUrl, @NewUrl,
        @UserId, @WantFlags,
        @FailedDirName OUTPUT,
        @FailedLeafName OUTPUT
    RETURN @ReturnStatus

GO
