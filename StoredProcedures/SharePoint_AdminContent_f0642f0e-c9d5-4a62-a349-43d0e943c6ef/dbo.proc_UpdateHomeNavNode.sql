/****** Object:  StoredProcedure [dbo].[proc_UpdateHomeNavNode]    Script Date: 5/15/2018 12:13:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateHomeNavNode(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @NewWelcomeName nvarchar(128)
    )
AS
    DECLARE @WebId uniqueidentifier
    DECLARE @Type tinyint
    DECLARE @ClearedHome bit
    DECLARE @SetHome bit
    SET @SetHome = 0
    DECLARE @DirDirName nvarchar(256)
    DECLARE @DirLeafName nvarchar(128)
    EXEC proc_SplitUrl @DirName, @DirDirName OUTPUT, @DirLeafName OUTPUT
    SELECT
        @WebId = WebId,
        @Type = Type
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirDirName AND
        LeafName = @DirLeafName
    IF @WebId IS NULL
        RETURN 0
    EXEC proc_UnsetHomeNavNode @SiteId, @WebId, @DirName, @LeafName,
        @ClearedHome OUTPUT
    IF @Type = 2 AND @NewWelcomeName IS NOT NULL
        EXEC proc_SetHomeNavNode @SiteId, @WebId, @DirName, @NewWelcomeName,
            @SetHome OUTPUT
    IF @ClearedHome = 1 OR @SetHome = 1
    BEGIN
        EXEC proc_DirtyDependents @SiteId, 4, N'L:H'
    END
    RETURN 0

GO
