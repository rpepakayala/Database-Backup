/****** Object:  StoredProcedure [dbo].[proc_EnumEmailAliases]    Script Date: 5/15/2018 12:11:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_EnumEmailAliases
AS
    SET NOCOUNT ON
    SELECT
        Lists.tp_EmailAlias,
        Webs.SiteId,
        Lists.tp_WebId,
        Lists.tp_ID
    FROM
        Lists INNER JOIN Webs
    ON
        Webs.Id = Lists.tp_WebId
    WHERE
        tp_EmailAlias IS NOT NULL

GO
