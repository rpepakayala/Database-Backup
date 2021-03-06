/****** Object:  StoredProcedure [dbo].[proc_UncheckoutDocumentInternal]    Script Date: 5/15/2018 12:13:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UncheckoutDocumentInternal(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @UserId int,
    @ShortTerm bit,
    @Force bit,
    @CheckinVersionLevel tinyint,
    @Level tinyint OUTPUT
    )
AS
    SET NOCOUNT ON
    DECLARE @Now datetime
    DECLARE @Version int
    DECLARE @UserIdForLevel int
    DECLARE @ListId uniqueidentifier
    DECLARE @ItemId int
    DECLARE @ParentId uniqueidentifier
    DECLARE @CheckoutExpires datetime
    DECLARE @DocId uniqueidentifier
    DECLARE @FullUrl nvarchar(260)
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
    IF @ShortTerm = 0
    BEGIN
        SELECT 
            @Version = Version,
            @ListId = ListId,
            @ItemId = DoclibRowId,
            @CheckoutExpires = CheckoutExpires,
            @DocId = Id,
            @ParentId = ParentId
        FROM
            Docs WITH (UPDLOCK)
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName AND
            WebId = @WebId AND
            Level = 255
        IF @@ROWCOUNT = 0
        BEGIN
            COMMIT TRANSACTION
            RETURN 158
        END
        ELSE IF @Level <> 255
        BEGIN
            COMMIT TRANSACTION
            RETURN 173
        END
        DELETE  FROM
            Docs
        WHERE
            Docs.SiteId = @SiteId AND
            Docs.DirName = @DirName AND
            Docs.LeafName = @LeafName AND 
            Docs.Level = 255
        DELETE  FROM
            DocStreams
        WHERE
            DocStreams.SiteId = @SiteId AND
            DocStreams.ParentId = @ParentId AND
            DocStreams.Id = @DocId AND 
            DocStreams.Level = 255
        IF (@ListId IS NOT NULL AND @ItemId IS NOT NULL)
        BEGIN
            SELECT 
                @ListId = tp_ListID
            FROM
                UserData WITH (XLOCK)                
            WHERE
                tp_ListId = @ListId AND
                tp_Id = @ItemId AND
                tp_SiteId = @SiteId AND
                tp_DirName =  @DirName AND
                tp_LeafName = @LeafName 
            DELETE FROM 
                UserData
            WHERE
                tp_ListId = @ListId AND
                tp_Id = @ItemId AND
                tp_Level = 255
            DELETE FROM
                UserDataJunctions
            WHERE
                tp_SiteId = @SiteId AND
                tp_DirName = @DirName AND
                tp_LeafName = @LeafName AND
                tp_Level = 255
            EXEC proc_DeleteFromNVP @SiteId, @ListId, @ItemId, 255
        END
        DELETE FROM
            Links
        WHERE
            SiteId = @SiteID AND
            DirName = @DirName AND
            LeafName = @LeafName AND
            Level = 255
        SET @FullUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END
        DELETE FROM 
            Deps
        WHERE 
            SiteId = @SiteID AND
            DeleteTransactionId = 0x AND
            FullUrl = @FullUrl AND
            Level = 255    
        EXEC proc_ApproveCheckinForWebPart @SiteID,
            @DocId,
            255,
            @CheckinVersionLevel,
            1 
        SET @Level = @CheckinVersionLevel
        UPDATE 
            UserData
        Set
            tp_CheckoutUserId = NULL,
            tp_IsCurrent =  CASE
                WHEN (tp_Level = @CheckinVersionLevel)
                THEN 1
                ELSE 0
                END
        WHERE
            tp_ListId = @ListId AND
            tp_Id = @ItemId AND
            tp_Level <= @CheckinVersionLevel
        UPDATE
            NameValuePair
        SET
            Value = NULL
        WHERE
            SiteId = @SiteID AND
            ListId = @ListId AND
            FieldId = '{3881510a-4e4a-4ee8-b102-8ee8e2d0dd4b}' AND
            ItemId = @ItemId AND
            Level <= @CheckinVersionLevel
    END
    SET @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    UPDATE
        Docs
    SET
        CheckoutUserId = CASE
            WHEN (@ShortTerm = 0 AND @CheckoutExpires IS NULL) OR
                (@ShortTerm = 1 AND LTCheckoutUserId IS NULL)
            THEN NULL
            ELSE CheckoutUserId
            END,
        CheckoutDate = CASE
            WHEN (@ShortTerm = 0 AND @CheckoutExpires IS NULL) OR
                (@ShortTerm = 1 AND LTCheckoutUserId IS NULL)
            THEN NULL
            ELSE CheckoutDate
            END,
        CheckoutExpires = @CheckoutExpires,
        DocFlags = CASE
            WHEN @ShortTerm = 0
            THEN DocFlags & ~32 & ~512
            ELSE DocFlags
            END,        
        Version = CASE
            WHEN @ShortTerm = 0
            THEN @Version + 1
            ELSE Version
            END,      
        IsCurrentVersion = 1          
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        Level = @Level AND  
        WebId = @WebId AND
        (CheckoutUserId = @UserId OR
            @Force = 1) AND
        CheckoutDate IS NOT NULL AND
        ((CheckoutExpires IS NOT NULL AND @ShortTerm = 1 AND
            @Now < CheckoutExpires) OR
        (LTCheckoutUserId IS NOT NULL AND @ShortTerm = 0))
    IF @@ROWCOUNT <> 1
    BEGIN
        DECLARE @FileExists bit
        DECLARE @CheckoutDate datetime
        DECLARE @CheckoutUserId int
        DECLARE @LTCheckout bit
        SELECT
            @FileExists = 1,
            @CheckoutDate = CheckoutDate,
            @CheckoutExpires = CheckoutExpires,
            @LTCheckout = CASE
                WHEN LTCheckoutUserId IS NULL
                THEN 0
                ELSE 1
                END,
            @CheckoutUserId = CheckoutUserId
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName AND
            WebId = @WebId
        COMMIT TRANSACTION
        IF @FileExists IS NULL
            RETURN 3
        IF @CheckoutDate IS NULL
            RETURN 158
        IF @CheckoutUserId = @UserId AND
            @CheckoutExpires IS NULL AND
            @ShortTerm = 1
            RETURN 158
        IF @CheckoutUserId = @UserId AND
            @LTCheckout = 0 AND
            @ShortTerm = 0
            RETURN 158
        RETURN 173
    END
    IF (@ShortTerm = 0 AND @Level = 2)
    BEGIN
        UPDATE
            Docs
        SET
            CheckoutUserId = NULL,
            CheckoutDate = NULL,
            CheckoutExpires = @CheckoutExpires,
            DocFlags = DocFlags & ~32 & ~512,                        
            Version = Version + 1                   
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName AND
            Level = 1
    END
    IF (@ShortTerm = 0)
    BEGIN
        DECLARE @ObjectType int
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
            NULL, NULL, @FullUrl, 1048576,
            @ObjectType, @Now
    END
    ELSE 
    BEGIN
    UPDATE
        Docs
    SET
        CheckoutUserId = LTCheckoutUserId,
        CheckoutDate = CASE
            WHEN (LTCheckoutUserId IS NULL)
            THEN NULL
            ELSE CheckoutDate
            END,
        CheckoutExpires = NULL            
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        Level < @Level     
    END
    COMMIT TRANSACTION
    RETURN 0

GO
