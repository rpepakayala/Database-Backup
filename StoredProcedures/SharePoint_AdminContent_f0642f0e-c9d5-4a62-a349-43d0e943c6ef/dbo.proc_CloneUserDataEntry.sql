/****** Object:  StoredProcedure [dbo].[proc_CloneUserDataEntry]    Script Date: 5/15/2018 12:12:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CloneUserDataEntry(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListID uniqueidentifier,
    @OldItemID int,
    @NewInstanceID int = NULL,
    @NewItemID     int = NULL OUTPUT,
    @Now datetime = NULL,
    @OldLevel tinyint = 1,
    @NewLevel tinyint = NULL,
    @OldUIVersion int,
    @NewUIVersion int,
    @NewLeafName nvarchar(256) = NULL,
    @NewModerationStatus int = NULL,
    @UserId int = NULL)
AS
    SET NOCOUNT ON
    DECLARE @CreateNewLevel bit
    SET @CreateNewLevel =
                        CASE
                        WHEN
                                @OldLevel = @NewLevel
                        THEN
                                0
                        ELSE
                                1
                        END
    IF @OldLevel IS NULL OR @NewLevel IS NULL
    BEGIN
        RETURN 1150
    END
    IF @CreateNewLevel = 1
    BEGIN
        SET @NewItemID = @OldItemID
        UPDATE 
            UserData
        SET 
            tp_IsCurrent = 0
        WHERE 
            tp_ListId = @ListID AND
            tp_ID = @OldItemID
    END
    ELSE
    BEGIN
        EXEC @NewItemID = proc_GenerateNextId @WebId, @ListId
    END
    IF @NewItemID IS NULL OR @NewItemID <= 0
    BEGIN
        RETURN 1150
    END
    IF @Now IS NULL
        SET @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    INSERT INTO AllUserData(
        tp_Level,      
        tp_ID,
        tp_GUID,
        tp_ListId,
        tp_RowOrdinal,
        tp_SiteId,
        tp_Version,
        tp_Author,
        tp_Editor,
        tp_Created,
        tp_Modified,
        tp_Ordering,
        tp_ThreadIndex,
        tp_ModerationStatus,
        tp_IsCurrent,
        tp_ItemOrder,
        tp_InstanceID,
        tp_Size,
        tp_DirName,
        tp_LeafName,
        tp_ContentType,
        tp_ContentTypeId,
        tp_WorkflowVersion,
        tp_WorkflowInstanceID,
        tp_UIVersion,
        tp_CopySource,
        tp_HasCopyDestinations,
        tp_DraftOwnerId,
        tp_CheckoutUserId,
        tp_HasAttachment,
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
    SELECT  
        COALESCE(@NewLevel,tp_Level),
        @NewItemID,
        CASE WHEN @CreateNewLevel = 1 THEN tp_GUID ELSE NEWID() END,
        tp_ListId,
        tp_RowOrdinal,
        tp_SiteId,
        tp_Version,
        tp_Author,
        tp_Editor,
        CASE WHEN @CreateNewLevel = 1 THEN tp_Created ELSE tp_Modified END, 
        CASE WHEN @CreateNewLevel = 1 AND @NewLevel <> 255 
            THEN tp_Modified 
            ELSE @Now 
        END,
        tp_Ordering,
        tp_ThreadIndex,
        CASE WHEN @CreateNewLevel = 1 AND @NewLevel = 2
            THEN ISNULL(@NewModerationStatus, 3) 
            ELSE
            ISNULL(@NewModerationStatus, tp_ModerationStatus)
        END,
        1,
        tp_ItemOrder,
        COALESCE(@NewInstanceID, tp_InstanceID),
        tp_Size,
        tp_DirName,
        COALESCE(@NewLeafName, tp_LeafName),
        tp_ContentType,
        tp_ContentTypeId,
        tp_WorkflowVersion,
        tp_WorkflowInstanceID,
        COALESCE(@NewUIVersion, tp_UIVersion),
        tp_CopySource,
        tp_HasCopyDestinations,
        CASE WHEN @CreateNewLevel = 1 AND @NewLevel = 2
            THEN @UserId
        ELSE
            tp_DraftOwnerId
        END,
        CASE WHEN @CreateNewLevel = 1 AND @NewLevel = 255
            THEN @UserId
        ELSE
            tp_CheckoutUserId
        END,
        CASE WHEN @CreateNewLevel = 1 
            THEN tp_HasAttachment
        ELSE
            0
        END,
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
        sql_variant8
    FROM
        UserDataVersioned
    WHERE 
        tp_ListId = @ListID AND
        tp_ID = @OldItemID AND
        tp_Level = @OldLevel AND
        tp_UIVersion = @OldUIVersion
    IF @@ROWCOUNT = 0 
        RETURN 87
    EXEC proc_CloneItemInNameValuePair
        @SiteId,
        @ListID,
        @OldItemID,
        @NewItemID,
        @OldLevel,
        @NewLevel
    IF @CreateNewLevel <> 1
    BEGIN
        DECLARE @Modified datetime
        SELECT
            @Modified = tp_Modified
        FROM
            AllUserData
        WHERE
            tp_ListId = @ListId AND
            tp_ID = @OldItemID AND
            tp_Level = @OldLevel
        EXEC proc_UpdateItemInNameValuePair
            @SiteId, NULL, @ListId, @NewItemID, @NewLevel,
            '{8c06beca-0777-48f7-91c7-6da68bc07b69}', @Modified
    END
    UPDATE
        NameValuePair
    SET
        Value =
            CASE WHEN FieldId = '{28cf69c5-fa48-462a-b5cd-27b6f9d2bd5f}' AND (@CreateNewLevel <> 1 OR @NewLevel = 255)
                THEN @Now
            WHEN FieldId = '{7841bf41-43d0-4434-9f50-a673baef7631}'
                THEN COALESCE(@NewUIVersion, Value)
            WHEN FieldId = '{3881510a-4e4a-4ee8-b102-8ee8e2d0dd4b}' AND (@CreateNewLevel = 1 AND @NewLevel = 255)
                THEN @UserId
            ELSE
                Value
            END                    
    WHERE
        SiteId = @SiteId AND
        ListId = @ListId AND
        ItemId = @NewItemID AND
        Level = @NewLevel
    EXEC proc_CloneItemJunctions
        @SiteId,
        @ListId,
        @OldItemId,            
        @NewItemId,
        @OldLevel,
        @NewLevel,
        @OldUIVersion,
        @NewUIVersion
    RETURN 0

GO
