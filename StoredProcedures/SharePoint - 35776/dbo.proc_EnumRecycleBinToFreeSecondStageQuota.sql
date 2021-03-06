/****** Object:  StoredProcedure [dbo].[proc_EnumRecycleBinToFreeSecondStageQuota]    Script Date: 5/15/2018 12:11:59 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_EnumRecycleBinToFreeSecondStageQuota(
    @SiteId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        CAST(RecycleBin.DeleteTransactionId AS uniqueidentifier),
        RecycleBin.Size
    FROM 
        RecycleBin
    WHERE
        RecycleBin.SiteId = @SiteId AND
        RecycleBin.BinId = 2
    ORDER BY
        RecycleBin.DeleteDate
    RETURN 0

GO
