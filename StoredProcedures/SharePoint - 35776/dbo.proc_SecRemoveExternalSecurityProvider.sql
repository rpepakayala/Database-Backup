/****** Object:  StoredProcedure [dbo].[proc_SecRemoveExternalSecurityProvider]    Script Date: 5/15/2018 12:12:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecRemoveExternalSecurityProvider(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier)
AS
    SET NOCOUNT ON
    UPDATE
        Webs
    SET
        MetaInfoVersion = MetaInfoVersion + 1,
        SecurityProvider = NULL
    WHERE
        SiteId = @SiteId AND
        Id = @WebId
    RETURN 0

GO
