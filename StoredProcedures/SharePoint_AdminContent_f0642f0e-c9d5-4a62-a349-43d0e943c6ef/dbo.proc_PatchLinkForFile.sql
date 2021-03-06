/****** Object:  StoredProcedure [dbo].[proc_PatchLinkForFile]    Script Date: 5/15/2018 12:12:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_PatchLinkForFile
(
    @SiteId             uniqueidentifier,
    @WebId              uniqueidentifier,
    @DirName            nvarchar(256),
    @LeafName           nvarchar(128),
    @OldLinkDirName     nvarchar(256),
    @OldLinkLeafName    nvarchar(128),
    @OldServerRel       bit,
    @NewLinkDirName     nvarchar(256),
    @NewLinkLeafName    nvarchar(128),
    @NewServerRel       bit,
    @PatchPrefix        bit,
    @DocUpdateFlags     int
)
AS
    SET NOCOUNT ON
    DECLARE @Ret int
    SET @Ret = 0
    DECLARE @FullUrl nvarchar(260)
    DECLARE @OldLink nvarchar(260)
    DECLARE @NewLink nvarchar(260)
    DECLARE @OldLinkLike nvarchar(1024)
    SET @FullUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END
    SET @OldLink = CASE WHEN (DATALENGTH(@OldLinkDirName) = 0) THEN @OldLinkLeafName WHEN (DATALENGTH(@OldLinkLeafName) = 0) THEN @OldLinkDirName ELSE @OldLinkDirName + N'/' + @OldLinkLeafName END
    SET @NewLink = CASE WHEN (DATALENGTH(@NewLinkDirName) = 0) THEN @NewLinkLeafName WHEN (DATALENGTH(@NewLinkLeafName) = 0) THEN @NewLinkDirName ELSE @NewLinkDirName + N'/' + @NewLinkLeafName END
    EXEC proc_EscapeForLike @OldLink, @OldLinkLike OUTPUT
    DECLARE @Now datetime
    SELECT @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE());
    DECLARE @HasListLinks bit
    SET @HasListLinks = 0
    DECLARE @ListId uniqueidentifier
    BEGIN TRAN
    UPDATE
        Docs
    SET
        NextToLastTimeModified = CASE
                WHEN @DocUpdateFlags & 8192 = 0
                THEN TimeLastModified 
                ELSE NextToLastTimeModified
            END,
        TimeLastModified = CASE
                WHEN @DocUpdateFlags & 8192 = 0
                THEN @Now
                ELSE TimeLastModified
            END,
        MetaInfoTimeLastModified = @Now,
        Dirty = 1,
        CacheParseId = NULL
    WHERE
        SiteId    = @SiteId AND
        DirName   = @DirName AND
        LeafName  = @LeafName AND
        WebId     = @WebId
    IF (@@ERROR <> 0) OR (@@ROWCOUNT = 0)
    BEGIN
        SET @Ret = 3
        GOTO cleanup
    END
    EXEC proc_DirtyDependents @SiteId, 1, @FullUrl
    UPDATE
        Docs
    SET
        ListDataDirty = 1
    FROM
        Docs
    INNER JOIN
        Links
    ON
        Docs.SiteId = Links.SiteId AND
        Docs.DirName = Links.DirName AND
        Docs.LeafName = Links.LeafName AND
        Docs.Level = Links.Level
    WHERE
        Links.SiteId = @SiteId AND
        Links.DirName = @DirName AND
        Links.LeafName = @LeafName AND
        Links.FieldId IS NOT NULL AND
        Links.TargetDirName = @OldLinkDirName AND
        Links.TargetLeafName = @OldLinkLeafName
    IF @@ROWCOUNT <> 0
    BEGIN
        SET @HasListLinks = 1
    END
    UPDATE
        Links
    SET
        ServerRel = @NewServerRel,
        TargetDirName = LEFT(@NewLinkDirName, 256),
        TargetLeafName = @NewLinkLeafName
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        TargetDirName = @OldLinkDirName AND
        TargetLeafName = @OldLinkLeafName
    IF (@@ERROR <> 0)
    BEGIN
        SET @Ret = 1150
        GOTO cleanup
    END
    IF @PatchPrefix = 1 AND @OldServerRel = 1 AND @NewServerRel = 1
    BEGIN
        UPDATE
            Docs
        SET
            ListDataDirty = 1
        FROM
            Docs
        INNER JOIN
            Links
        ON
            Docs.SiteId = Links.SiteId AND
            Docs.DirName = Links.DirName AND
            Docs.LeafName = Links.LeafName AND
            Docs.Level = Links.Level
        WHERE
            Links.SiteId = @SiteId AND
            Links.DirName = @DirName AND
            Links.LeafName = @LeafName AND
            Links.FieldId IS NOT NULL AND
            Links.TargetDirName = @OldLink
        IF @@ROWCOUNT <> 0
        BEGIN
            SET @HasListLinks = 1
        END
        UPDATE
            Links
        SET
            TargetDirName = LEFT(STUFF(TargetDirName, 1, LEN(@OldLink), @NewLink), 256)
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName AND
            TargetDirName = @OldLink
        IF (@@ERROR <> 0 )
        BEGIN
            SET @Ret = 1150
            GOTO cleanup
        END
        UPDATE
            Docs
        SET
            ListDataDirty = 1
        FROM
            Docs
        INNER JOIN
            Links
        ON
            Docs.SiteId = Links.SiteId AND
            Docs.DirName = Links.DirName AND
            Docs.LeafName = Links.LeafName AND
            Docs.Level = Links.Level
        WHERE
            Links.SiteId = @SiteId AND
            Links.DirName = @DirName AND
            Links.LeafName = @LeafName AND
            Links.FieldId IS NOT NULL AND
            Links.TargetDirName LIKE @OldLinkLike
        IF @@ROWCOUNT <> 0
        BEGIN
            SET @HasListLinks = 1
        END
        UPDATE
            Links
        SET
            TargetDirName = LEFT(STUFF(TargetDirName, 1, LEN(@OldLink), @NewLink), 256)
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName AND
            TargetDirName LIKE @OldLinkLike
        IF (@@ERROR <> 0 )
        BEGIN
            SET @Ret = 1150
            GOTO cleanup
        END
    END
    IF @HasListLinks = 1
    BEGIN
        SELECT TOP 1
            @ListId = Docs.ListId
        FROM
            Docs
        WHERE
            Docs.SiteId = @SiteId AND
            Docs.DirName = @DirName AND
            Docs.LeafName = @LeafName
        IF @ListId IS NULL
        BEGIN
            SET @Ret = 1150
            GOTO cleanup
        END
        UPDATE
            Lists
        SET
            tp_ListDataDirty = tp_ListDataDirty | 1,
            tp_CacheParseId = NULL
        WHERE
            tp_WebId = @WebId AND
            tp_ID = @ListId
    END
cleanup:
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Ret

GO
