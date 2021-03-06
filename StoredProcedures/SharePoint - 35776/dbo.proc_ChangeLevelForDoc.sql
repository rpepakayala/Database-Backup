/****** Object:  StoredProcedure [dbo].[proc_ChangeLevelForDoc]    Script Date: 5/15/2018 12:11:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ChangeLevelForDoc(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),    
    @Level tinyint OUTPUT, 
    @NewLevel tinyint, 
    @ModerationStatus int,
    @EnableMinorVersions bit,
    @Moderated bit,
    @CreateVersion bit,
    @UserId int,
    @Comment nvarchar(1023),
    @bUpdateModified bit,
    @@DoclibRowId int OUTPUT,
    @@DocUIVersion int OUTPUT,
    @@DocFlagsOut int OUTPUT
    )
AS
    DECLARE @Now datetime
    DECLARE @DocWebId uniqueidentifier
    DECLARE @DocId uniqueIdentifier
    SET @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    DECLARE @FullUrl nvarchar(260)
    SET @FullUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END
    DECLARE @ListId uniqueidentifier
    DECLARE @ItemId int
    DECLARE @CheckinItem bit
    IF (@Level = 255 AND @NewLevel = 1)
    BEGIN
        SET @CheckinItem = 1
    END
    ELSE
    BEGIN
        SET @CheckinItem = 0
    END
    IF @Moderated = 0 AND @EnableMinorVersions = 0 AND @CheckinItem = 0
        return 0
    SELECT
        @DocWebId = WebId,
        @ListId = ListId,
        @ItemId = DocLibRowId
    FROM
        Docs WITH (NOLOCK)
    WHERE
        SiteId = @SiteId AND 
        DirName = @DirName AND
        LeafName = @LeafName AND
        Level = @Level
    IF @ListId IS NOT NULL
    BEGIN
    SELECT
        @ListId  = Lists.tp_Id
    FROM
        Lists WITH(XLOCK)
    WHERE
        Lists.tp_WebId = @DocWebId AND
        Lists.tp_Id = @ListId        
    END
    SELECT
        @DocWebId = WebId,
        @ListId = ListId,
        @ItemId = DocLibRowId
    FROM
        Docs WITH(XLOCK)
    WHERE
        SiteId = @SiteId AND 
        DirName = @DirName AND
        LeafName = @LeafName AND
        Level = @Level AND
        IsCurrentVersion = 1
    IF @@ROWCOUNT <> 1
        RETURN 87
    IF (@Level = 1 AND @NewLevel = 2)
    BEGIN
        EXEC proc_DenyDoc @SiteId,
            @DirName,
            @LeafName,
            @Level OUTPUT,
            @UserId,
            @EnableMinorVersions,
            @Moderated,
            @ModerationStatus
    END
    ELSE IF ((@Level = 2 AND @NewLevel = 1) OR @CheckinItem = 1)
         EXEC proc_ApproveCheckinDoc
                @SiteId,
                @DirName,
                @LeafName,    
                @Level OUTPUT, 
                @NewLevel, 
                @EnableMinorVersions,
                @CreateVersion
    UPDATE 
        Docs
    SET
        CheckinComment = @Comment,
        TimeLastModified = CASE
                WHEN (@bUpdateModified = 1) THEN @Now ELSE
                TimeLastModified END,
        MetaInfoTimeLastModified = CASE
                WHEN (@bUpdateModified = 1) THEN @Now ELSE
                MetaInfoTimeLastModified END,
        TimeLastWritten = CASE 
                WHEN (@bUpdateModified = 1) THEN @Now ELSE
                TimeLastWritten END,       
        UIVersion =  
        CASE WHEN @EnableMinorVersions = 0 AND UIVersion%512 <> 0
        THEN (UIVersion/512+1)*512
        WHEN @EnableMinorVersions = 1 AND UIVersion%512 = 0 AND
            @Level <> 1
        THEN UIVersion+1
        ELSE UIVersion
        END,                                 
        CheckoutUserId = 
            CASE WHEN @CheckinItem = 1
            THEN NULL
            ELSE CheckOutUserId
            END,
        CheckoutDate = 
            CASE WHEN @CheckinItem = 1
            THEN NULL
            ELSE CheckoutDate
            END,
        CheckoutExpires = 
            CASE WHEN @CheckinItem = 1
            THEN NULL
            ELSE CheckoutExpires
            END
    WHERE
        SiteId = @SiteId AND 
        DirName = @DirName AND
        LeafName = @LeafName AND
        Level = @Level  
    SELECT
        @@DocFlagsOut = DocFlags,
        @@DocUIVersion = UIVersion,       
        @@DoclibRowId = DoclibRowId,
        @DocWebId = WebId,
        @DocId = Id,
        @ListId = ListId,
        @ItemId = DocLibRowId
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND 
        DirName = @DirName AND
        LeafName = @LeafName AND
        Level = @Level
    UPDATE
        UserData
    SET
        tp_UIVersion = @@DocUIVersion,
        tp_ModerationStatus = @ModerationStatus,
        tp_Editor = CASE 
            WHEN (@bUpdateModified = 1) THEN @UserId ELSE
            tp_Editor END,
        tp_CheckoutUserId = 
            CASE WHEN @CheckinItem = 1
            THEN NULL
            ELSE tp_CheckOutUserId END
    WHERE
        tp_SiteId = @SiteId AND 
        tp_DirName = @DirName AND
        tp_LeafName = @LeafName AND
        tp_Level = @Level
    EXEC proc_UpdateItemInNameValuePairByUrl
        @SiteId, @DirName, @LeafName, @Level,
        '{3881510a-4e4a-4ee8-b102-8ee8e2d0dd4b}', NULL,
        '{7841bf41-43d0-4434-9f50-a673baef7631}', NULL,
        '{d31655d1-1d5b-4511-95a1-7a09e9b75bf2}', NULL,
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        NULL, NULL, NULL, NULL, NULL, NULL,
        1
    IF @@DoclibRowId IS NULL
    BEGIN
        EXEC proc_LogChange @SiteId, @DocWebId, NULL, NULL, @DocId,
            NULL, NULL, @FullUrl, 8192,
            16, @Now
    END

GO
