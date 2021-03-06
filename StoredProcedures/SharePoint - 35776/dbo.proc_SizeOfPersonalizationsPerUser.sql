/****** Object:  StoredProcedure [dbo].[proc_SizeOfPersonalizationsPerUser]    Script Date: 5/15/2018 12:12:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SizeOfPersonalizationsPerUser(
    @SiteId uniqueidentifier,
    @DocId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        UserInfo.tp_Id,
        UserInfo.tp_Login,
        ISNULL(PerSize,0) + ISNULL(WPSize,0) As Size
        FROM
        UserInfo
        LEFT OUTER JOIN
            (SELECT
            tp_UserId,
            (SUM(CAST((tp_Size) AS BIGINT)))
            As
            WPSize,
            tp_SiteId
            FROM
            WebParts
            WHERE tp_PageUrlId = @DocId AND
                tp_SiteId = @SiteId
            GROUP BY tp_SiteId, tp_UserId)
            AS WPTable
            ON
            WPTable.tp_UserId = UserInfo.tp_Id AND
            WPTable.tp_SiteId = UserInfo.tp_SiteId
            LEFT OUTER JOIN
                (SELECT
                tp_UserId,
                (SUM(CAST((tp_Size) AS BIGINT))) As PerSize,
                tp_SiteId
                FROM
                Personalization
                WHERE tp_PageUrlId = @DocId AND
                    tp_SiteId = @SiteId
                GROUP BY tp_SiteId, tp_UserId)
                As PerTable
                ON
                PerTable.tp_SiteId = UserInfo.tp_SiteId AND
                PerTable.tp_UserId = UserInfo.tp_Id
                WHERE WPSize IS NOT NULL OR
                PerSize IS NOT NULL

GO
