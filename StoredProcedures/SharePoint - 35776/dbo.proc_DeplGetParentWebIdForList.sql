/****** Object:  StoredProcedure [dbo].[proc_DeplGetParentWebIdForList]    Script Date: 5/15/2018 12:11:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetParentWebIdForList(
    @ListId uniqueidentifier)
AS
    SET NOCOUNT ON
    IF @ListId IS NULL
        RETURN 87
    SELECT
        tp_WebId
    FROM
        Lists
    WHERE
       tp_ID = @ListId
    RETURN 0

GO
