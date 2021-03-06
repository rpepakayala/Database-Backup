/****** Object:  StoredProcedure [dbo].[proc_GetUniqueListMetaData]    Script Date: 5/15/2018 12:12:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetUniqueListMetaData(
    @SiteId              uniqueidentifier,
    @WebId               uniqueidentifier,
    @ServerTemplate      int,
    @PrefetchListScope   bit)
AS
    SET NOCOUNT ON
    DECLARE @ListId uniqueidentifier
    EXEC proc_GetUniqueList @WebId, @ServerTemplate, @ListId OUTPUT
    DECLARE @ret int
    IF @ListId IS NULL
        SET @ret = 13
    ELSE
        EXEC @ret = proc_GetListMetaDataAndEventReceivers
                    @SiteId, @WebId, @ListId, @PrefetchListScope
    RETURN @ret

GO
