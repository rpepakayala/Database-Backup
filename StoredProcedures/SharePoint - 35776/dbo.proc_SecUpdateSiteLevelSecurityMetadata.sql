/****** Object:  StoredProcedure [dbo].[proc_SecUpdateSiteLevelSecurityMetadata]    Script Date: 5/15/2018 12:12:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecUpdateSiteLevelSecurityMetadata(
    @SiteId uniqueidentifier,
    @IncrementSecurityVersion int,
    @IncrementDGMapVersion int)
AS
    UPDATE
        Sites
    SET
        SecurityVersion = SecurityVersion + @IncrementSecurityVersion,
        DomainGroupMapVersion = DomainGroupMapVersion + @IncrementDGMapVersion,
        LastSecurityChange = GETUTCDATE()
    WHERE
        Id = @SiteId

GO
