/****** Object:  StoredProcedure [dbo].[proc_UpdateSiteHashKey]    Script Date: 5/15/2018 12:13:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateSiteHashKey(
    @SiteId       uniqueidentifier,
    @SiteHashKey  binary(16))
AS
    UPDATE
        Sites
    SET
        HashKey = @SiteHashKey
    WHERE
        Id = @SiteId

GO
