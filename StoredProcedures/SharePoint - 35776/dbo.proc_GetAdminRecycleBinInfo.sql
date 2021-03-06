/****** Object:  StoredProcedure [dbo].[proc_GetAdminRecycleBinInfo]    Script Date: 5/15/2018 12:12:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetAdminRecycleBinInfo(
    @SiteId uniqueidentifier,
    @ItemCount int OUTPUT,
    @Size bigint OUTPUT)
AS
    SET NOCOUNT ON
    SELECT
        @ItemCount = COUNT(*),
        @Size = ISNULL(SUM(Size),0)
    FROM
        RecycleBin
    WHERE
        SiteId = @SiteId AND
        BinId = 1
    IF @ItemCount IS NULL
    BEGIN
        SET @ItemCount = 0
        SET @Size = 0
    END
    RETURN 0

GO
