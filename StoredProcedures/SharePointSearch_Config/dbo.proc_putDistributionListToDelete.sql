/****** Object:  StoredProcedure [dbo].[proc_putDistributionListToDelete]    Script Date: 5/15/2018 12:13:07 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_putDistributionListToDelete
(
    @Alias nvarchar(128)
) AS
    SET NOCOUNT ON
    INSERT INTO dbo.EmailEnabledLists
    (
        Alias,
        SiteId, 
        WebId,
        ListId,
        Deleted
    )
    VALUES
    (
        @Alias,
        '00000000-0000-0000-0000-000000000000',
        '00000000-0000-0000-0000-000000000000',
        '00000000-0000-0000-0000-000000000000',
        1
    )

GO
