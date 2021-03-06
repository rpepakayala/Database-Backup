/****** Object:  StoredProcedure [dbo].[proc_DeplExportRoleAssignments]    Script Date: 5/15/2018 12:12:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplExportRoleAssignments(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @WssGroupOnly bit,
    @ScopeIdCur uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @ScopeId uniqueidentifier
    DECLARE @Id uniqueidentifier
    DECLARE @ListId uniqueidentifier
    DECLARE @ObjectId uniqueidentifier
    DECLARE @ObjectType int
    DECLARE @Type tinyint
    DECLARE @ScopeUrl nvarchar(256)
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    SELECT TOP 1
        @ScopeId = ScopeId,
        @ScopeUrl = ScopeUrl
    FROM
        Perms
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        ScopeId > @ScopeIdCur AND
        DelTransId = 0x
    ORDER BY
        SiteId, ScopeId
    EXEC proc_SplitUrl @ScopeUrl, @DirName OUTPUT, @LeafName OUTPUT
    SELECT
        @Id = Id,
        @ListId = ListId,
        @Type = Type
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        LeafName = @LeafName AND
        DirName = @DirName
    EXEC proc_DeplScopeTypeFromDocType @SiteId, @WebId, @ListId, @Id, @Type,
                @ObjectType OUTPUT, @ObjectId OUTPUT
    SELECT
        P.SiteId,
        P.WebId,
        P.ScopeId,
        P.RoleDefWebId,
        W.FullUrl,
        @ObjectId,
        @ObjectType,
        @ScopeUrl,
        P.AnonymousPermMask
   FROM
        Perms AS P
   INNER JOIN
        Webs AS W
   ON
        W.SiteId = P.SiteId AND
        W.Id = P.RoleDefWebId
   WHERE
        P.SiteId = @SiteId AND
        P.WebId = @WebId AND
        P.ScopeId = @ScopeId
    IF (@WssGroupOnly = 1)
    BEGIN
        SELECT
            R.RoleId,
            R.PrincipalId,
            U.tp_Id
        FROM
            RoleAssignment AS R
        LEFT OUTER JOIN
            UserInfo AS U
        ON
            U.tp_SiteId = R.SiteId AND
            U.tp_Id = R.PrincipalId
        WHERE
            R.SiteId = @SiteId AND
            R.ScopeId = @ScopeId AND
            U.tp_Id IS NOT NULL
        ORDER BY
            R.RoleId, R.PrincipalId
    END
    ELSE
    BEGIN
        SELECT
            R.RoleId,
            R.PrincipalId,
            U.tp_Id
        FROM
            RoleAssignment AS R
        LEFT OUTER JOIN
            UserInfo AS U
        ON
            U.tp_SiteId = R.SiteId AND
            U.tp_Id = R.PrincipalId
        WHERE
            R.SiteId = @SiteId AND
            R.ScopeId = @ScopeId
        ORDER BY
            R.RoleId, R.PrincipalId
    END

GO
