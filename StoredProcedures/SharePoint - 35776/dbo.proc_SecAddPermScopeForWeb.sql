/****** Object:  StoredProcedure [dbo].[proc_SecAddPermScopeForWeb]    Script Date: 5/15/2018 12:12:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecAddPermScopeForWeb(
    @SiteId         uniqueidentifier,
    @ScopeId        uniqueidentifier,
    @RoleDefWebId   uniqueidentifier,
    @WebId          uniqueidentifier,
    @AnonymousPermMask tPermMask,
    @FullUrl        nvarchar(256))
AS
    SET NOCOUNT ON
    BEGIN TRAN
    UPDATE Webs SET CachedNavDirty =1 WHERE SiteId = @SiteId
    INSERT INTO Perms(
        SiteId,
        ScopeId,
        RoleDefWebId,
        WebId,
        ScopeUrl, 
        AnonymousPermMask,
        Acl)
     VALUES(
        @SiteId,
        @ScopeId,
        @RoleDefWebId,
        @WebId,
        @FullUrl,
        @AnonymousPermMask,
        0x01020304)     
    COMMIT TRAN

GO
