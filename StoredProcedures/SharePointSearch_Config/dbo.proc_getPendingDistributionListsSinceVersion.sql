/****** Object:  StoredProcedure [dbo].[proc_getPendingDistributionListsSinceVersion]    Script Date: 5/15/2018 12:13:06 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_getPendingDistributionListsSinceVersion
(
    @Version rowversion
) AS
    SET NOCOUNT ON
    SELECT
        SiteId,
        WebId,
        GroupName,
        CAST(Version as bigint)
    FROM
        dbo.PendingDistributionLists
     WHERE
        Version > @Version
    RETURN 0 

GO
