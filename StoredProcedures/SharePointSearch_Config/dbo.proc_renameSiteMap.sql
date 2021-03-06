/****** Object:  StoredProcedure [dbo].[proc_renameSiteMap]    Script Date: 5/15/2018 12:13:07 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_renameSiteMap
(   
    @SiteId uniqueidentifier,
    @Path nvarchar(128)
) AS
    SET NOCOUNT ON
    UPDATE
        SiteMap
    SET
        Path = @Path
    WHERE
        Id = @SiteId

GO
