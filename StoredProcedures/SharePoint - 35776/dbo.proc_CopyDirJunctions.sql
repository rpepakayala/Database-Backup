/****** Object:  StoredProcedure [dbo].[proc_CopyDirJunctions]    Script Date: 5/15/2018 12:11:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_CopyDirJunctions(
    @SiteId uniqueidentifier,
    @OldUrl nvarchar(256),
    @OldUrlLike nvarchar(1024),
    @NewUrl nvarchar(256)
    )
AS
    SET NOCOUNT ON
    INSERT INTO UserDataJunctions (
        tp_SiteId,
        tp_DeleteTransactionId,
        tp_IsCurrentVersion,
        tp_DirName,
        tp_LeafName,
        tp_FieldId,
        tp_CalculatedVersion,
        tp_Level,
        tp_UIVersion,
        tp_Id,
        tp_Ordinal
        )
    SELECT
        @SiteId,
        0x,
        CAST(1 AS bit),
        STUFF(tp_DirName, 1, LEN(@OldUrl), @NewUrl),
        tp_LeafName,
        tp_FieldId,
        0,
        tp_Level,
        1,
        tp_Id,
        tp_Ordinal
    FROM
        UserDataJunctions
    WHERE
        tp_SiteId = @SiteId AND
        (tp_DirName = @OldUrl OR tp_DirName LIKE @OldUrlLike) AND
        tp_Level = 1                

GO
