/****** Object:  StoredProcedure [dbo].[proc_SecLogChange]    Script Date: 5/15/2018 12:12:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecLogChange(
    @SiteId         uniqueidentifier,
    @WebId          uniqueidentifier,
    @ScopeId        uniqueidentifier,
    @ScopeUrl       nvarchar(260),
    @RoleId         int,
    @PrincipalId    int,
    @EventType      int,
    @OpCode         int,
    @ItemName       nvarchar(255) = NULL)
AS
    SET NOCOUNT ON
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    DECLARE @Type tinyint
    DECLARE @ListId uniqueidentifier
    DECLARE @DocId uniqueidentifier
    DECLARE @ItemId int
    DECLARE @ObjectType int
    DECLARE @Int1 int
    IF (@ScopeUrl IS NULL)
    BEGIN
        SELECT 
            @ScopeUrl = ScopeUrl
        FROM
            Perms
        WHERE
            SiteId = @SiteId AND
            ScopeId = @ScopeId
        IF (@ScopeUrl IS NULL)
            RETURN 3
    END                
    EXEC proc_SplitUrl
            @ScopeUrl,
            @DirName OUTPUT,
            @LeafName OUTPUT
    SELECT 
        @Type = Type,
        @ListId = ListId,
        @ItemId = DoclibRowId,
        @DocId = Id
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName
    IF (@Type IS NULL)
        RETURN 3
    IF (@Type = 2)
    BEGIN
        SET @ObjectType = 4
        SET @DocId = NULL
    END
    ELSE IF (@ListId IS NOT NULL)
    BEGIN 
        IF (@ItemId IS NOT NULL)
        BEGIN
            SET @ObjectType = 1
        END
        ELSE
        BEGIN
            SET @ObjectType = 2
            SET @DocId = NULL
        END
    END
    ELSE
        RETURN 3
    SET @Int1 = @RoleId
    IF (@OpCode IS NOT NULL)
        SET @Int1 = @OpCode
    EXEC proc_LogChange @SiteId, @WebId, @ListId,
                @ItemId, @DocId, @ScopeId, @PrincipalId, @ScopeUrl, @EventType, @ObjectType, NULL, @ItemName, @Int1

GO
