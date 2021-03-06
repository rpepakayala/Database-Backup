/****** Object:  StoredProcedure [dbo].[proc_GetRecycleBinItemInfo]    Script Date: 5/15/2018 12:12:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetRecycleBinItemInfo(
    @SiteId uniqueidentifier,
    @DeleteTransactionId varbinary(16),
    @ItemType int OUTPUT,
    @ContainingListDeleted bit OUTPUT,
    @ContainingListName nvarchar(255) OUTPUT,
    @DirName nvarchar(256) OUTPUT,
    @WebUrl nvarchar(256) OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @ListId uniqueidentifier
    SELECT
        @ItemType = ItemType,
        @ListId = ListId,
        @DirName = DirName,
        @WebUrl = (SELECT FullUrl FROM Webs WHERE Id = WebId)
    FROM
        RecycleBin
    WHERE
        SiteId = @SiteId AND
        DeleteTransactionId = @DeleteTransactionId
    IF (@@ROWCOUNT <> 1)
        RETURN 1168
    SET @ContainingListDeleted = 0
    SET @ContainingListName = NULL
    IF (@ListId IS NOT NULL AND @ItemType <> 4)
    BEGIN
        SET @ContainingListName = @ListId
        IF (NOT EXISTS(
            SELECT
                *
            FROM
                Lists
            WHERE
                tp_Id = @ListId))
        BEGIN        
            SET @ContainingListDeleted = 1
        END
    END
    RETURN 0

GO
