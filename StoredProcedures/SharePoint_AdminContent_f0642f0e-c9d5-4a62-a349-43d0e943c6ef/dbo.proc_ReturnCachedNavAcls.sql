/****** Object:  StoredProcedure [dbo].[proc_ReturnCachedNavAcls]    Script Date: 5/15/2018 12:12:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ReturnCachedNavAcls(
    @DocSiteId   uniqueidentifier,
    @Webs_Id     uniqueidentifier,
    @Webs_NavParentWebId uniqueidentifier)
AS    
    SET NOCOUNT ON
    DECLARE @ret int
    DECLARE @CachedNavDirty int
    DECLARE @HasScopeCache bit
    SELECT 
        @CachedNavDirty = CachedNavDirty,
        @HasScopeCache = CASE WHEN CachedNavScope IS NULL THEN 0 ELSE 1 END
    FROM
        Webs
    WHERE
        Id = @Webs_Id
    IF (@CachedNavDirty = 0 AND
         (@HasScopeCache = 1 OR @Webs_NavParentWebId IS NOT NULL))
    BEGIN
        EXEC @ret = proc_GetWebNavAclsForCachedScope
            @DocSiteId, @Webs_Id, @Webs_NavParentWebId
        IF (@ret <> 0)
        BEGIN
            RETURN @ret
        END
    END
    ELSE
    BEGIN
        SELECT 
            NULL
        WHERE
            1 = 0
    END
    RETURN 0

GO
