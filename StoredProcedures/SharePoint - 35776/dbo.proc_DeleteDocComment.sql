/****** Object:  StoredProcedure [dbo].[proc_DeleteDocComment]    Script Date: 5/15/2018 12:11:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteDocComment(
    @SiteId uniqueidentifier,
    @DocFullUrl nvarchar(260),
    @Id int,
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
    DECLARE @RowsAffected int
    SET @RowsAffected = 0
    IF EXISTS (
        SELECT
            *
        FROM
            ComMd
        WHERE
            SiteId = @SiteId AND
            DocId = @DocId AND
            ParentId = @Id)
    BEGIN
        DECLARE @Size int
        SELECT
            @Size = Size
        FROM
            ComMd
        WHERE
            SiteId = @SiteId AND
            DocId = @DocId AND
            Id = @Id
        IF @Size IS NULL
        BEGIN
            RETURN 3
        END
        UPDATE
            ComMd
        SET
            CommentID = N'',
            Author = N'',
            Subject = N'',
            Created = GETUTCDATE(),
            Status = 1,
            Comment = N'',
            Size = 0
        WHERE
            SiteId = @SiteId AND
            DocId = @DocId AND
            Id = @Id
        SET @RowsAffected = @@ROWCOUNT
        IF @RowsAffected <> 0
        BEGIN
            SET @Size = -@Size
            EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp
                @SiteId, @Size, 0
        END
    END
    ELSE
    BEGIN
        BEGIN TRAN
        DELETE FROM
            ComMd
        WHERE
            SiteId = @SiteId AND
            DocId = @DocId AND
            Id = @Id
        SET @RowsAffected = @@ROWCOUNT
        DECLARE @Rows int
        SELECT @Rows = 1
        WHILE @Rows > 0
        BEGIN
            DELETE FROM
                ComMd
            WHERE
                ComMd.SiteId = @SiteId AND
                ComMd.DocId = @DocId AND
                ComMd.Status = 1 AND NOT EXISTS (
                    SELECT
                        *
                    FROM
                        ComMd ComMd2
                    WHERE
                        ComMd2.SiteId = @SiteId AND
                        ComMd2.DocId = @DocId AND
                        ComMd2.ParentId = ComMd.Id )
            SELECT @Rows = @@ROWCOUNT
        END
        COMMIT TRAN
    END
    IF @RowsAffected <> 0 AND @ItemId IS NOT NULL
    BEGIN
        DECLARE @Deleted datetime
        SET @Deleted = GETUTCDATE()
        EXEC proc_AddEventToCache
            @SiteId,
            @WebId,
            @ListId,
            @ItemId,
            @LeafName,
            @DocFullUrl,
            @DocId,
            64,
            @UserTitle,
            @Deleted,
            NULL,
            NULL
    END
    RETURN 0

GO
