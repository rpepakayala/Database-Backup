/****** Object:  StoredProcedure [dbo].[proc_AddDocComment]    Script Date: 5/15/2018 12:12:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddDocComment(
    @SiteId uniqueidentifier,
    @DocFullUrl nvarchar(260),
    @ParentId int,
    @CommentId nvarchar(255),
    @Bookmark nvarchar(127),
    @Author nvarchar(255),
    @Subject nvarchar(255),
    @Status smallint,
    @Comment ntext,
    @Size int,
    @UserId int,
    @UserTitle nvarchar(255),
    @Created datetime)
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
        @WebId = WebId,
        @DocId = Id,
        @ListId = ListId,
        @ItemId = DoclibRowId
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName
    IF @SiteId IS NULL OR @DocId IS NULL
    BEGIN
        RETURN 3
    END
        IF (@Size <> 0)
        BEGIN
            DECLARE @quotaOrLockStatus int
            SELECT  @quotaOrLockStatus =
                dbo.fn_IsOverQuotaOrWriteLocked(@SiteId)
            IF (@quotaOrLockStatus = 1)
            BEGIN
                RETURN 1816
            END
            ELSE IF (@quotaOrLockStatus > 1)
            BEGIN
                RETURN 212
            END
        END
    IF @ParentId <> 0
    BEGIN
        IF NOT EXISTS(
            SELECT
                *
            FROM
                ComMd
            WHERE
                SiteId = @SiteId AND
                DocId = @DocId AND
                Id = @ParentId)
        BEGIN
            SELECT @ParentId = 0
        END
    END
    IF @Created IS NULL
    BEGIN
        SELECT @Created = GETUTCDATE()
    END
    DECLARE @Id int
    DECLARE @Tries int
    DECLARE @ReturnStatus int
    DECLARE @RowsAffected int
    SELECT @Tries = 0
    SELECT @ReturnStatus = 0
    SELECT @RowsAffected = 0
    WHILE @Tries < 10
    BEGIN
        SELECT
            @Id = MAX(Id) + 1
        FROM
            ComMd
        WHERE
            SiteId = @SiteId AND
            DocId = @DocId
        IF @Id IS NULL
        BEGIN
            SELECT @Id = 1
        END
        INSERT INTO ComMd(
            SiteId,
            DocId,
            Id,
            ParentId,
            CommentId,
            Bookmark,
            Author,
            UserId,
            Subject,
            Created,
            Status,
            Comment,
            Size)
        VALUES (
            @SiteId,
            @DocId,
            @Id,
            @ParentId,
            @CommentId,
            @Bookmark,
            @Author,
            @UserId,
            @Subject,
            @Created,
            @Status,
            @Comment,
            @Size)
        SELECT @ReturnStatus = @@ERROR
        SELECT @RowsAffected = @@ROWCOUNT
        IF @ReturnStatus = 0
        BEGIN
            IF @RowsAffected <> 0
            BEGIN
                IF @ItemId IS NOT NULL
                BEGIN
                    EXEC proc_AddEventToCache
                        @SiteId,
                        @WebId,
                        @ListId,
                        @ItemId,
                        @LeafName,
                        @DocFullUrl,
                        @DocId,
                        16,
                        @UserTitle,
                        @Created,
                        NULL,
                        NULL
                END
                EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp
                    @SiteId, @Size, 0
            END
            BREAK
        END
        SELECT @Tries = @Tries + 1
    END
    SELECT
        @Created,
        @Id
    RETURN @ReturnStatus

GO
