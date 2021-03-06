/****** Object:  StoredProcedure [dbo].[proc_PutWebNavStructNode]    Script Date: 5/15/2018 12:12:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_PutWebNavStructNode(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @Eid int,
    @EidBase int,
    @EidHome int,
    @DateModified datetime = NULL,
    @DirName nvarchar(256) = NULL,
    @LeafName nvarchar(128) = NULL,
    @UrlExternal nvarchar(260) = NULL,
    @Name nvarchar(256) = NULL,
    @SetMetaInfo bit = 0,
    @NodeMetainfo image = NULL,
    @NonNavPage bit = NULL,
    @NavSequence bit = NULL,
    @WantOldName bit = 0,
    @@DateModifiedReally datetime OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @ElementType int
    DECLARE @NavSequenceTemp bit
    DECLARE @EidParent int
    DECLARE @OldName nvarchar(256)
    EXEC proc_TranslateTempEid @Eid, @EidBase, @EidHome, @Eid OUTPUT
    SELECT
        @ElementType = ElementType,
        @NavSequenceTemp = NavSequence,
        @EidParent = EidParent,
        @OldName = Name,
        @@DateModifiedReally = DateLastModified
    FROM
        NavNodes
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        Eid = @Eid
    IF @ElementType IS NULL
        RETURN 10005
    ELSE IF @DateModified IS NOT NULL AND
        @@DateModifiedReally <> @DateModified
        RETURN 10004
    DECLARE @DocId uniqueidentifier
    IF @DirName IS NOT NULL AND
        @LeafName IS NOT NULL AND
        @ElementType <> 1 AND 
        @NavSequenceTemp = 0
    BEGIN
        SELECT
            @DocId = Id
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName AND
            Level = 1
        IF @DocId IS NULL
            RETURN 10007
        SET @UrlExternal = NULL
    END
    SET @@DateModifiedReally = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    EXEC proc_NavStructLockWebsDirtyPageDependents @SiteId, @WebId
    UPDATE
        NavNodes
    SET
        Url = ISNULL(@UrlExternal, Url),
        DocId = ISNULL(@DocId, DocId),
        Name = ISNULL(@Name, Name),
        NodeMetainfo = CASE WHEN @SetMetaInfo = 1
            THEN @NodeMetainfo
            ELSE NodeMetainfo
            END,
        NonNavPage = ISNULL(@NonNavPage, NonNavPage),
        NavSequence = ISNULL(@NavSequence, NavSequence),
        DateLastModified = @@DateModifiedReally
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        Eid = @Eid AND
        (@DateModified IS NULL OR
            DateLastModified = @DateModified) 
    IF @@RowCount <> 1
        RETURN 10006
    EXEC proc_NavStructDirtyPageDependents @SiteId, @WebId, @EidParent
    IF @WantOldName = 1
    BEGIN
        SELECT @OldName
    END
    DECLARE @ret int
    EXEC @ret = proc_GetWebNavStructNodeByIds @SiteId, @WebId, @Eid
    RETURN @ret

GO
