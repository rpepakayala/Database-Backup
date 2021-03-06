/****** Object:  StoredProcedure [dbo].[proc_SecGetAclFromScope]    Script Date: 5/15/2018 12:12:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetAclFromScope(
    @SiteId uniqueidentifier,
    @ScopeId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT 
        Acl, AnonymousPermMask
    FROM
        Perms
    WHERE
        SiteId = @SiteId AND
        ScopeId = @ScopeId

GO
