/****** Object:  StoredProcedure [dbo].[proc_RenameDirJunctions]    Script Date: 5/15/2018 12:12:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_RenameDirJunctions(
    @SiteId uniqueidentifier,
    @OldUrl nvarchar(256),
    @OldUrlLike nvarchar(1024),
    @NewUrl nvarchar(256)
    )
AS
    SET NOCOUNT ON
    UPDATE
        AllUserDataJunctions
    SET
        tp_DirName = STUFF(tp_DirName, 1, LEN(@OldUrl), @NewUrl)
    WHERE
        tp_SiteId = @SiteId AND
        tp_DeleteTransactionId = 0x AND
        tp_IsCurrentVersion = CAST(1 AS bit) AND
        (tp_DirName = @OldUrl OR tp_DirName LIKE @OldUrlLike)    
    UPDATE
        AllUserDataJunctions
    SET
        tp_DirName = STUFF(tp_DirName, 1, LEN(@OldUrl), @NewUrl)
    WHERE
        tp_SiteId = @SiteId AND
        tp_DeleteTransactionId = 0x AND
        tp_IsCurrentVersion = CAST(0 AS bit) AND
        (tp_DirName = @OldUrl OR tp_DirName LIKE @OldUrlLike)    

GO
