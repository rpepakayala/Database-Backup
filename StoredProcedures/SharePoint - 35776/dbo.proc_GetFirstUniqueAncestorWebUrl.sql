/****** Object:  StoredProcedure [dbo].[proc_GetFirstUniqueAncestorWebUrl]    Script Date: 5/15/2018 12:12:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetFirstUniqueAncestorWebUrl(
    @WebId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        w1.FullUrl
    FROM
        Webs w1
    INNER JOIN
        Webs w2
    ON
        w1.Id = w2.FirstUniqueAncestorWebId
    WHERE
        w2.Id = @WebId

GO
