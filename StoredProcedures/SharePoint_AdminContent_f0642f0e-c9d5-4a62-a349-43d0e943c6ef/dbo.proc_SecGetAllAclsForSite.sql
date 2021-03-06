/****** Object:  StoredProcedure [dbo].[proc_SecGetAllAclsForSite]    Script Date: 5/15/2018 12:12:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetAllAclsForSite(
    @SiteId uniqueidentifier,
    @MaxCount int,
    @RowCount int out)
AS
    SET NOCOUNT ON
    SELECT @RowCount = count(*)
        FROM perms WHERE SiteId = @SiteId
    if @RowCount > @MaxCount
        return
    SELECT
        ScopeId, Acl, AnonymousPermMask
    FROM
        Perms
    WHERE
        SiteId = @SiteId

GO
