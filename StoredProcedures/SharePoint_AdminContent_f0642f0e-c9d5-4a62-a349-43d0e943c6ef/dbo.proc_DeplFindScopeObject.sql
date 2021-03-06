/****** Object:  StoredProcedure [dbo].[proc_DeplFindScopeObject]    Script Date: 5/15/2018 12:12:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplFindScopeObject(
    @SiteId uniqueidentifier,
    @ObjectUrl nvarchar(260),
    @ObjectType int,
    @ObjectId uniqueidentifier OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @Type tinyint
    DECLARE @ScopeType int
    DECLARE @Id uniqueidentifier
    DECLARE @WebId uniqueidentifier
    DECLARE @ListId uniqueidentifier
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    EXEC proc_SplitUrl @ObjectUrl, @DirName OUTPUT, @LeafName OUTPUT
    SELECT
        @Id = Id,
        @WebId = WebId,
        @ListId = ListId,
        @Type = Type
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        LeafName = @LeafName AND
        DirName = @DirName
    IF @@ROWCOUNT = 0
        RETURN 2
    EXEC proc_DeplScopeTypeFromDocType @SiteId, @WebId, @ListId, @Id, @Type, @ScopeType OUTPUT, @ObjectId OUTPUT
    IF (@ScopeType <> @ObjectType)
        RETURN 2

GO
