/****** Object:  StoredProcedure [dbo].[proc_NavStructMoveNode]    Script Date: 5/15/2018 12:12:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_NavStructMoveNode(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @Eid int,
    @EidParentNew int,
    @EidPrevSib int,
    @DateModified datetime,
    @EidBase int,
    @EidHome int,
    @@DateModifiedReally datetime OUTPUT)
AS
    SET NOCOUNT ON
    EXEC proc_TranslateTempEid @Eid, @EidBase, @EidHome, @Eid OUTPUT
    EXEC proc_TranslateTempEid @EidParentNew, @EidBase, @EidHome, @EidParentNew OUTPUT
    EXEC proc_TranslateTempEid @EidPrevSib, @EidBase, @EidHome, @EidPrevSib OUTPUT
    DECLARE @EidParentOld int
    DECLARE @RankChildOld int
    DECLARE @ChildOfSequence bit
    SELECT
        @EidParentOld = EidParent,
        @RankChildOld = RankChild,
        @@DateModifiedReally = DateLastModified
    FROM
        NavNodes
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        Eid = @Eid
    IF @EidParentOld IS NULL
    BEGIN
        RETURN 10005
    END
    IF @DateModified IS NOT NULL AND
        @@DateModifiedReally <> @DateModified
    BEGIN
        RETURN 10004
    END
    EXEC proc_NavStructDirtyPageDependents @SiteId, @WebId, @EidParentNew
    EXEC proc_NavStructDirtyPageDependents @SiteId, @WebId, @EidParentOld
    DECLARE @ret int
    DECLARE @RankChildNew int
    EXEC @ret = proc_NavStructOpenSpaceUnderParent @SiteId, @WebId,
        @EidParentNew, @EidPrevSib, @RankChildNew OUTPUT,
        @ChildOfSequence OUTPUT
    IF @ret <> 0
    BEGIN
        RETURN @ret
    END
    SET @@DateModifiedReally = dbo.fn_RoundDateToNearestSecond(GETUTCDATE());
    UPDATE
        NavNodes
    SET 
        EidParent = @EidParentNew,
        RankChild = @RankChildNew,
        DateLastModified = @@DateModifiedReally,
        ChildOfSequence = @ChildOfSequence
    WHERE 
        SiteId = @SiteId AND
        WebId = @WebId AND
        Eid = @Eid
    IF @@RowCount <> 1
    BEGIN
        RETURN 10006   
    END
    EXEC @ret = proc_NavStructCloseSpaceUnderParent @SiteId, @WebId,
        @EidParentOld, @RankChildOld
    IF @ret <> 0
    BEGIN
        RETURN @ret    
    END
    EXEC @ret = proc_GetWebNavStructNodeByIds @SiteId, @WebId, @Eid
    RETURN @ret

GO
