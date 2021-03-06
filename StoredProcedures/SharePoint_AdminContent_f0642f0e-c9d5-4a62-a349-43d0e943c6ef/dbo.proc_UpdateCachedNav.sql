/****** Object:  StoredProcedure [dbo].[proc_UpdateCachedNav]    Script Date: 5/15/2018 12:13:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateCachedNav(
    @WebId uniqueidentifier,
    @NavParentWebId uniqueidentifier,
    @CachedNavData image,
    @CachedInheritedNavData image,
    @CachedNavScopeData ntext,
    @NavParentCachedNavData image,
    @NavParentCachedScopeData ntext,
    @CachedNavDirty int,
    @CachedDataVersion int,
    @NavParentCachedDataVersion int)
AS
    SET NOCOUNT ON
    IF @NavParentCachedNavData IS NOT NULL
    BEGIN
        UPDATE
            Webs
        SET
            CachedNav = @NavParentCachedNavData,
            CachedInheritedNav = @CachedInheritedNavData,
            CachedNavScope = @NavParentCachedScopeData,
            CachedNavDirty = @CachedNavDirty,
            CachedDataVersion = CachedDataVersion + 1
        WHERE
            Id = @NavParentWebId AND
            CachedNavDirty = 1 AND
            CachedDataVersion = @NavParentCachedDataVersion
    END
    UPDATE
        Webs
    SET
        CachedNav = @CachedNavData,
        CachedInheritedNav = @CachedInheritedNavData,
        CachedNavScope = @CachedNavScopeData,
        CachedNavDirty = @CachedNavDirty,
        CachedDataVersion = @CachedDataVersion + 1
    WHERE
        Id = @WebId AND
        CachedDataVersion = @CachedDataVersion
    IF @@ROWCOUNT = 1
    BEGIN
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN 1150
    END

GO
