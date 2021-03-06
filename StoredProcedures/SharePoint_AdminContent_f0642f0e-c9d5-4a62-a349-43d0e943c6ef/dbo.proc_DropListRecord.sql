/****** Object:  StoredProcedure [dbo].[proc_DropListRecord]    Script Date: 5/15/2018 12:12:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DropListRecord(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @ServerTemplate int,
    @Id int,
    @UseNvarchar1ItemName bit = 1,
    @AuditIfNecessary bit = 0,
    @UserTitle nvarchar(255), 
    @Version int = NULL,
    @UserId int = 0,
    @NeedsAuthorRestriction bit = 0,
    @Basetype int = NULL,                       
    @DeleteOp int = 3,
    @eventData image = NULL,
    @acl image = NULL,
    @DeleteTransactionId varbinary(16) = 0x OUTPUT,
    @Size bigint = 0 OUTPUT)
AS
    SET NOCOUNT ON
    IF @DeleteTransactionId IS NULL
        SET @DeleteTransactionId = 0x
    BEGIN TRAN
    DECLARE @ReturnCode int
    SET @ReturnCode = 0
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    DECLARE @FullUrl nvarchar(260)
    DECLARE @guidT uniqueidentifier
    DECLARE @ItemGuid uniqueidentifier
    DECLARE @ItemName nvarchar(255)
    DECLARE @AuthorId int
    DECLARE @VersionNbr int
    DECLARE @MeetingEventType int
    SELECT
        @guidT = tp_ID
    FROM
        Lists WITH (UPDLOCK)
    WHERE
        tp_WebId = @WebId AND
        tp_ID = @ListId
    SELECT
        @ItemName = 
            CASE 
                WHEN @UseNvarchar1ItemName = 1 THEN UserData.nvarchar1 
                ELSE CAST(tp_Id AS NVARCHAR(10)) 
            END,
        @AuthorId = UserData.tp_Author,
        @VersionNbr = UserData.tp_Version,
        @MeetingEventType = int1,
        @DirName = UserData.tp_DirName,
        @LeafName = UserData.tp_LeafName,
        @ItemGuid = UserData.tp_GUID 
    FROM
        Docs WITH (UPDLOCK)
    INNER JOIN
        UserData WITH (XLOCK)
    ON
        Docs.SiteId = @SiteId AND
        Docs.ListID = @ListId AND
        Docs.DirName = UserData.tp_DirName AND
        Docs.LeafName = UserData.tp_LeafName    
    WHERE
        UserData.tp_ListId = @ListId AND
        UserData.tp_Id = @Id AND
        UserData.tp_RowOrdinal = 0
    IF (@@ROWCOUNT >= 1)
    BEGIN
        EXEC @ReturnCode = proc_VerifyUpdateConditions
            @VersionNbr,
            @AuthorId,
            @Version,
            @UserId,
            @NeedsAuthorRestriction
    END
    ELSE
    BEGIN
        SET @ReturnCode = 3
    END
    IF (@ReturnCode <> 0)
        GOTO FAILED
EXEC proc_DeleteContextCollectionEventReceivers @SiteID, @ItemGuid
    IF @AuditIfNecessary = 1
    BEGIN
        EXEC proc_AddAuditEntryFromSql
            @SiteId,
            @DirName,
            @LeafName,
            3,
            @UserId,
            4,
            NULL,
            0x00000008
    END
    SET @FullUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END
    EXEC @ReturnCode = proc_DeleteUrlCore
         @SiteId,
         @WebId,
         @FullUrl,
         @UserId,
         1, 
         @ItemName,
         0,
         0,
         0,
         3,
         0,
         @DeleteOp,
         @DeleteTransactionId OUTPUT,
         1,
         @FullUrl OUTPUT,
         @Size OUTPUT,
         @eventData,
         @acl
    IF @ReturnCode <> 0
        GOTO FAILED
IF @ServerTemplate = 200
    BEGIN
        EXEC proc_PostProcessDelMtgListItem
            @SiteId,
            @WebId,
            @ListId,
            @MeetingEventType
    END
FAILED:
    IF (@ReturnCode = 0)
    BEGIN
        EXEC proc_UpdateDiskUsed @SiteId
    END
    IF (@ReturnCode <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @ReturnCode

GO
