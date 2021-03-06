/****** Object:  StoredProcedure [dbo].[proc_GetContainingListCore]    Script Date: 5/15/2018 12:12:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetContainingListCore(
    @SiteId uniqueidentifier,
    @WebId  uniqueidentifier,
    @Url nvarchar(260),
    @bReturnListMetadata bit,
    @ListId uniqueidentifier OUTPUT,
    @BaseType int = NULL OUTPUT,
    @ExcludedType int = NULL OUTPUT,
    @bLockLists bit = 0,
    @ListFlags bigint = NULL OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    DECLARE @OldDirName nvarchar(256)
    DECLARE @OldLeafName nvarchar(128)
    DECLARE @iRet int
    DECLARE @Type int
    DECLARE @WebIdSelected uniqueidentifier
    DECLARE @DocIdDirectMatch uniqueidentifier
    DECLARE @ItemId int
    SET @iRet = 3
    SET @ListId = NULL
    SET @BaseType = NULL
    SET @ExcludedType = 0x00
    SET @ListFlags = NULL    
    EXEC proc_SplitUrl @Url,
        @DirName OUTPUT,
        @LeafName OUTPUT
    SELECT TOP 1
        @ListId = ListId,
        @Type = Type,
        @WebIdSelected = WebId,
        @ItemId = DocLibRowId,
        @DocIdDirectMatch = Id
    FROM
        Docs WITH(NOLOCK)
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName
    IF @bLockLists = 1 AND @ListId IS NOT NULL
    BEGIN
        SELECT
            @ListId = tp_Id
        FROM
            Lists WITH(UPDLOCK)
        WHERE
            tp_WebId = @WebId AND
            tp_Id = @ListId
    END
    WHILE @Type IS NULL AND LEN(@DirName) > 0
    BEGIN
        EXEC proc_SplitUrl @DirName,
            @DirName OUTPUT,
            @LeafName OUTPUT
        SELECT TOP 1
            @ListId = ListId,
            @Type = Type,
            @WebIdSelected = WebId
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName
    END
    IF @WebIdSelected <> @WebId
    BEGIN
        SET @ListId = NULL
        SET @iRet = 1
        GOTO cleanup
    END
    IF @ListId IS NOT NULL
    BEGIN
        DECLARE @ListDirName nvarchar(256)
        DECLARE @ListLeafName nvarchar(128)
        DECLARE @ListRootFolderId uniqueidentifier
        SELECT
            @BaseType = Lists.tp_Basetype,
            @ListDirName = Docs.DirName,
            @ListLeafName = Docs.LeafName,
            @ListRootFolderId = Lists.tp_RootFolder,
            @ListFlags = Lists.tp_Flags
        FROM
            Lists WITH (NOLOCK) LEFT OUTER JOIN Docs
        ON
            Lists.tp_WebId = @WebId AND
            Lists.tp_RootFolder = Docs.Id
        WHERE
            Lists.tp_WebId = @WebId AND
            Lists.tp_Id = @ListId AND
            Docs.Level = 1
        IF @DocIdDirectMatch = @ListRootFolderId
        BEGIN
            SET @ExcludedType = 0x04
        END
        ELSE IF @BaseType = 1
        BEGIN
            DECLARE @ListFullUrl  nvarchar(260)
            SET @ListFullUrl = CASE WHEN (DATALENGTH(@ListDirName) = 0) THEN @ListLeafName WHEN (DATALENGTH(@ListLeafName) = 0) THEN @ListDirName ELSE @ListDirName + N'/' + @ListLeafName END
            IF @Type = 0
            BEGIN
                EXEC proc_SplitUrl @Url,
                    @OldDirName OUTPUT,
                    @OldLeafName OUTPUT
            END
            ELSE
            BEGIN
                SET @OldDirName = @Url
            END
            WHILE LEN(@OldDirName) > LEN(@ListFullUrl)
            BEGIN
                EXEC proc_SplitUrl @OldDirName,
                    @OldDirName OUTPUT,
                    @OldLeafName OUTPUT
                IF @OldLeafName = N'Forms'
                BEGIN
                    SET @ExcludedType = 0x01
                    BREAK
                END
                IF @OldLeafName = N'_w'
                BEGIN
                    SET @ExcludedType = 0x02
                    BREAK
                END
                IF @OldLeafName = N'_t'
                BEGIN
                    SET @ExcludedType = 0x03
                    BREAK
                END
            END
        END
        ELSE
        BEGIN
            IF @ItemId IS NULL 
                SET @ExcludedType = 0x01       
        END
        SET @iRet = 0
    END
CLEANUP:
    IF @bReturnListMetadata = 1
    BEGIN
        IF @ListId IS NOT NULL
            EXEC proc_GetListMetaData @WebId, @ListId, 0
        ELSE
            SELECT
                NULL
            WHERE
                1 = 0
    END
    RETURN @iRet

GO
