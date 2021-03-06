/****** Object:  StoredProcedure [dbo].[proc_CheckoutDocumentInternal]    Script Date: 5/15/2018 12:12:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CheckoutDocumentInternal(
    @SiteId uniqueidentifier,
    @WebId  uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @Level tinyint,
    @EnableMinorVersions bit,
    @IsModerated bit,
    @UserId int,
    @CheckoutTimeout int,
    @RefreshCheckout bit,
    @CheckoutToLocal bit,
    @IsForceCheckout bit,
    @Now datetime)
AS
    SET NOCOUNT ON
    DECLARE @RowsUpdated int
    DECLARE @iRet int
    DECLARE @DocId uniqueidentifier
    DECLARE @ListId uniqueidentifier
    DECLARE @ItemId int
    SET @iRet = 0
    IF @CheckoutTimeout IS NULL
    BEGIN
        DECLARE @quotaOrLockStatus int
        SELECT  @quotaOrLockStatus = dbo.fn_IsOverQuotaOrWriteLocked(@SiteId)
        IF (@quotaOrLockStatus = 1)
        BEGIN
            RETURN 1816
        END
        ELSE IF (@quotaOrLockStatus > 1)
        BEGIN
            RETURN 212
        END
    END
    BEGIN TRANSACTION
    SELECT 
            @DocId = Id,
            @ItemId = DoclibRowId,
            @ListId = ListId
        FROM
            Docs WITH(NOLOCK)
        WHERE
            Docs.SiteId = @SiteId AND
            Docs.DirName = @DirName AND
            Docs.LeafName = @LeafName
    IF @ListId IS NOT NULL
    SELECT 
    @ListId = tp_ID
    FROM Lists WITH(XLOCK)
    WHERE  tp_WebId = @WebId AND tp_ID = @ListId
    SELECT 
            @DocId = Id,
            @ItemId = DoclibRowId,
            @ListId = ListId
        FROM
            Docs WITH(XLOCK)
        WHERE
            Docs.SiteId = @SiteId AND
            Docs.DirName = @DirName AND
            Docs.LeafName = @LeafName
    UPDATE
        Docs
    SET
        DocFlags = CASE WHEN @CheckoutTimeout IS NULL AND @CheckoutToLocal = 1
            THEN DocFlags | 32 | 512
            WHEN @CheckoutTimeout IS NULL AND @CheckoutToLocal = 0
            THEN (DocFlags | 32) & ~512
            ELSE DocFlags
            END,
        CheckoutUserId = @UserId,
        CheckoutDate = CASE WHEN CheckoutDate IS NULL
            THEN @Now
            WHEN @CheckoutTimeout IS NOT NULL
            THEN CheckoutDate
            ELSE @Now
            END,
        CheckoutExpires = ISNULL(DATEADD(mi, @CheckoutTimeout, @Now),
            CheckoutExpires),       
        VersionCreatedSinceSTCheckout = CASE
            WHEN @CheckoutTimeout IS NOT NULL AND
                @RefreshCheckout = 0
            THEN 0
            ELSE VersionCreatedSinceSTCheckout
            END,
        MetaInfoTimeLastModified = @Now
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        WebId = @WebId AND
        Level = @Level AND
        IsCurrentVersion = 1 AND
        Type = 0 AND
        (@EnableMinorVersions = 0 OR
             UIVersion%512 < 512 - 1) AND
        (
            ( 
            @RefreshCheckout = 0 AND
                ( 
                (CheckoutDate IS NULL AND 
                (@IsForceCheckout = 0 OR
                 @CheckoutTimeout IS NULL)) OR
                ( 
                    CheckoutExpires IS NOT NULL AND
                    CheckoutExpires <= @Now AND
                    LTCheckoutUserId IS NULL AND 
                    (@IsForceCheckout = 0 OR 
                     @CheckoutTimeout IS NULL)) OR
                ( 
                    @CheckoutTimeout IS NULL AND
                    CheckoutExpires IS NOT NULL AND
                    @Now < CheckoutExpires AND
                    LTCheckoutUserId IS NULL AND
                    CheckoutUserId = @UserId) OR
                ( 
                    @CheckoutTimeout IS NOT NULL AND
                    (CheckoutExpires IS NULL OR
                        CheckoutExpires <= @Now) AND
                    LTCheckoutUserId IS NOT NULL AND
                    LTCheckoutUserId = @UserId) OR
                ( 
                    @CheckoutToLocal = 1 AND
                    @CheckoutTimeout IS NULL AND
                    LTCheckoutUserId IS NOT NULL AND
                    LTCheckoutUserId = @UserId AND
                    DocFlags & 512 = 0) OR
                ( 
                    @CheckoutToLocal = 0 AND
                    @CheckoutTimeout IS NULL AND
                    LTCheckoutUserId IS NOT NULL AND
                    LTCheckoutUserId = @UserId AND
                    DocFlags & 512 = 512)
                )
            ) OR
            ( 
            @RefreshCheckout = 1 AND 
            @CheckoutTimeout IS NOT NULL AND 
            CheckoutExpires IS NOT NULL AND 
            CheckoutDate IS NOT NULL AND 
            CheckoutUserId = @UserId AND 
            (@IsForceCheckout = 0 OR LTCheckoutUserId = @UserId)
            )
        )
    SET @RowsUpdated = @@ROWCOUNT
    IF @RowsUpdated = 1 AND @CheckoutTimeout IS NULL  
    BEGIN
        UPDATE
            Docs
        SET
            DocFlags = CASE WHEN @CheckoutToLocal = 1
            THEN DocFlags | 32 | 512
            ELSE (DocFlags | 32) & ~512
            END,               
            CheckoutUserId = @UserId,
            CheckoutDate = @Now,
            MetaInfoTimeLastModified = @Now
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName AND
            WebId = @WebId AND
            Level < @Level
        IF @Level <> 255
        BEGIN
            EXEC @iRet = proc_CloneDoc  @SiteId, @DirName, @LeafName, NULL, NULL,
                 NULL, @Level, 255, @EnableMinorVersions, @IsModerated, @UserId, NULL
            IF @iRet <> 0
                GOTO cleanup
        END   
        DECLARE @ObjectType int
        DECLARE @FullUrl nvarchar(260)
        SET @FullUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END        
        IF (@ItemId IS NULL)
        BEGIN
            SET @ListId = NULL
            SET @ObjectType = 16
        END
        ELSE
        BEGIN
            SET @ObjectType = 1
        END
        EXEC proc_LogChange @SiteId, @WebId, @ListId, @ItemId, @DocId,
            NULL, NULL, @FullUrl, 8192,
            @ObjectType, @Now
        EXEC proc_DTClearRelationshipFromChild @SiteId, @DirName, @LeafName
    END
cleanup:  
    IF ( @RowsUpdated <> 0  AND (0 <> @@ERROR OR @iRet <> 0))
        ROLLBACK TRAN 
    ELSE 
        COMMIT TRAN
    IF @RowsUpdated <> 1
    BEGIN
        DECLARE @FileExists bit
        DECLARE @FileType tinyint
        DECLARE @UIVersion int
        DECLARE @IsCurrentVersion bit
        SELECT
            @FileExists = 1,
            @FileType = Type,
            @UIVersion = UIVersion,
            @IsCurrentVersion = IsCurrentVersion
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            WebId = @WebId AND
            DirName = @DirName AND
            LeafName = @LeafName AND 
            Level = @Level
        IF @FileExists IS NULL
            RETURN 3
        IF @IsCurrentVersion = 0
            RETURN 33
        IF @FileType <> 0
            RETURN 1630
        IF @IsForceCheckout = 1 AND @Level <> 255
            RETURN 158
        IF @EnableMinorVersions = 1 AND @UIVersion%512 >= 512 - 1
            RETURN 154
        RETURN 33
    END    
    RETURN @iRet

GO
