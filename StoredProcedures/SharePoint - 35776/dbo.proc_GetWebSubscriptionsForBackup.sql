/****** Object:  StoredProcedure [dbo].[proc_GetWebSubscriptionsForBackup]    Script Date: 5/15/2018 12:12:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetWebSubscriptionsForBackup(
    @SiteId         uniqueidentifier,
    @WebId          uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        ImmedSubscriptions.Id,
        ImmedSubscriptions.ListId,
        ImmedSubscriptions.ItemId,
        ImmedSubscriptions.EventType,
        NotifyFrequency = 0,
        ImmedSubscriptions.UserId,
        ImmedSubscriptions.UserEmail,
        Docs.DirName,
        Docs.LeafName
    FROM
        ImmedSubscriptions
    LEFT OUTER JOIN
        Docs
    ON
        ImmedSubscriptions.SiteId    = Docs.SiteId  AND
        ImmedSubscriptions.WebId     = Docs.WebId   AND
        ImmedSubscriptions.ItemDocId = Docs.Id
    WHERE
        ImmedSubscriptions.SiteId      = @SiteId   AND
        ImmedSubscriptions.WebId       = @WebId    AND
        ImmedSubscriptions.Deleted     = 0
    UNION ALL
    SELECT
        SchedSubscriptions.Id,
        SchedSubscriptions.ListId,
        SchedSubscriptions.ItemId,
        SchedSubscriptions.EventType,
        NotifyFrequency = SchedSubscriptions.NotifyFreq,
        SchedSubscriptions.UserId,
        SchedSubscriptions.UserEmail,
        Docs.DirName,
        Docs.LeafName
    FROM
        SchedSubscriptions
    LEFT OUTER JOIN
        Docs
    ON
        SchedSubscriptions.SiteId    = Docs.SiteId  AND
        SchedSubscriptions.WebId     = Docs.WebId   AND
        SchedSubscriptions.ItemDocId = Docs.Id
    WHERE
        SchedSubscriptions.SiteId      = @SiteId   AND
        SchedSubscriptions.WebId       = @WebId    AND
        SchedSubscriptions.Deleted     = 0

GO
