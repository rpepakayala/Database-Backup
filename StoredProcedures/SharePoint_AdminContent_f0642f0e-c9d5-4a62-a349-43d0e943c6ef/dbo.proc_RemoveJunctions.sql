/****** Object:  StoredProcedure [dbo].[proc_RemoveJunctions]    Script Date: 5/15/2018 12:12:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_RemoveJunctions(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @FieldId uniqueidentifier,
    @DeleteTransactionId varbinary(16) = 0x,
    @Level tinyint = 1,
    @IsCurrentVersion bit = 1,
    @CalculatedVersion int = 0
    )
AS
    SET NOCOUNT ON
    DELETE
        AllUserDataJunctions
    WHERE
        tp_SiteId = @SiteId AND
        tp_DirName = @DirName AND
        tp_LeafName = @LeafName AND
        tp_FieldId = @FieldId AND
        tp_DeleteTransactionId = @DeleteTransactionId AND
        tp_Level = @Level AND
        tp_IsCurrentVersion = @IsCurrentVersion AND
        tp_CalculatedVersion = @CalculatedVersion

GO
