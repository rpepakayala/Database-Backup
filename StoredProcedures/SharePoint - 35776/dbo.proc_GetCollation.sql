/****** Object:  StoredProcedure [dbo].[proc_GetCollation]    Script Date: 5/15/2018 12:12:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetCollation(
    @ListId uniqueidentifier,
    @Collation smallint OUTPUT)
AS
    SET NOCOUNT ON
    SELECT
        @Collation = Webs.Collation
    FROM
        Webs WITH (NOLOCK)
    INNER JOIN
        Lists
    ON
        Lists.tp_WebId = Webs.Id
    WHERE
        Lists.tp_Id = @ListId
    RETURN 0

GO
