/****** Object:  StoredProcedure [dbo].[proc_RestoreRecycleBinItem]    Script Date: 5/15/2018 12:12:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_RestoreRecycleBinItem(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @UserId int,
    @DeleteTransactionId varbinary(16))
AS
    SET NOCOUNT ON
    DECLARE @Ret int
    SET @Ret = 1359
    DECLARE @DeleteUserId int
    DECLARE @ItemType tinyint
    DECLARE @DocId uniqueidentifier
    DECLARE @DocVersionId int
    DECLARE @ListId uniqueidentifier
    DECLARE @ListItemId int
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    DECLARE @Title nvarchar(260)
    DECLARE @ListDirName nvarchar(256)
    DECLARE @ScopeId uniqueidentifier
    DECLARE @ContainingListBaseType int
    DECLARE @ContainingListFlags bigint
    DECLARE @ContainingListId uniqueidentifier
    DECLARE @SizeOccupied bigint
    SET @SizeOccupied = 0
    BEGIN TRAN
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
    IF (@UserId = 0)
    BEGIN
        SELECT
            @WebId = WebId,
            @DeleteUserId = DeleteUserId,
            @ItemType = ItemType,
            @DocId = DocId,
            @DocVersionId = DocVersionId,
            @ListId = ListId,
            @ListItemId = ListItemId,
            @DirName = DirName,
            @LeafName = LeafName,
            @Title = Title,
            @ListDirName = ListDirName,
            @SizeOccupied = 
                CASE 
                WHEN BinId = 2 THEN Size 
                ELSE 0 
                END,
            @ScopeId = ScopeId    
        FROM
            RecycleBin
        WHERE
            SiteId = @SiteId AND
            DeleteTransactionId = @DeleteTransactionId
        IF (@@ROWCOUNT <> 1)
        BEGIN
            SET @Ret = 1168
            GOTO cleanup
        END
        IF (NOT EXISTS(SELECT * FROM Webs WHERE Id = @WebId AND SiteId = @SiteId))
        BEGIN
            SET @Ret = 1168
            GOTO cleanup
        END
    END
    ELSE
    BEGIN
        SELECT
            @ItemType = ItemType,
            @DocId = DocId,
            @DocVersionId = DocVersionId,
            @ListId = ListId,
            @ListItemId = ListItemId,
            @DirName = DirName,
            @LeafName = LeafName,
            @Title = Title,
            @ListDirName = ListDirName,
            @SizeOccupied = 
                CASE 
                WHEN BinId = 2 THEN Size 
                ELSE 0 
                END,
            @ScopeId = ScopeId    
        FROM
            RecycleBin
        WHERE
            SiteId = @SiteId AND
            WebId = @WebId AND
            DeleteUserId = @UserId AND
            DeleteTransactionId = @DeleteTransactionId
        IF (@@ROWCOUNT <> 1)
        BEGIN
            SET @Ret = 1168
            GOTO cleanup
        END
        SET @DeleteUserId = @UserId
    END
    IF (@ItemType = 2)
    BEGIN
        DECLARE @NewListId uniqueidentifier
        DECLARE @NewItemId int
        DECLARE @NewDirName nvarchar(256)
    	 DECLARE @NewLeafName nvarchar(128)
        SELECT
            @NewListId = ListId,
            @NewItemId = DocLibRowId,
            @NewDirName = DirName,
            @NewLeafName = LeafName
        FROM 
        	Docs
        WHERE
                Id = @DocId
        IF (@@ROWCOUNT = 0)
        BEGIN
            SET @Ret = 1979
            GOTO cleanup
        END
        UPDATE
            AllDocVersions
        SET
           DeleteTransactionId = 0x
        WHERE
            SiteId = @SiteId AND
            Id = @DocId AND
            Version = @DocVersionId AND
            DeleteTransactionId = @DeleteTransactionId
        UPDATE
            AllUserData
        SET
            tp_DeleteTransactionId = 0x,
            tp_ListId = @NewListId,
            tp_ID = @NewItemId,
            tp_DirName = @NewDirName,
            tp_LeafName = @NewLeafName            
        WHERE
            tp_SiteId = @SiteId AND
            tp_DirName = @DirName AND
            tp_LeafName = @LeafName AND
            tp_CalculatedVersion = @DocVersionId AND
            tp_DeleteTransactionId = @DeleteTransactionId
        DELETE FROM
            RecycleBin
        WHERE
            SiteId = @SiteId AND
            WebId = @WebId AND
            DeleteUserId = @DeleteUserId AND
            DeleteTransactionId = @DeleteTransactionId
        SET @Ret = 0
        GOTO cleanup
    END
    SET @ContainingListBaseType = -1
    SET @ContainingListFlags = 0x0
    SET @ContainingListId = 0x0
    IF (@ListId IS NOT NULL AND 
        (@ItemType = 1 OR
        @ItemType = 5) OR
        @ItemType = 3 OR
        @ItemType = 8 OR
        @ItemType = 7
        )
    BEGIN
        IF @ListDirName IS NULL
        BEGIN
            SET @Ret = 1359
            GOTO cleanup
        END
        DECLARE @CurrentListDirName nvarchar(256)
        SELECT
            @CurrentListDirName = CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END,
            @ContainingListBaseType = Lists.tp_BaseType,
            @ContainingListFlags = Lists.tp_Flags,
            @ContainingListId = Lists.tp_ID
        FROM
            Docs
        INNER JOIN
            Lists
        ON
            Lists.tp_RootFolder = Docs.Id AND
            Lists.tp_WebId = @WebId AND
            Lists.tp_ID = @ListId        
        IF @CurrentListDirName IS NULL OR @ListDirName <> @CurrentListDirName
        BEGIN
            SET @Ret = 1979
            GOTO cleanup
        END
    END
    IF (@ItemType = 3 AND
        @ContainingListBaseType = 4 AND
        @ContainingListFlags & 0x800 = 0)
    BEGIN
        DECLARE @HasOtherResponses int
        DECLARE @MeetingInstanceId int
        SELECT 
            @MeetingInstanceId = tp_InstanceID
        FROM
            AllUserData
        WHERE
            tp_ID = @ListItemId
        EXEC @HasOtherResponses = proc_UserHasDataItems 
                                      @ContainingListId, 
                                      @UserId,    
                                      @MeetingInstanceId
        IF @HasOtherResponses <> 0 
        BEGIN
            SET @Ret = 80
            GOTO cleanup
        END
    END
    IF (@ItemType = 1 OR
        @ItemType = 5 OR
        @ItemType = 6 OR
        @ItemType = 4 OR
        @ItemType = 7)
    BEGIN
        IF (EXISTS(
            SELECT
                *
            FROM
                Docs
            WHERE
                SiteId = @SiteId AND
                DirName = @DirName AND
                LeafName = @LeafName))
        BEGIN
            SET @Ret = 80
            GOTO cleanup
        END
    END
    IF (@ItemType = 7 OR
        @ItemType = 8)
    BEGIN
        IF NOT EXISTS(
            SELECT
                *
            FROM
                UserData
            WHERE
                tp_ListId = @ListId AND
                tp_Id = @ListItemId
            )
        BEGIN
            SET @Ret = 1979
            GOTO cleanup
        END
    END
    IF (@ItemType = 4 AND 
        EXISTS(
            SELECT
                *
            FROM
                Lists
            WHERE
                tp_WebId = @WebId AND
                tp_Title = @Title))
    BEGIN
        SET @Ret = 80
        GOTO cleanup
    END
    IF (@ItemType = 6 AND 
        EXISTS(
            SELECT
                *
            FROM
                Lists
            WHERE
                tp_WebId = @WebId AND
                tp_Title IN
                    (SELECT
                        tp_Title
                    FROM
                        AllLists
                    WHERE
                        tp_WebId = @WebId AND
                        tp_DeleteTransactionId = @DeleteTransactionId
                    )))
    BEGIN
        SET @Ret = 80
        GOTO cleanup
    END
    DECLARE @DirDirName nvarchar(256)
    DECLARE @DirLeafName nvarchar(128)
    EXEC proc_SplitUrl
        @DirName,
        @DirDirName OUTPUT,
        @DirLeafName OUTPUT
    DECLARE @NewParentId uniqueidentifier
    DECLARE @NewScopeId uniqueidentifier
    DECLARE @NewCtoOffset int
    SELECT
        @NewParentId = Id,
        @NewScopeId = ScopeId,
        @NewCtoOffset = CtoOffset
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirDirName AND
        LeafName = @DirLeafName
    IF @NewParentId IS NULL
    BEGIN
        SET @Ret = 3
        GOTO cleanup
    END
    DECLARE @FixUpCtoOffset bit
    SET @FixUpCtoOffset = 0
    DECLARE @CtoOffset int
    IF @ItemType = 5
    BEGIN
        SELECT
            @FixUpCtoOffset = CASE WHEN DocFlags & 8192 <> 0 THEN 0 ELSE 1 END,
            @CtoOffset = CtoOffset
        FROM
            AllDocs
        WHERE
            SiteId = @SiteId AND
            DeleteTransactionId = @DeleteTransactionId AND
            DirName = @DirName AND
            LeafName = @LeafName
    END
    IF (@ItemType = 1 OR
        @ItemType = 3 OR
        @ItemType = 8 OR
        @ItemType = 5 OR
        @ItemType = 4)
    BEGIN    
        UPDATE
            ImmedSubscriptions
        SET
            Deleted = 0
        WHERE
            SiteId = @SiteId AND
            ListId = @ListId AND
            ItemId IN
                (SELECT
                    tp_Id
                FROM
                    AllUserData
                WHERE    
                    tp_ListId = @ListId AND
                    tp_DeleteTransactionId = @DeleteTransactionId)
        UPDATE
            SchedSubscriptions
        SET
            Deleted = 0
        WHERE
            SiteId = @SiteId AND
            ListId = @ListId AND
            ItemId IN
                (SELECT
                    tp_Id
                FROM
                    AllUserData
                WHERE    
                    tp_ListId = @ListId AND
                    tp_DeleteTransactionId = @DeleteTransactionId)
        UPDATE
            AllUserData
        SET
            tp_DeleteTransactionId = 0x
        WHERE
            tp_ListId = @ListId AND
            tp_DeleteTransactionId = @DeleteTransactionId
    END
    ELSE IF (@ItemType = 6)
    BEGIN
        DECLARE @ItemsDeleted table (
            ListId uniqueidentifier NOT NULL,
            ItemId int NOT NULL)
        INSERT INTO @ItemsDeleted (ListId, ItemId)
        SELECT
            tp_ListId,
            tp_Id
        FROM
            AllUserData
        WHERE    
            tp_ListId IN
                (SELECT
                    tp_Id
                FROM
                    AllLists
                WHERE
                    tp_WebId = @WebId AND
                    tp_DeleteTransactionId = @DeleteTransactionId
                ) AND
            tp_DeleteTransactionId = @DeleteTransactionId
        UPDATE
            ImmedSubscriptions
        SET
            Deleted = 0
        WHERE
            SiteId = @SiteId AND
            EXISTS(
                SELECT 
                    * 
                FROM 
                    @ItemsDeleted D
                WHERE
                    D.ListId = ImmedSubscriptions.ListId AND
                    D.ItemId = ImmedSubscriptions.ItemId)
        UPDATE
            SchedSubscriptions
        SET
            Deleted = 0
        WHERE
            SiteId = @SiteId AND
            EXISTS(
                SELECT 
                    *
                FROM 
                    @ItemsDeleted D
                WHERE
                    D.ListId = SchedSubscriptions.ListId AND
                    D.ItemId = SchedSubscriptions.ItemId)
        UPDATE
            AllUserData
        SET
            tp_DeleteTransactionId = 0x
        WHERE
            EXISTS(
                SELECT 
                    * 
                FROM 
                    @ItemsDeleted D
                WHERE
                    D.ListId = tp_ListId AND
                    D.ItemId = tp_Id)
    END
    DECLARE @ItemCountDelta int
    SET @ItemCountDelta = 0
    IF @ItemType = 1 OR @ItemType = 7
    BEGIN
        IF @ItemType = 1
        BEGIN
            EXEC @Ret = proc_RestoreFixupImageInternal
                @SiteId,
                @WebId,
                @DeleteTransactionId,
                @DirName,
                @LeafName
            IF (@Ret <> 0)
                GOTO cleanup
        END
        IF @ItemType = 1
        BEGIN
            SELECT
                @ItemCountDelta = COUNT(*)
            FROM
                AllDocs
            WHERE
                SiteId = @SiteId AND
                DeleteTransactionId = @DeleteTransactionId AND
                DoclibRowId IS NOT NULL AND
                IsCurrentVersion = 1
        END
        DECLARE @ParentId uniqueidentifier
        SELECT
            @ParentId = ParentId
        FROM
            AllDocs
        WHERE
            SiteId = @SiteId AND
            DeleteTransactionId = @DeleteTransactionId AND
            Id = @DocId
        IF @ParentId IS NULL
        BEGIN
            SET @Ret = 1359
            GOTO cleanup
        END
        UPDATE
            AllDocs
        SET
            ParentId = 
                CASE 
                WHEN ParentId = @ParentId THEN @NewParentId 
                ELSE ParentId 
                END,
            ScopeId =
                CASE
                WHEN ScopeId = @ScopeId THEN @NewScopeId 
                ELSE ScopeId 
                END,
            CtoOffset =
                CASE
                WHEN 
                    @FixUpCtoOffset = 1 AND 
                    (CtoOffset IS NULL AND 
                    @CtoOffset IS NULL OR CtoOffset = @CtoOffset) 
                    THEN @NewCtoOffset
                ELSE CtoOffset
                END,
            DeleteTransactionId = 0x
        WHERE
            SiteId = @SiteId AND
            DeleteTransactionId = @DeleteTransactionId
        IF @ParentId <> @NewParentId
        BEGIN
            UPDATE
                AllDocStreams
            SET
                ParentId = @NewParentId
            WHERE
                SiteId = @SiteId AND
                ParentId = @ParentId AND
                DeleteTransactionId = @DeleteTransactionId
        END
        UPDATE
            AllDocStreams
        SET
            DeleteTransactionId = 0x
        WHERE
            SiteId = @SiteId AND
            DeleteTransactionId = @DeleteTransactionId
        UPDATE
            Personalization
        SET
            tp_Deleted = 0
        WHERE
            tp_SiteId = @SiteId AND
            tp_Deleted = 1 AND
            tp_PageUrlId = @DocId
        UPDATE
            WebParts
        SET
            tp_Deleted = 0
        WHERE
            tp_SiteId = @SiteId AND
            tp_Deleted = 1 AND
            tp_PageUrlId = @DocId
        UPDATE
            AllDocVersions
        SET
            DeleteTransactionId = 0x
        WHERE
            SiteId = @SiteId AND
            Id = @DocId AND
            DeleteTransactionId = @DeleteTransactionId
    END
    ELSE
    BEGIN
        IF (@ItemType = 4 OR
            @ItemType = 5 OR
            @ItemType = 6)
        BEGIN
            UPDATE
                AllDocVersions
            SET
                DeleteTransactionId = 0x
            WHERE
                SiteId = @SiteId AND
                Id IN (
                    SELECT
                        Id
                    FROM
                        AllDocs
                    WHERE
                        SiteId = @SiteId AND
                        DeleteTransactionId = @DeleteTransactionId) AND
                DeleteTransactionId = @DeleteTransactionId
        END
        IF (@ItemType = 5)
        BEGIN
            SELECT
                @ItemCountDelta = COUNT(*)
            FROM
                AllDocs
            WHERE
                SiteId = @SiteId AND
                DeleteTransactionId = @DeleteTransactionId AND
                DoclibRowId IS NOT NULL AND
                IsCurrentVersion = 1
        END
        ELSE IF (@ItemType = 3)
        BEGIN
            SET @ItemCountDelta = 1
        END
        UPDATE
            Personalization
        SET
            tp_Deleted = 0
        WHERE
            tp_SiteId = @SiteId AND
            tp_Deleted = 1 AND
            tp_PageUrlId IN (
                SELECT
                    Id
                FROM
                    AllDocs
                WHERE
                    SiteId = @SiteId AND
                    DeleteTransactionId = @DeleteTransactionId)
        UPDATE
            WebParts
        SET
            tp_Deleted = 0
        WHERE
            tp_SiteId = @SiteId AND
            tp_Deleted = 1 AND
            tp_PageUrlId IN (
                SELECT
                    Id
                FROM
                    AllDocs
                WHERE
                    SiteId = @SiteId AND
                    DeleteTransactionId = @DeleteTransactionId)
        UPDATE
            AllDocs
        SET
            DeleteTransactionId = 0x,
            ParentId = 
                CASE 
                WHEN ParentId = @ParentId THEN @NewParentId 
                ELSE ParentId 
                END,
            ScopeId = 
                CASE
                WHEN ScopeId = @ScopeId THEN @NewScopeId
                ELSE ScopeId
                END
        WHERE
            SiteId = @SiteId AND
            DeleteTransactionId = @DeleteTransactionId
        UPDATE
            AllDocStreams
        SET
            DeleteTransactionId = 0x
        WHERE
            SiteId = @SiteId AND
            DeleteTransactionId = @DeleteTransactionId
    END
    IF @ItemType = 4
    BEGIN
        UPDATE
            ImmedSubscriptions
        SET
            Deleted = 0
        WHERE
            SiteId = @SiteId AND
            ListId = @ListId AND
            ItemId IS NULL
        UPDATE
            SchedSubscriptions
        SET
            Deleted = 0
        WHERE
            SiteId = @SiteId AND
            ListId = @ListId AND
            ItemId IS NULL
        UPDATE
            AllLists
        SET
            tp_DeleteTransactionId = 0x,
            tp_ScopeId =
                CASE
                WHEN tp_ScopeId = @ScopeId THEN @NewScopeId
                ELSE tp_ScopeId
                END
        WHERE
            tp_WebId = @WebId AND
            tp_Id = @ListId
    END
    ELSE IF @ItemType = 6
    BEGIN
        UPDATE
            ImmedSubscriptions
        SET
            Deleted = 0
        WHERE
            SiteId = @SiteId AND
            ListId IN (
                SELECT
                    tp_Id
                FROM
                    AllLists
                WHERE
                    tp_WebId = @WebId AND
                    tp_DeleteTransactionId = @DeleteTransactionId) AND
            ItemId IS NULL        
        UPDATE
            SchedSubscriptions
        SET
            Deleted = 0
        WHERE
            SiteId = @SiteId AND
            ListId IN (
                SELECT
                    tp_Id
                FROM
                    AllLists
                WHERE
                    tp_WebId = @WebId AND
                    tp_DeleteTransactionId = @DeleteTransactionId) AND
            ItemId IS NULL        
        UPDATE
            AllLists
        SET
            tp_DeleteTransactionId = 0x,
            tp_ScopeId =
                CASE
                WHEN tp_ScopeId = @ScopeId THEN @NewScopeId
                ELSE tp_ScopeId
                END
        WHERE
            tp_WebId = @WebId AND
            tp_DeleteTransactionId = @DeleteTransactionId
    END
    IF @ItemCountDelta > 0 AND
        @ListId IS NOT NULL AND
        (@ItemType = 5 OR
        @ItemType = 1 OR
        @ItemType = 3 OR
        @ItemType = 8)
    BEGIN
        UPDATE
            Lists
        SET
            tp_ItemCount = tp_ItemCount + @ItemCountDelta,
            tp_Modified = GETUTCDATE()
        WHERE
            tp_WebId = @WebId AND
            tp_Id = @ListId
    END
    UPDATE
        AllLinks
    SET
        DeleteTransactionId = 0x
    WHERE
        SiteId = @SiteId AND
        DeleteTransactionId = @DeleteTransactionId
    UPDATE
        Deps
    SET
        DeleteTransactionId = 0x
    WHERE
        SiteId = @SiteId AND
        DeleteTransactionId = @DeleteTransactionId
    IF @ScopeId IS NULL
        EXEC proc_SecFixScopeByTransactionId @SiteId, @WebId, @DeleteTransactionId
    UPDATE
        Perms
    SET
        DelTransId = 0x
    WHERE
        SiteId = @SiteId AND
        DelTransId = @DeleteTransactionId
    UPDATE
        AllUserDataJunctions
    SET
        tp_DeleteTransactionId = 0x
    WHERE
        tp_SiteId = @SiteId AND
        tp_DeleteTransactionId = @DeleteTransactionId
    DELETE FROM
        RecycleBin
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        DeleteUserId = @DeleteUserId AND
        DeleteTransactionId = @DeleteTransactionId
    IF (@ItemType = 1 OR
        @ItemType = 5 OR
        @ItemType = 3 OR
        @ItemType = 8 OR
        @ItemType = 6 OR
        @ItemType = 7 OR
        @ItemType = 4)
    BEGIN
        DECLARE @FullName nvarchar(260)
        IF (@ItemType = 1 OR
            @ItemType = 5 OR
            @ItemType = 6)
        BEGIN    
            SET @FullName = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END
        END
        DECLARE @RestoreDate datetime
        SET @RestoreDate = GETUTCDATE()
        IF (@ItemType = 7)
        BEGIN
            EXEC proc_LogChange @SiteId, @WebId, NULL, NULL, @DocId, NULL,
                NULL, NULL, 131072, 16, @RestoreDate
            EXEC proc_AddEventToCache @SiteId, @WebId, @ListId, @ListItemId,
                NULL, NULL, NULL, 8192, NULL, @RestoreDate, NULL, NULL
        END
        ELSE IF (@ItemType = 4)
        BEGIN
            EXEC proc_LogChange @SiteId, @WebId, @ListId, NULL, NULL, NULL,
                NULL, NULL, 131072, 2, @RestoreDate
        END
        ELSE IF (@ListItemId IS NOT NULL)
        BEGIN
            EXEC proc_AddEventToCacheForDeleteRestore
                @SiteId, 
                @WebId, 
                @ListId,
                @ListItemId,
                @LeafName,
                @FullName,
                @DocId,
                131081,
                @UserId,
                @RestoreDate,
                NULL,
                NULL
        END
        ELSE
        BEGIN
            IF (@ItemType = 1)
            BEGIN
                EXEC proc_LogChange @SiteId, @WebId, NULL, NULL, @DocId, NULL,
                    NULL, @FullName, 131072, 16, @RestoreDate
            END
            ELSE IF (@ItemType = 5 OR @ItemType = 6)
            BEGIN
                EXEC proc_LogChange @SiteId, @WebId, NULL, NULL, @DocId, NULL,
                    NULL, @FullName, 131072, 32, @RestoreDate
            END
        END
    END
    IF @ItemType = 7
    BEGIN
        EXEC proc_UpdateAttachmentsFlag @SiteId, @DirName,
            @DeleteUserId, 1
    END
    IF @ItemType = 1 OR @ItemType = 3
    BEGIN
        EXEC proc_UpdateChildCount @SiteId, @DirName, @LeafName,
                                   @ListItemId, 0, 
                                   0, 1
    END
    ELSE IF @ItemType = 5
    BEGIN
        EXEC proc_UpdateChildCount @SiteId, @DirName, @LeafName,
                                   @ListItemId, 0, 
                                   1, 1
    END
    SET @Ret = 0
cleanup:
    IF @Ret = 0 AND
       (@ItemType = 1 OR
        @ItemType = 5 OR
        @ItemType = 3 OR       
        @ItemType = 8 OR       
        @ItemType = 2 OR       
        @ItemType = 4)
    BEGIN
        DECLARE @AuditItemType tinyint
        DECLARE @AuditEventData nvarchar(4000)
        IF (@ItemType = 1 OR @ItemType = 2) SET @AuditItemType = 1
        ELSE IF (@ItemType = 3 OR @ItemType = 8) SET @AuditItemType = 3
        ELSE IF (@ItemType = 5) SET @AuditItemType = 5
        ELSE IF (@ItemType = 4) SET @AuditItemType = 4
        IF (@ItemType = 2 OR @ItemType = 8)
        BEGIN
            SET @AuditEventData = STUFF(STUFF('</>', 3, 0, 'Version'), 1, 0, STUFF(STUFF(STUFF('</>', 3, 0, 'Major'), 1, 0, STUFF(@DocVersionId/512, 1, 0, STUFF('<>', 2, 0, 'Major'))) + STUFF(STUFF('</>', 3, 0, 'Minor'), 1, 0, STUFF(@DocVersionId%512, 1, 0, STUFF('<>', 2, 0, 'Minor'))), 1, 0, STUFF('<>', 2, 0, 'Version')))
        END
        ELSE
        BEGIN
            SET @AuditEventData = NULL
        END
        DECLARE @AuditUserId int
        IF @UserId = 0
		    SET @AuditUserId = -1
	    ELSE
			SET @AuditUserId = @UserId
        EXEC proc_AddAuditEntryFromSql 
               @SiteId, 
               @DirName, 
               @LeafName, 
               @AuditItemType, 
               @AuditUserId, 
               10, 
               @AuditEventData,
               0x00000200
    END
    IF (@Ret = 0)
    BEGIN
        IF (@SizeOccupied > 0)
        BEGIN
            EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, @SizeOccupied, 1
            UPDATE
                Sites
            SET
                SecondStageDiskUsed = SecondStageDiskUsed - @SizeOccupied
            WHERE
                Id = @SiteId
        END
        ELSE
        BEGIN
            EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, 0, 1
        END
    END
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Ret

GO
