/****** Object:  StoredProcedure [dbo].[proc_AddListItem]    Script Date: 5/15/2018 12:11:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddListItem(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListID uniqueidentifier,
    @RowOrdinal int,
    @ItemId int output,
    @UserId int,
    @Size int,
    @TimeNow datetime,
    @CopySecurityFromMasterID int = NULL,    
    @ExtraItemSize int = NULL,    
    @CheckDiskQuota bit = 1,
    @ItemDocType tinyint = 0,
    @BaseRowItemId int = NULL,
    @DocIdAdded uniqueidentifier = NULL,
    @RetainId uniqueidentifier = NULL,      
    @RetainObjectIdentity bit = 0,          
    @Level tinyint = 1,
    @UIVersion int = 512,
    @ItemCountDelta int = 1,
    @ItemName nvarchar(255) = NULL,
    @UseNvarchar1ItemName bit = 1,
    @ItemDirName nvarchar(256) = NULL OUTPUT,
    @ItemLeafName nvarchar(128) = NULL OUTPUT,
    @ServerTemplate int = NULL,
    @IsNotUserDisplayed bit = NULL,
    @BaseType int = NULL,
    @CheckSchemaVersion int = NULL,
    @OnRestore bit = 0,
    @AddNamespace bit = 0,
    @tp_Ordering varchar(512) = NULL,
    @tp_ThreadIndex varbinary(512) = NULL,
    @tp_HasAttachment bit = NULL,
    @tp_ModerationStatus int = 0,
    @tp_IsCurrent bit = 1,
    @tp_ItemOrder float = NULL,
    @tp_InstanceID int = NULL,
    @tp_GUID uniqueidentifier = NULL,
    @tp_ID int = NULL,
    @tp_Author int = NULL,
    @tp_Editor int = NULL,
    @tp_Modified datetime = NULL,
    @tp_Created datetime = NULL,
    @tp_Version int = 1,
    @tp_ContentType nvarchar(255) = NULL,
    @tp_ContentTypeId tContentTypeId = NULL,
    @tp_CopySource nvarchar(260) = NULL,
    @tp_HasCopyDestinations bit = NULL,
    @tp_WorkflowVersion int = 1,
    @tp_WorkflowInstanceID uniqueidentifier = NULL,
    @nvarchar1 nvarchar(255) = NULL,
    @nvarchar2 nvarchar(255) = NULL,
    @nvarchar3 nvarchar(255) = NULL,
    @nvarchar4 nvarchar(255) = NULL,
    @nvarchar5 nvarchar(255) = NULL,
    @nvarchar6 nvarchar(255) = NULL,
    @nvarchar7 nvarchar(255) = NULL,
    @nvarchar8 nvarchar(255) = NULL,
    @nvarchar9 nvarchar(255) = NULL,
    @nvarchar10 nvarchar(255) = NULL,
    @nvarchar11 nvarchar(255) = NULL,
    @nvarchar12 nvarchar(255) = NULL,
    @nvarchar13 nvarchar(255) = NULL,
    @nvarchar14 nvarchar(255) = NULL,
    @nvarchar15 nvarchar(255) = NULL,
    @nvarchar16 nvarchar(255) = NULL,
    @nvarchar17 nvarchar(255) = NULL,
    @nvarchar18 nvarchar(255) = NULL,
    @nvarchar19 nvarchar(255) = NULL,
    @nvarchar20 nvarchar(255) = NULL,
    @nvarchar21 nvarchar(255) = NULL,
    @nvarchar22 nvarchar(255) = NULL,
    @nvarchar23 nvarchar(255) = NULL,
    @nvarchar24 nvarchar(255) = NULL,
    @nvarchar25 nvarchar(255) = NULL,
    @nvarchar26 nvarchar(255) = NULL,
    @nvarchar27 nvarchar(255) = NULL,
    @nvarchar28 nvarchar(255) = NULL,
    @nvarchar29 nvarchar(255) = NULL,
    @nvarchar30 nvarchar(255) = NULL,
    @nvarchar31 nvarchar(255) = NULL,
    @nvarchar32 nvarchar(255) = NULL,
    @nvarchar33 nvarchar(255) = NULL,
    @nvarchar34 nvarchar(255) = NULL,
    @nvarchar35 nvarchar(255) = NULL,
    @nvarchar36 nvarchar(255) = NULL,
    @nvarchar37 nvarchar(255) = NULL,
    @nvarchar38 nvarchar(255) = NULL,
    @nvarchar39 nvarchar(255) = NULL,
    @nvarchar40 nvarchar(255) = NULL,
    @nvarchar41 nvarchar(255) = NULL,
    @nvarchar42 nvarchar(255) = NULL,
    @nvarchar43 nvarchar(255) = NULL,
    @nvarchar44 nvarchar(255) = NULL,
    @nvarchar45 nvarchar(255) = NULL,
    @nvarchar46 nvarchar(255) = NULL,
    @nvarchar47 nvarchar(255) = NULL,
    @nvarchar48 nvarchar(255) = NULL,
    @nvarchar49 nvarchar(255) = NULL,
    @nvarchar50 nvarchar(255) = NULL,
    @nvarchar51 nvarchar(255) = NULL,
    @nvarchar52 nvarchar(255) = NULL,
    @nvarchar53 nvarchar(255) = NULL,
    @nvarchar54 nvarchar(255) = NULL,
    @nvarchar55 nvarchar(255) = NULL,
    @nvarchar56 nvarchar(255) = NULL,
    @nvarchar57 nvarchar(255) = NULL,
    @nvarchar58 nvarchar(255) = NULL,
    @nvarchar59 nvarchar(255) = NULL,
    @nvarchar60 nvarchar(255) = NULL,
    @nvarchar61 nvarchar(255) = NULL,
    @nvarchar62 nvarchar(255) = NULL,
    @nvarchar63 nvarchar(255) = NULL,
    @nvarchar64 nvarchar(255) = NULL,
    @int1 int = NULL,
    @int2 int = NULL,
    @int3 int = NULL,
    @int4 int = NULL,
    @int5 int = NULL,
    @int6 int = NULL,
    @int7 int = NULL,
    @int8 int = NULL,
    @int9 int = NULL,
    @int10 int = NULL,
    @int11 int = NULL,
    @int12 int = NULL,
    @int13 int = NULL,
    @int14 int = NULL,
    @int15 int = NULL,
    @int16 int = NULL,
    @float1 float = NULL,
    @float2 float = NULL,
    @float3 float = NULL,
    @float4 float = NULL,
    @float5 float = NULL,
    @float6 float = NULL,
    @float7 float = NULL,
    @float8 float = NULL,
    @float9 float = NULL,
    @float10 float = NULL,
    @float11 float = NULL,
    @float12 float = NULL,
    @datetime1 datetime = NULL,
    @datetime2 datetime = NULL,
    @datetime3 datetime = NULL,
    @datetime4 datetime = NULL,
    @datetime5 datetime = NULL,
    @datetime6 datetime = NULL,
    @datetime7 datetime = NULL,
    @datetime8 datetime = NULL,
    @bit1 bit = NULL,
    @bit2 bit = NULL,
    @bit3 bit = NULL,
    @bit4 bit = NULL,
    @bit5 bit = NULL,
    @bit6 bit = NULL,
    @bit7 bit = NULL,
    @bit8 bit = NULL,
    @bit9 bit = NULL,
    @bit10 bit = NULL,
    @bit11 bit = NULL,
    @bit12 bit = NULL,
    @bit13 bit = NULL,
    @bit14 bit = NULL,
    @bit15 bit = NULL,
    @bit16 bit = NULL,
    @uniqueidentifier1 uniqueidentifier = NULL,
    @ntext1 ntext = NULL,
    @ntext2 ntext = NULL,
    @ntext3 ntext = NULL,
    @ntext4 ntext = NULL,
    @ntext5 ntext = NULL,
    @ntext6 ntext = NULL,
    @ntext7 ntext = NULL,
    @ntext8 ntext = NULL,
    @ntext9 ntext = NULL,
    @ntext10 ntext = NULL,
    @ntext11 ntext = NULL,
    @ntext12 ntext = NULL,
    @ntext13 ntext = NULL,
    @ntext14 ntext = NULL,
    @ntext15 ntext = NULL,
    @ntext16 ntext = NULL,
    @ntext17 ntext = NULL,
    @ntext18 ntext = NULL,
    @ntext19 ntext = NULL,
    @ntext20 ntext = NULL,
    @ntext21 ntext = NULL,
    @ntext22 ntext = NULL,
    @ntext23 ntext = NULL,
    @ntext24 ntext = NULL,
    @ntext25 ntext = NULL,
    @ntext26 ntext = NULL,
    @ntext27 ntext = NULL,
    @ntext28 ntext = NULL,
    @ntext29 ntext = NULL,
    @ntext30 ntext = NULL,
    @ntext31 ntext = NULL,
    @ntext32 ntext = NULL,
    @sql_variant1 sql_variant = NULL,
    @error_sql_variant1 int = 0,
    @sql_variant2 sql_variant = NULL,
    @error_sql_variant2 int = 0,
    @sql_variant3 sql_variant = NULL,
    @error_sql_variant3 int = 0,
    @sql_variant4 sql_variant = NULL,
    @error_sql_variant4 int = 0,
    @sql_variant5 sql_variant = NULL,
    @error_sql_variant5 int = 0,
    @sql_variant6 sql_variant = NULL,
    @error_sql_variant6 int = 0,
    @sql_variant7 sql_variant = NULL,
    @error_sql_variant7 int = 0,
    @sql_variant8 sql_variant = NULL,
    @error_sql_variant8 int = 0,
    @eventData image = NULL,
    @acl image = NULL)
AS
    SET NOCOUNT ON
    DECLARE @ReturnCode int
    SET @ReturnCode = 0
    DECLARE @CurVersion int
    DECLARE @ListDirName nvarchar(256)
    DECLARE @ListLeafName nvarchar(128) 
    DECLARE @ListFullUrl nvarchar(260)
    DECLARE @ItemFullUrl nvarchar(260)
    DECLARE @DocId uniqueidentifier
    DECLARE @DraftOwnerId int
    DECLARE @ItemLeafNameSpecified bit
    DECLARE @AddMinorVersion bit
    DECLARE @CheckoutUserId int
    DECLARE @DocSize int
    SET @DocSize = 152
    IF @ExtraItemSize IS NOT NULL
    BEGIN
        SELECT @Size = @Size + @ExtraItemSize
    END
    SELECT 
        @CurVersion = Lists.tp_Version,
        @ListDirName = Docs.DirName,
        @ListLeafName = Docs.LeafName,
        @ListFullUrl = CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
    FROM 
        Lists WITH (UPDLOCK) INNER JOIN Docs
    ON
        Docs.SiteId = @SiteId AND
        Docs.ListId = Lists.tp_Id AND
        Docs.Id = Lists.tp_RootFolder
    WHERE
        Lists.tp_WebId = @WebId AND
        Lists.tp_ID = @ListId
    BEGIN
        IF  @CurVersion <> ISNULL(@CheckSchemaVersion, @CurVersion)
        BEGIN
            RETURN 1638
        END
    END  
    IF (@Size <> 0)
    BEGIN
        DECLARE @quotaOrLockStatus int
        SELECT  @quotaOrLockStatus = dbo.fn_IsOverQuotaOrWriteLocked(@SiteId)
        IF (@quotaOrLockStatus = 1 AND @CheckDiskQuota = 1)
        BEGIN
            RETURN 1816
        END
        ELSE IF (@quotaOrLockStatus > 1)
        BEGIN
            RETURN 212
        END
    END
    DECLARE @UserTitle nvarchar(255)
    IF (@IsNotUserDisplayed = 1)
    BEGIN
        SET @UserTitle = N'***'
    END
    ELSE
    BEGIN
        SELECT
            @UserTitle = tp_Title
        FROM
            UserInfo
        WHERE
            tp_SiteID = @SiteID AND 
            tp_ID = ISNULL(@tp_Author, @UserID)
    END
    IF @Level = 2
        SET @DraftOwnerId = ISNULL(@tp_Author, @UserID)
    ELSE
        SET @DraftOwnerId = NULL
    IF @Level = 255
        SET @CheckoutUserId =  ISNULL(@tp_Author, @UserID)
    ELSE
        SET @CheckoutUserId = NULL
    IF @tp_ID IS NOT NULL
        SET @ItemId = @tp_ID
    IF @BaseRowItemId IS NOT NULL
        SET @ItemId = @BaseRowItemId
    IF @ItemId IS NULL
        EXEC @ItemId = proc_GenerateNextId @WebId, @ListID
    IF @ItemDirName IS NULL
        SET @ItemDirName = @ListFullUrl
    IF @ItemLeafName IS NULL
    BEGIN
        SET @ItemLeafName = CAST(@ItemId AS nvarchar(128)) +
                             N'_.000'
        SET @ItemLeafNameSpecified = 0
    END
    ELSE
    BEGIN
        SET @ItemLeafNameSpecified = 1
    END
    IF @tp_ItemOrder IS NULL
    BEGIN
        EXEC proc_GetTargetOrderNumber 
            @SiteID,
            @WebId,
            @ListID,
            @BaseType,
            @ItemId,
            NULL, 
            @tp_ItemOrder OUTPUT,
            1     
    END
    DECLARE @DTM datetime
    SELECT @DTM = dbo.fn_RoundDateToNearestSecond(@TimeNow)
    IF (@RowOrdinal <> 0)
    BEGIN
        SELECT
            @tp_GUID = tp_GUID
        FROM
            Userdata
        WHERE
            tp_SiteID = @SiteID AND 
            tp_ListId  =  @ListId AND
            tp_ID =  @ItemId AND
            tp_RowOrdinal = 0
    END
    DECLARE @DocParentId uniqueidentifier
    DECLARE @ScopeId uniqueidentifier
    DECLARE @DocFlags int
    EXEC @ReturnCode = proc_CanonicalDirNameFromUserInput
        @SiteId,
        @WebId,
        @ItemDirName OUTPUT,
        @DocParentId OUTPUT,
        @ScopeId OUTPUT
    IF 0 <> @ReturnCode
    BEGIN
        RETURN @ReturnCode
    END
    IF @ItemLeafNameSpecified = 0
    BEGIN
        EXEC @ReturnCode = proc_GetUniqueFileName
            @SiteId,
            @ItemDirName,
            @ItemLeafName OUTPUT
        IF 0 <> @ReturnCode
        BEGIN
            RETURN @ReturnCode
        END
    END
    IF @ItemLeafName = NULL
       RETURN 87
    IF @AddNamespace = 1 AND @RowOrdinal = 0 AND NOT
       (@BaseType = 1 AND
        @ItemDocType = 0 AND
        @ItemLeafNameSpecified = 1)
    BEGIN
        IF @RetainObjectIdentity = 1
        BEGIN
            SET @DocId = @RetainId
        END
        ELSE
        BEGIN
            SET @DocId = NEWID()
        END
        SET @DocIdAdded = @DocId
        IF @ItemDocType = 0
        BEGIN
           DECLARE @DummyTextptr varbinary(16)
           DECLARE @UIVersionForAddDocument int
           SET @UIVersionForAddDocument =
               COALESCE(@UIVersion, 512)
           SET @DocFlags = 2048
           EXEC @ReturnCode = proc_AddDocument
               @SiteId,
               @WebId,
               @UserId,
               NULL, 
               @ItemDirName,
               @ItemLeafName,
               @Level,
               @UIVersionForAddDocument,
               @DocId,
               @ListId,
               @ItemId,
               NULL,
               NULL,
               0,
               0,
               0,
               0,
               @DocFlags,
               @DTM,
               @DTM,
               0,
               0,
               0,
               0,
               0,
               NULL,
               NULL,
               NULL,
               NULL,
               NULL,
               NULL,
               NULL,
               NULL,
               @DTM OUTPUT,
               1, 
               0,
               @DummyTextptr OUTPUT
        END
        ELSE
        BEGIN
            DECLARE @DirCreateFlags int
            SET @DirCreateFlags = 16 |
                    8
            SET @DocFlags =
                CASE WHEN @BaseType = 1
                THEN 0
                ELSE 2048
                END
            IF @UIVersion = 1
                SET @AddMinorVersion = 1
            ELSE
                SET @AddMinorVersion = 0
            DECLARE @DocAuthor int
            SET @DocAuthor  = ISNULL(@tp_Author, @UserId)
            EXEC @ReturnCode = proc_CreateDir
                @SiteId,
                @WebId,
                @ItemDirName OUTPUT,
                @ItemLeafName OUTPUT,
                @Level,
                @AddMinorVersion,
                @DocFlags,
                @DirCreateFlags,
                @DocAuthor,
                @DocId OUTPUT,
                @ScopeId OUTPUT,
                @ItemId
        END
        IF @ReturnCode <> 0
            RETURN @ReturnCode
    END
    ELSE
    BEGIN
        SELECT
            @UIVersion = UIVersion,
            @DocSize = @DocSize + Size +MetaInfoSize
        FROM
            Docs
        WHERE
            SiteId   = @SiteId AND
            DirName  =  @ItemDirName AND
            LeafName = @ItemLeafName AND
            Level    = @Level
    END
    SET @ItemFullUrl = CASE WHEN (DATALENGTH(@ItemDirName) = 0) THEN @ItemLeafName WHEN (DATALENGTH(@ItemLeafName) = 0) THEN @ItemDirName ELSE @ItemDirName + N'/' + @ItemLeafName END
    INSERT INTO AllUserData(
        tp_ID,
        tp_Level,
        tp_GUID,
        tp_ListId,
        tp_SiteId,
        tp_RowOrdinal,
        tp_Version,
        tp_Author,
        tp_Editor,
        tp_Created,
        tp_Modified,
        tp_Ordering,
        tp_ThreadIndex,
        tp_ModerationStatus,
        tp_ItemOrder,
        tp_InstanceID,
        tp_Size,
        tp_IsCurrent,
        tp_ContentType,
        tp_ContentTypeId,
        tp_CopySource,
        tp_HasCopyDestinations,
        tp_WorkflowVersion,
        tp_WorkflowInstanceID,
        tp_DirName,
        tp_LeafName,
        tp_UIVersion,
        tp_DraftOwnerId,
        tp_CheckoutUserId,
        nvarchar1,
        nvarchar2,
        nvarchar3,
        nvarchar4,
        nvarchar5,
        nvarchar6,
        nvarchar7,
        nvarchar8,
        nvarchar9,
        nvarchar10,
        nvarchar11,
        nvarchar12,
        nvarchar13,
        nvarchar14,
        nvarchar15,
        nvarchar16,
        nvarchar17,
        nvarchar18,
        nvarchar19,
        nvarchar20,
        nvarchar21,
        nvarchar22,
        nvarchar23,
        nvarchar24,
        nvarchar25,
        nvarchar26,
        nvarchar27,
        nvarchar28,
        nvarchar29,
        nvarchar30,
        nvarchar31,
        nvarchar32,
        nvarchar33,
        nvarchar34,
        nvarchar35,
        nvarchar36,
        nvarchar37,
        nvarchar38,
        nvarchar39,
        nvarchar40,
        nvarchar41,
        nvarchar42,
        nvarchar43,
        nvarchar44,
        nvarchar45,
        nvarchar46,
        nvarchar47,
        nvarchar48,
        nvarchar49,
        nvarchar50,
        nvarchar51,
        nvarchar52,
        nvarchar53,
        nvarchar54,
        nvarchar55,
        nvarchar56,
        nvarchar57,
        nvarchar58,
        nvarchar59,
        nvarchar60,
        nvarchar61,
        nvarchar62,
        nvarchar63,
        nvarchar64,
        int1,
        int2,
        int3,
        int4,
        int5,
        int6,
        int7,
        int8,
        int9,
        int10,
        int11,
        int12,
        int13,
        int14,
        int15,
        int16,
        float1,
        float2,
        float3,
        float4,
        float5,
        float6,
        float7,
        float8,
        float9,
        float10,
        float11,
        float12,
        datetime1,
        datetime2,
        datetime3,
        datetime4,
        datetime5,
        datetime6,
        datetime7,
        datetime8,
        bit1,
        bit2,
        bit3,
        bit4,
        bit5,
        bit6,
        bit7,
        bit8,
        bit9,
        bit10,
        bit11,
        bit12,
        bit13,
        bit14,
        bit15,
        bit16,
        uniqueidentifier1,
        ntext1,
        ntext2,
        ntext3,
        ntext4,
        ntext5,
        ntext6,
        ntext7,
        ntext8,
        ntext9,
        ntext10,
        ntext11,
        ntext12,
        ntext13,
        ntext14,
        ntext15,
        ntext16,
        ntext17,
        ntext18,
        ntext19,
        ntext20,
        ntext21,
        ntext22,
        ntext23,
        ntext24,
        ntext25,
        ntext26,
        ntext27,
        ntext28,
        ntext29,
        ntext30,
        ntext31,
        ntext32,
        sql_variant1,
        sql_variant2,
        sql_variant3,
        sql_variant4,
        sql_variant5,
        sql_variant6,
        sql_variant7,
        sql_variant8)
    VALUES (
        @ItemId,
        @Level,
        ISNULL(@tp_GUID, NEWID()),
        @ListID,
        @SiteID,
        @RowOrdinal,
        @tp_Version,
        ISNULL(@tp_Author, @UserID),
        ISNULL(@tp_Editor, @UserID),
        ISNULL(@tp_Created, @DTM),
        ISNULL(@tp_Modified, @DTM),
        @tp_Ordering,
        @tp_ThreadIndex,
        @tp_ModerationStatus,
        @tp_ItemOrder,
        @tp_InstanceID,
        @Size,
        @tp_IsCurrent,
        @tp_ContentType,
        CASE @RowOrdinal
            WHEN 0 THEN ISNULL(@tp_ContentTypeId, 0x00 + cast(@ListID as varbinary(16)))
            ELSE NULL
        END,    
        @tp_CopySource,
        @tp_HasCopyDestinations,
        @tp_WorkflowVersion,
        @tp_WorkflowInstanceID,
        @ItemDirName,
        @ItemLeafName,
        COALESCE(@UIVersion, 512),
        @DraftOwnerId,
        @CheckoutUserId,
        @nvarchar1,
        @nvarchar2,
        @nvarchar3,
        @nvarchar4,
        @nvarchar5,
        @nvarchar6,
        @nvarchar7,
        @nvarchar8,
        @nvarchar9,
        @nvarchar10,
        @nvarchar11,
        @nvarchar12,
        @nvarchar13,
        @nvarchar14,
        @nvarchar15,
        @nvarchar16,
        @nvarchar17,
        @nvarchar18,
        @nvarchar19,
        @nvarchar20,
        @nvarchar21,
        @nvarchar22,
        @nvarchar23,
        @nvarchar24,
        @nvarchar25,
        @nvarchar26,
        @nvarchar27,
        @nvarchar28,
        @nvarchar29,
        @nvarchar30,
        @nvarchar31,
        @nvarchar32,
        @nvarchar33,
        @nvarchar34,
        @nvarchar35,
        @nvarchar36,
        @nvarchar37,
        @nvarchar38,
        @nvarchar39,
        @nvarchar40,
        @nvarchar41,
        @nvarchar42,
        @nvarchar43,
        @nvarchar44,
        @nvarchar45,
        @nvarchar46,
        @nvarchar47,
        @nvarchar48,
        @nvarchar49,
        @nvarchar50,
        @nvarchar51,
        @nvarchar52,
        @nvarchar53,
        @nvarchar54,
        @nvarchar55,
        @nvarchar56,
        @nvarchar57,
        @nvarchar58,
        @nvarchar59,
        @nvarchar60,
        @nvarchar61,
        @nvarchar62,
        @nvarchar63,
        @nvarchar64,
        @int1,
        @int2,
        @int3,
        @int4,
        @int5,
        @int6,
        @int7,
        @int8,
        @int9,
        @int10,
        @int11,
        @int12,
        @int13,
        @int14,
        @int15,
        @int16,
        @float1,
        @float2,
        @float3,
        @float4,
        @float5,
        @float6,
        @float7,
        @float8,
        @float9,
        @float10,
        @float11,
        @float12,
        @datetime1,
        @datetime2,
        @datetime3,
        @datetime4,
        @datetime5,
        @datetime6,
        @datetime7,
        @datetime8,
        @bit1,
        @bit2,
        @bit3,
        @bit4,
        @bit5,
        @bit6,
        @bit7,
        @bit8,
        @bit9,
        @bit10,
        @bit11,
        @bit12,
        @bit13,
        @bit14,
        @bit15,
        @bit16,
        @uniqueidentifier1,
        @ntext1,
        @ntext2,
        @ntext3,
        @ntext4,
        @ntext5,
        @ntext6,
        @ntext7,
        @ntext8,
        @ntext9,
        @ntext10,
        @ntext11,
        @ntext12,
        @ntext13,
        @ntext14,
        @ntext15,
        @ntext16,
        @ntext17,
        @ntext18,
        @ntext19,
        @ntext20,
        @ntext21,
        @ntext22,
        @ntext23,
        @ntext24,
        @ntext25,
        @ntext26,
        @ntext27,
        @ntext28,
        @ntext29,
        @ntext30,
        @ntext31,
        @ntext32,
        case @error_sql_variant1
            when 1 then CAST(@sql_variant1 as varbinary(2)) 
            when 2 then CAST(@sql_variant1 as bit) 
            when 3 then CAST(@sql_variant1 as float) 
            when 4 then CAST(@sql_variant1 as datetime) 
            else @sql_variant1
        end,
        case @error_sql_variant2
            when 1 then CAST(@sql_variant2 as varbinary(2)) 
            when 2 then CAST(@sql_variant2 as bit) 
            when 3 then CAST(@sql_variant2 as float) 
            when 4 then CAST(@sql_variant2 as datetime) 
            else @sql_variant2
        end,
        case @error_sql_variant3
            when 1 then CAST(@sql_variant3 as varbinary(2)) 
            when 2 then CAST(@sql_variant3 as bit) 
            when 3 then CAST(@sql_variant3 as float) 
            when 4 then CAST(@sql_variant3 as datetime) 
            else @sql_variant3
        end,
        case @error_sql_variant4
            when 1 then CAST(@sql_variant4 as varbinary(2)) 
            when 2 then CAST(@sql_variant4 as bit) 
            when 3 then CAST(@sql_variant4 as float) 
            when 4 then CAST(@sql_variant4 as datetime) 
            else @sql_variant4
        end,
        case @error_sql_variant5
            when 1 then CAST(@sql_variant5 as varbinary(2)) 
            when 2 then CAST(@sql_variant5 as bit) 
            when 3 then CAST(@sql_variant5 as float) 
            when 4 then CAST(@sql_variant5 as datetime) 
            else @sql_variant5
        end,
        case @error_sql_variant6
            when 1 then CAST(@sql_variant6 as varbinary(2)) 
            when 2 then CAST(@sql_variant6 as bit) 
            when 3 then CAST(@sql_variant6 as float) 
            when 4 then CAST(@sql_variant6 as datetime) 
            else @sql_variant6
        end,
        case @error_sql_variant7
            when 1 then CAST(@sql_variant7 as varbinary(2)) 
            when 2 then CAST(@sql_variant7 as bit) 
            when 3 then CAST(@sql_variant7 as float) 
            when 4 then CAST(@sql_variant7 as datetime) 
            else @sql_variant7
        end,
        case @error_sql_variant8
            when 1 then CAST(@sql_variant8 as varbinary(2)) 
            when 2 then CAST(@sql_variant8 as bit) 
            when 3 then CAST(@sql_variant8 as float) 
            when 4 then CAST(@sql_variant8 as datetime) 
            else @sql_variant8
        end
        )
    IF @@ROWCOUNT <> 1
        RETURN 87
    IF @RowOrdinal = 0
    BEGIN
        IF @ServerTemplate = 200
        BEGIN
            EXEC @ReturnCode = proc_PostProcessAddMtgListItem
                @SiteId,
                @WebId,
                @ListID,
                @ItemId,
                @int1,
                @nvarchar1,
                @datetime3,
                @tp_InstanceID,
                @OnRestore,
                @UserID,
                @UserTitle
            IF @ReturnCode <> 0
                RETURN @ReturnCode    
        END
        UPDATE
            Lists
        SET
            tp_ItemCount = tp_ItemCount + @ItemCountDelta,
            tp_Modified = @DTM,
            tp_NextAvailableId = CASE
                WHEN @AddNamespace = 1 AND @ItemId >= tp_NextAvailableId THEN @ItemId + 1
                ELSE tp_NextAvailableId
            END
        WHERE
            tp_WebID = @WebID AND
            tp_ID = @ListID
        IF @ItemName IS NULL AND @UseNvarchar1ItemName = 1
            SET @ItemName = @nvarchar1
        IF @RetainObjectIdentity = 1
        BEGIN
            SET @DocIdAdded = @RetainId
        END
        DECLARE @TimeLastModifiedLog datetime
        IF (@OnRestore = 1)
        BEGIN
            SET @TimeLastModifiedLog = GETUTCDATE()
        END
        ELSE
        BEGIN
            SET @TimeLastModifiedLog = @DTM
        END
        EXEC proc_AddEventToCache
            @SiteId,
            @WebId, 
            @ListID,
            @ItemId,
            @ItemName,
            @ItemFullUrl,
            @DocIdAdded,
            4097,
            @UserTitle,
            @TimeLastModifiedLog,
            @eventData,
            @acl
        IF (@OnRestore = 1)
        BEGIN
            EXEC proc_AddEventToCache
                @SiteId,
                @WebId, 
                @ListID,
                @ItemId,
                @ItemName,
                @ItemFullUrl,
                @DocIdAdded,
                1048576,
                @UserTitle,
                @TimeLastModifiedLog,
                NULL,
                @acl
        END
    END
    IF @CopySecurityFromMasterID IS NOT NULL
    BEGIN
        DECLARE @CopyFromScopeId uniqueidentifier
        SELECT 
            @CopyFromScopeId = Docs.ScopeId
        FROM
            Docs
        INNER JOIN
            UserData
        ON
            Docs.SiteId = UserData.tp_SiteId AND
            Docs.DirName = UserData.tp_DirName AND
            Docs.LeafName = UserData.tp_LeafName AND
            Docs.Level = UserData.tp_Level
        WHERE
            Docs.SiteId = @SiteId AND
            UserData.tp_SiteId = @SiteId AND
            UserData.tp_ListId = @ListID AND
            UserData.tp_ID = @CopySecurityFromMasterID 
        IF @CopyFromScopeId != @ScopeId        
            EXEC proc_SecChangeToUniqueScope @SiteId, @WebId, @ScopeId, @CopyFromScopeId, @ItemFullUrl, NULL, 0, @UserId, 0, 1, 0, 0, NULL
    END
    SET @Size = @Size + @DocSize
    EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, @Size, 1
    RETURN @ReturnCode

GO
