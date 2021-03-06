/****** Object:  StoredProcedure [dbo].[proc_DeleteItemJunctionsVersion]    Script Date: 5/15/2018 12:12:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_DeleteItemJunctionsVersion(
    @ListId uniqueidentifier, 
    @ItemId int,
    @ItemVersion int,
    @DeleteOp int,
    @DeleteTransactionId varbinary(16)
    )
AS
    SET NOCOUNT ON
    DECLARE @SiteId AS uniqueidentifier
    DECLARE @DirName AS nvarchar(256)
    DECLARE @LeafName AS nvarchar(128)
    EXEC proc_ListItemIdToSiteDirLeafName @ListId, @ItemId, @SiteId OUTPUT, @DirName OUTPUT, @LeafName OUTPUT
    IF @DeleteOp = 3
    BEGIN
        DELETE
            UserDataJunctionsVersioned
        WHERE
            tp_SiteId = @SiteId AND
            tp_DirName = @DirName AND
            tp_LeafName = @LeafName AND
            tp_CalculatedVersion = @ItemVersion
    END
    ELSE
    BEGIN
        UPDATE
            AllUserDataJunctions
        SET
            tp_DeleteTransactionId = @DeleteTransactionId
        WHERE
            tp_SiteId = @SiteId AND
            tp_DirName = @DirName AND
            tp_LeafName = @LeafName AND
            tp_IsCurrentVersion = CAST(0 AS bit) AND
            tp_CalculatedVersion = @ItemVersion AND
            tp_DeleteTransactionId = 0x
    END

GO
