/****** Object:  StoredProcedure [dbo].[proc_dropEmailEnabledList]    Script Date: 5/15/2018 12:13:05 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_dropEmailEnabledList
(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier
) AS
    SET NOCOUNT ON
    DELETE FROM
        dbo.EmailEnabledLists
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        ListId = @ListId AND
        Deleted = 0
    RETURN 0 

GO
