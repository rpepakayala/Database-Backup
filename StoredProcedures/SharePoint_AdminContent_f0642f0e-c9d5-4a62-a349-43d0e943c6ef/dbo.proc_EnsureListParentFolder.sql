/****** Object:  StoredProcedure [dbo].[proc_EnsureListParentFolder]    Script Date: 5/15/2018 12:12:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_EnsureListParentFolder(
    @SiteId     uniqueidentifier,
    @WebId      uniqueidentifier,
    @DirName    nvarchar(256) OUTPUT,
    @ParentId   uniqueidentifier OUTPUT,
    @ScopeId    uniqueidentifier OUTPUT)
AS
    DECLARE @iRet   int
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
    BEGIN TRAN
    EXEC @iRet = proc_GetContainingListOutput
        @SiteId, @WebId, @DirName, NULL, NULL
    IF @iRet = 0 OR @iRet = 1
    BEGIN
        SET @iRet = 5
        GOTO cleanup
    END
    DECLARE @ListDirDirName  nvarchar(256)
    DECLARE @ListDirLeafName nvarchar(128)
    DECLARE @Type            tinyint
    EXEC proc_SplitUrl
        @DirName,
        @ListDirDirName OUTPUT,
        @ListDirLeafName OUTPUT
    SELECT
        @Type = Type,
        @ListDirDirName = DirName,
        @ListDirLeafName = LeafName,
        @ParentId = Id,
        @ScopeId = ScopeId
    FROM 
        Docs 
    WHERE 
        SiteId   = @SiteId AND
        LeafName = @ListDirLeafName AND
        DirName  =  @ListDirDirName
    IF @@ROWCOUNT = 0    
    BEGIN
        DECLARE @iSlash int
        DECLARE @WebFullUrl             nvarchar(260)
        DECLARE @DirToCreateFullUrl     nvarchar(260)
        SELECT 
            @WebFullUrl=FullUrl
        FROM 
            Webs
        WHERE
            Id = @WebId
        SET @iSlash = LEN(@WebFullUrl) + 1
        WHILE @iSlash <> 0
        BEGIN
            SET @iSlash = CHARINDEX(N'/',
                @DirName COLLATE Latin1_General_BIN,
                @iSlash + 1)
            IF @iSlash <> 0
                SET @DirToCreateFullUrl = LEFT(@DirName, @iSlash - 1)
            ELSE
                SET @DirToCreateFullUrl = @DirName
            EXEC proc_spliturl @DirToCreateFullUrl, 
                @ListDirDirName OUTPUT, @ListDirLeafName OUTPUT
            SELECT 
                @type = type 
            FROM 
                Docs 
            WHERE 
                SiteId   = @SiteId AND
                LeafName = @ListDirLeafName AND
                DirName  = @ListDirDirName
            IF @@ROWCOUNT = 0    
            BEGIN
                SET @ParentId = NULL
                DECLARE @Flags int
                SET @Flags =
                    8 |
                    16
                EXEC @iRet = proc_CreateDir 
                    @SiteId, 
                    @WebId, 
                    @ListDirDirName OUTPUT,
                    @ListDirLeafName OUTPUT,
                    1,
                    0,
                    0,
                    @Flags, 
                    NULL,   
                    @ParentId OUTPUT,
                    @ScopeId OUTPUT,
                    NULL    
                IF @iRet <> 0
                BEGIN
                    GOTO cleanup
                END
            END
            ELSE IF 1 <> @type
            BEGIN
                SET @iRet = 5
                GOTO cleanup
            END
        END
    END
    ELSE IF 1 <> @type AND 2 <> @type
    BEGIN
        SET @iRet = 5
        GOTO cleanup
    END
    SET @iRet = 0
cleanup:
    IF (@iRet <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED
    IF @iRet = 0
        SET @DirName = CASE WHEN (DATALENGTH(@ListDirDirName) = 0) THEN @ListDirLeafName WHEN (DATALENGTH(@ListDirLeafName) = 0) THEN @ListDirDirName ELSE @ListDirDirName + N'/' + @ListDirLeafName END
    RETURN @iRet

GO
