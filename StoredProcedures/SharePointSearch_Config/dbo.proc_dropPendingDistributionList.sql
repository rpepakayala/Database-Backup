/****** Object:  StoredProcedure [dbo].[proc_dropPendingDistributionList]    Script Date: 5/15/2018 12:13:05 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_dropPendingDistributionList
(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @GroupName nvarchar(255)
) AS
    SET NOCOUNT ON
    DELETE FROM
        dbo.PendingDistributionLists
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        GroupName = @GroupName
    RETURN 0 

GO
