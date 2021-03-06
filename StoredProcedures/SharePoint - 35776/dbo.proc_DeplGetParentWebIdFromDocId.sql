/****** Object:  StoredProcedure [dbo].[proc_DeplGetParentWebIdFromDocId]    Script Date: 5/15/2018 12:11:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetParentWebIdFromDocId (
    @DocId uniqueidentifier)
AS
    SET NOCOUNT ON
    IF @DocId IS NULL
        RETURN 87
    SELECT
        Docs.WebId, Docs.ListId
    FROM
        Docs
    WHERE
        Docs.Id = @DocId

GO
