/****** Object:  StoredProcedure [dbo].[proc_SetCommentAttribs]    Script Date: 5/15/2018 12:12:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SetCommentAttribs(
    @SiteId uniqueidentifier,
    @DocFullUrl nvarchar(260),
    @Id int,
    @Subject nvarchar(255),
    @Status smallint,
    @Comment ntext,
    @Size int,
    @UserTitle nvarchar(255))
AS
    SET NOCOUNT ON
    DECLARE @WebId uniqueidentifier
    DECLARE @DocId uniqueidentifier
    DECLARE @ListId uniqueidentifier
    DECLARE @ItemId int
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    EXEC proc_SplitUrl @DocFullUrl, @DirName OUTPUT, @LeafName OUTPUT
    SELECT
        @WebId = Docs.WebId,
        @DocId = Docs.Id,
        @ListId = Docs.ListId,
        @ItemId = Docs.DoclibRowId
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName
    IF @DocId IS NULL
    BEGIN
        RETURN 3
    END
    DECLARE @SizeOld int
    SELECT
        @SizeOld = Size
    FROM
        ComMd
    WHERE
        SiteId = @SiteId AND
        DocId = @DocId AND
        Id = @Id
    IF @SizeOld IS NULL
    BEGIN
        RETURN 3
    END
    IF (@Size IS NOT NULL AND @Size > @SizeOld)
    BEGIN
        DECLARE @quotaOrLockStatus int
        SELECT @quotaOrLockStatus = dbo.fn_IsOverQuotaOrWriteLocked(@SiteId)
        IF (@quotaOrLockStatus = 1)
        BEGIN
            RETURN 1816
        END
        ELSE IF (@quotaOrLockStatus > 1)
        BEGIN
            RETURN 212
        END
    END
    UPDATE
        ComMd
    SET
        Subject = CASE WHEN @Subject IS NULL THEN
            Subject ELSE @Subject END,
        Status = CASE WHEN @Status IS NULL THEN
            Status ELSE @Status END,
        Comment = CASE WHEN @Comment IS NULL THEN
            Comment ELSE @Comment END,
        Size = CASE WHEN @Size IS NULL THEN
            Size ELSE @Size END
    WHERE
        SiteId = @SiteId AND
        DocId = @DocId AND
        Id = @Id
    IF @@ROWCOUNT <> 0
    BEGIN
        IF @ItemId IS NOT NULL
        BEGIN
            DECLARE @Updated datetime
            SET @Updated = GETUTCDATE()
            DECLARE @EventType int
            SET @EventType =
                CASE
                    WHEN @Status = 8 THEN 256
                    WHEN @Status = 2 THEN 128
                    ELSE 32
                END
            EXEC proc_AddEventToCache
                @SiteId,
                @WebId,
                @ListId,
                @ItemId,
                @LeafName,
                @DocFullUrl,
                @DocId,
                @EventType,
                @UserTitle,
                @Updated,
                NULL,
                NULL
        END
        IF (@Size IS NOT NULL)
        BEGIN
            SET @SizeOld = @Size - @SizeOld
            EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp
                @SiteId, @SizeOld, 0
        END
    END
    RETURN 0

GO
