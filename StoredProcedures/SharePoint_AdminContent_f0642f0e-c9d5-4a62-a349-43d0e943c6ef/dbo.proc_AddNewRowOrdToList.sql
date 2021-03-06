/****** Object:  StoredProcedure [dbo].[proc_AddNewRowOrdToList]    Script Date: 5/15/2018 12:12:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddNewRowOrdToList(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListID uniqueidentifier,
    @RowOrdinal int,
    @CheckSchemaVersion int = NULL)
AS
    SET NOCOUNT ON
    DECLARE @ReturnCode int
    SET @ReturnCode = 0
    DECLARE @MaxRowOrd int
    DECLARE @ItemCount int
    DECLARE @bItemsInList bit
    BEGIN
        DECLARE @CurVersion as int
            SELECT 
                @CurVersion = tp_Version 
            FROM 
                AllLists WITH (UPDLOCK)
            WHERE 
                tp_WebId = @WebId AND
                tp_ID = @ListId
            IF  @CurVersion <> ISNULL(@CheckSchemaVersion, @CurVersion)
            BEGIN
                RETURN 1638
            END
    END  
    SELECT 
        @MaxRowOrd = tp_MaxRowOrdinal,
        @ItemCount = tp_ItemCount
    FROM 
        AllLists
    WHERE
        tp_WebId = @WebId AND
        tp_ID = @ListId
    IF @MaxRowOrd < @RowOrdinal
    BEGIN
        UPDATE
            AllLists
        SET 
            tp_MaxRowOrdinal = @RowOrdinal
        WHERE 
            tp_WebId = @WebId AND
            tp_ID = @ListId
        IF (@ItemCount > 0)
        BEGIN
            SET @bItemsInList = 1
        END
        ELSE
        BEGIN
            IF EXISTS(
                SELECT
                    *
                FROM
                    AllUserData
                WHERE
                    tp_SiteId = @SiteId AND
                    tp_ListId = @ListId)
                BEGIN
                    SET @bItemsInList = 1
                END
                ELSE
                BEGIN
                    SET @bItemsInList = 0
                END
        END
        IF (@bItemsInList = 1)
        BEGIN
            INSERT INTO AllUserData(
                tp_ID,
                tp_GUID,
                tp_DirName,
                tp_LeafName,
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
                tp_HasCopyDestinations,
                tp_Size,
                tp_WorkflowVersion,
                tp_DeleteTransactionId,
                tp_IsCurrent,
                tp_IsCurrentVersion,
                tp_UIVersion,
                tp_CalculatedVersion,
                tp_Level,
                tp_DraftOwnerId,
                tp_CheckoutUserId)
            SELECT 
                tp_ID,
                tp_GUID,
                tp_DirName,
                tp_LeafName,
                tp_ListId,
                tp_SiteId,
                @RowOrdinal,
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
                tp_HasCopyDestinations,
                0,
                tp_WorkflowVersion,
                tp_DeleteTransactionId,
                tp_IsCurrent,
                tp_IsCurrentVersion,
                tp_UIVersion,
                tp_CalculatedVersion,
                tp_Level,
                tp_DraftOwnerId,
                tp_CheckoutUserId
             FROM 
                AllUserData
             WHERE
                tp_SiteId = @SiteId AND
                tp_ListId = @ListId AND
                tp_RowOrdinal = 0
            IF @@ROWCOUNT = 0
                RETURN 87
        END
    END
    RETURN @ReturnCode

GO
