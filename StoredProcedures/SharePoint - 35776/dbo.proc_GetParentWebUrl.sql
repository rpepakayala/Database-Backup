/****** Object:  StoredProcedure [dbo].[proc_GetParentWebUrl]    Script Date: 5/15/2018 12:12:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetParentWebUrl(
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
        w1.Id = w2.ParentWebId
    WHERE
        w2.Id = @WebId

GO
