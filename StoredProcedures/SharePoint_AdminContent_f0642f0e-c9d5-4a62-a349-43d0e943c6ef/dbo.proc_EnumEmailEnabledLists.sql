/****** Object:  StoredProcedure [dbo].[proc_EnumEmailEnabledLists]    Script Date: 5/15/2018 12:12:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_EnumEmailEnabledLists
AS
    SET NOCOUNT ON
    SELECT
        Sites.Id, Webs.Id, Webs.FullUrl, Lists.tp_Id
    FROM
        Sites WITH (NOLOCK)
    INNER JOIN
        Webs WITH (NOLOCK)
    ON
        Sites.Id = Webs.SiteId AND
        Sites.EmailEnabled = 1 AND
        Webs.EmailEnabled = 1
    INNER JOIN
        Lists WITH (NOLOCK)
    ON
        Lists.tp_WebId =  Webs.Id AND
        Lists.tp_Flags & 0x10000 = 0x10000
    RETURN 0

GO
