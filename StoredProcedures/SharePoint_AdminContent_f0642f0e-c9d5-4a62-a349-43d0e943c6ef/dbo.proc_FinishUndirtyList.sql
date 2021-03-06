/****** Object:  StoredProcedure [dbo].[proc_FinishUndirtyList]    Script Date: 5/15/2018 12:12:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_FinishUndirtyList(
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @CacheParseId uniqueidentifier,
    @ListFlag int)
AS
    SET NOCOUNT ON
    UPDATE Lists
    SET
        tp_ListDataDirty = tp_ListDataDirty & ~@ListFlag,
        tp_CacheParseId = NULL
    WHERE
        tp_WebId = @WebId AND
        tp_ID = @ListId AND
        tp_CacheParseId = @CacheParseId

GO
