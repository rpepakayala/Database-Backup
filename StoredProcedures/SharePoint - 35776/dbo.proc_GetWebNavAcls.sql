/****** Object:  StoredProcedure [dbo].[proc_GetWebNavAcls]    Script Date: 5/15/2018 12:12:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetWebNavAcls(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @NavParentWebId uniqueidentifier,
    @Inherited bit)
AS
    SET NOCOUNT ON
    IF @NavParentWebId IS NOT NULL
    BEGIN
        DECLARE @NavParentScopeId uniqueidentifier
        SELECT
            @NavParentScopeId = ScopeId
        FROM
            Webs
        WHERE
            SiteId = @SiteId AND
            Id = @NavParentWebId
        SELECT
            Perms.ScopeId,
            Perms.Acl,
            Perms.AnonymousPermMask
        FROM
            Perms
        WHERE
            Perms.SiteId = @SiteId AND
            (Perms.ScopeId <> @WebId) AND
            (Perms.ScopeId IN
                (   SELECT DISTINCT Docs.ScopeId
                    FROM
                        NavNodes
                    INNER JOIN
                        Docs
                    ON
                        NavNodes.DocId = Docs.Id AND
                        Docs.Level = 1
                    WHERE
                        NavNodes.SiteId = @SiteId AND
                        (NavNodes.WebId = @WebId OR NavNodes.WebId = @NavParentWebId ))
             OR Perms.ScopeId=@NavParentScopeId)
    END
    ELSE
    BEGIN
        DECLARE @WebScopeId uniqueidentifier
        IF @Inherited=0
        BEGIN
            SELECT
                @WebScopeId = ScopeId
            FROM
                Webs
            WHERE
                 SiteId = @SiteId AND
                 Id = @WebId
        END
        SELECT
            Perms.ScopeId,
            Perms.Acl,
            Perms.AnonymousPermMask
        FROM
            Perms
        WHERE
            Perms.SiteId = @SiteId AND
            (Perms.ScopeId <> @WebScopeId OR @WebScopeId IS NULL) AND
            Perms.ScopeId IN
                (   SELECT DISTINCT Docs.ScopeId
                    FROM
                        NavNodes WITH (NOLOCK)
                    INNER JOIN
                        Docs WITH (NOLOCK)
                    ON
                        NavNodes.DocId = Docs.Id AND
                        Docs.Level = 1
                    WHERE
                        NavNodes.SiteId = @SiteId AND
                        NavNodes.WebId = @WebId )
    END

GO
