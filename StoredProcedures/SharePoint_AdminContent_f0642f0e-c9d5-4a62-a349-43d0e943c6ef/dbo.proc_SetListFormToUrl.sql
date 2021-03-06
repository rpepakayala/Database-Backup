/****** Object:  StoredProcedure [dbo].[proc_SetListFormToUrl]    Script Date: 5/15/2018 12:13:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SetListFormToUrl(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @PageUrl nvarchar(260),
    @PageType tinyint)
AS
    SET NOCOUNT ON
    DECLARE @PageUrlId uniqueidentifier
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    DECLARE @OldFormId uniqueidentifier
    DECLARE @ReturnValue int
    SET @ReturnValue = 0
    EXEC proc_SplitUrl @PageUrl, @DirName OUTPUT, @LeafName OUTPUT
    BEGIN TRAN
    SELECT
        @PageUrlId = Id
    FROM
        Docs WITH (REPEATABLEREAD)
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName
    IF @PageUrlId IS NULL
    BEGIN
        SET @ReturnValue = 126
        GOTO CLEANUP
    END
    UPDATE
        WebParts
    SET
        tp_Flags = tp_Flags & ~(0 | 1048576)
    WHERE
        tp_ListId = @ListId AND
        tp_UserID IS NULL AND
        tp_Type = @PageType
    IF @@ROWCOUNT = 0
    BEGIN
        SET @ReturnValue = 126
        GOTO CLEANUP
    END
    UPDATE
        WebParts
    SET
        tp_Flags = tp_Flags | 1048576
    WHERE
        tp_ListId = @ListId AND
        tp_UserID IS NULL AND
        tp_Type = @PageType AND
        tp_PageUrlId = @PageUrlId
    IF @@ROWCOUNT <> 1
    BEGIN
        SET @ReturnValue = 127
        GOTO CLEANUP
    END
CLEANUP:
    IF (@ReturnValue <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @ReturnValue

GO
