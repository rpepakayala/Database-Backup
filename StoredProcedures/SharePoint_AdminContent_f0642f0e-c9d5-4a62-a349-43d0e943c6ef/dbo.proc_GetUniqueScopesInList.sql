/****** Object:  StoredProcedure [dbo].[proc_GetUniqueScopesInList]    Script Date: 5/15/2018 12:12:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetUniqueScopesInList(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @GetAll bit)
AS
    SET NOCOUNT ON
    DECLARE @HasFGP bit
    DECLARE @HasInternalFGP bit
    SELECT 
        @HasFGP = tp_HasFGP,
        @HasInternalFGP = tp_HasInternalFGP
    FROM 
        Lists
    WHERE
        tp_WebId = @WebId AND tp_Id = @ListId
    IF (@HasInternalFGP = 0)
    BEGIN
        SELECT 0x0, NULL, 0x0
        RETURN 0
    END
    DECLARE @ListRoot nvarchar(256),
        @ListRootEscaped nvarchar(1024),
        @ListScopeId uniqueidentifier
    SELECT
        @ListRoot = CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END,
        @ListScopeId = Lists.tp_ScopeId
    FROM
        Lists
    INNER JOIN
        Docs
    ON
        Lists.tp_RootFolder = Docs.Id AND
        1 = Docs.Level
    WHERE
        Lists.tp_WebId = @WebId AND
        Lists.tp_ID = @ListId
    EXEC proc_EscapeForLike @ListRoot, @ListRootEscaped OUTPUT, 1
    IF (@GetAll <> 0)
    BEGIN
        SELECT
            Perms.ScopeId,
            Perms.Acl,
            Perms.AnonymousPermMask
        FROM 
            Perms
        WHERE
            Perms.SiteId = @SiteId AND 
            Perms.DelTransId = 0x AND
            Perms.ScopeUrl LIKE @ListRootEscaped
    END
    ELSE
    BEGIN
        SELECT TOP 1001
            Perms.ScopeId,
            Perms.Acl,
            Perms.AnonymousPermMask
        FROM 
            Perms
        WHERE
            Perms.SiteId = @SiteId AND 
            Perms.DelTransId = 0x AND
            Perms.ScopeUrl LIKE @ListRootEscaped
   END

GO
