/****** Object:  StoredProcedure [dbo].[proc_PrepareForListCreation]    Script Date: 5/15/2018 12:12:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_PrepareForListCreation(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @FeatureId uniqueidentifier,  
    @Title nvarchar(255),
    @DirName nvarchar(256) OUTPUT,
    @FolderNameBase nvarchar(50),
    @bAlternateUrlOnCollision bit,
    @FolderNameToCreate nvarchar(50) OUTPUT,
    @FolderId uniqueidentifier OUTPUT,
    @ScopeId uniqueidentifier OUTPUT,
    @bParentFolderChecked bit)
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    IF (@bParentFolderChecked = 0) AND
        (EXISTS(SELECT * FROM Lists WHERE tp_WebId = @WebId AND
            tp_Title = @Title))
    BEGIN
        RETURN 80
    END
    DECLARE @FolderName nvarchar(256)
    IF @bParentFolderChecked = 0
    BEGIN
EnsureParentFolder:
    EXEC @iRet = proc_EnsureListParentFolder 
        @SiteId, 
        @WebId, 
        @DirName OUTPUT,
        @FolderId OUTPUT,
        @ScopeId OUTPUT
    IF @iRet <> 0
        RETURN @iRet
    END
    ELSE
    BEGIN
        EXEC @iRet = proc_CanonicalDirNameFromUserInput
            @SiteId,
            @WebId,
            @DirName OUTPUT,
            @FolderId OUTPUT
        IF @iRet = 3
            GOTO EnsureParentFolder
        ELSE IF @iRet <> 0
            RETURN @iRet
    END
    IF EXISTS(SELECT * FROM Docs WHERE SiteId = @SiteId AND 
        DirName = @DirName AND LeafName = @FolderNameBase)
    BEGIN
        IF @bAlternateUrlOnCollision = 0
            RETURN 80
        ELSE
        BEGIN
            DECLARE @AttemptCount int                   
            SET @AttemptCount = 1
            SET @FolderNameBase =
                LEFT(@FolderNameBase, 50 - 3)
            WHILE @AttemptCount < 1000
            BEGIN
                SET @FolderName = @FolderNameBase + 
                    CONVERT(nvarchar(8), @AttemptCount)
                IF NOT EXISTS(SELECT * FROM Docs WHERE SiteId = @SiteId AND
                    DirName = @DirName AND LeafName = @FolderName)
                BEGIN
                    BREAK
                END
                SET @AttemptCount = @AttemptCount + 1
            END
            IF @AttemptCount >= 1000
            BEGIN
                RETURN 5
            END
            SET @FolderNameToCreate = @FolderName
        END
    END
    ELSE 
    BEGIN
        SET @FolderNameToCreate = @FolderNameBase
    END

GO
