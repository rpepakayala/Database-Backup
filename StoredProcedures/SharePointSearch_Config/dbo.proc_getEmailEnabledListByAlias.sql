/****** Object:  StoredProcedure [dbo].[proc_getEmailEnabledListByAlias]    Script Date: 5/15/2018 12:13:05 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_getEmailEnabledListByAlias
(
    @Alias nvarchar(128)
)
AS
    SET NOCOUNT ON
    SELECT
        SiteId, 
        WebId,
        ListId
    FROM
        dbo.EmailEnabledLists
    WHERE
        Alias = @Alias AND
        Deleted = 0
    RETURN 0 

GO
