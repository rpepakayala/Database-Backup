/****** Object:  StoredProcedure [dbo].[proc_MSS_QLog_TopDestinations]    Script Date: 5/15/2018 12:11:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_QLog_TopDestinations
 @siteGuid uniqueidentifier,
 @isSspLevel bit,
 @topResultsCount int
AS

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @siteId int
    EXEC @siteId = proc_MSS_QLog_GetSiteId @siteGuid, @isSspLevel
    IF (@siteId IS NULL AND @isSspLevel <> 1) RETURN

    DECLARE @stmt nvarchar(4000),
    @param nvarchar(4000)

    SELECT @param = N'@isSspLevel bit, @siteId int'

    SELECT @stmt = N'
    SELECT url AS clickedUrl, numClicks 
    FROM
    (
        SELECT TOP ' + Cast(@topResultsCount as NVARCHAR(15))
        +N'clickedUrlId, numClicks
        FROM (
            SELECT clickedUrlId, SUM(numClicks) AS numClicks
            FROM dbo.MSSQLogClickedUrlSummary
            WHERE (searchDate >= DATEADD(day, DATEDIFF(day, ''1/1/2000'', GETDATE()) - 30, ''1/1/2000'')) 
            AND (siteId = @siteId OR @isSspLevel = 1)
            GROUP BY clickedUrlId
        ) as smr
        ORDER BY numClicks DESC
    ) AS t
    INNER JOIN dbo.MSSQLogUrl AS c
    ON c.urlId = t.clickedUrlId
    ORDER BY numClicks DESC'

    EXEC SP_EXECUTESQL  @stmt, @param, @isSspLevel, @siteId

GO
