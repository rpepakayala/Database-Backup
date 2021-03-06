/****** Object:  StoredProcedure [dbo].[proc_MSS_QLog_LowClickThrough]    Script Date: 5/15/2018 12:11:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_QLog_LowClickThrough
 @siteGuid uniqueidentifier,
 @isSspLevel bit,
 @showZeros bit
WITH RECOMPILE
AS

    DECLARE @minClicks int
    DECLARE @startDate smalldatetime

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @siteId int
    EXEC @siteId = proc_MSS_QLog_GetSiteId @siteGuid, @isSspLevel
    IF (@siteId IS NULL AND @isSspLevel <> 1) RETURN

    IF (@showZeros = 1)
        SET @minClicks = 0
    ELSE
        SET @minClicks = 1

    SET @startDate = DATEADD(day, DATEDIFF(day, '1/1/2000', GETDATE()) - 30, '1/1/2000')

    SELECT queryString, scope, numScopes, numQueries, clickRatio, 
        (
            SELECT url AS resultsUrl FROM 
            (
                SELECT TOP 1 resultsUrlId FROM dbo.MSSQLogResultsUrlSummary AS r
                WHERE (r.siteId = @siteId OR @isSspLevel = 1)
                AND (r.searchDate >= @startDate)
                AND (r.queryIdX = q.queryId)
                GROUP BY resultsUrlId
                ORDER BY SUM(numQueries) DESC
            ) AS x
            INNER JOIN MSSQLogUrl as u
            ON u.urlId = x.resultsUrlId
        ) AS resultsUrl, csn.contextualScope, cu.url as contextualScopeUrl
    FROM (
        SELECT TOP 300 queryId, scopeId, numClicks, numQueries, clickRatio, contextualScopeId
        FROM ( 
            SELECT queryId, scopeId, SUM(numClicks) as numClicks, SUM(clickThroughBase) as numQueries, CASE WHEN SUM(clickThroughBase) = 0 THEN 0 ELSE CAST(SUM(numClicks) AS decimal)/ SUM(clickThroughBase) END AS clickRatio, contextualScopeId
            FROM dbo.MSSQLogQuerySummary
            WHERE (searchDate >= @startDate)
            AND (siteId = @siteId OR @isSspLevel = 1)
            GROUP BY queryId, scopeId, contextualScopeId
        ) as smr
        WHERE numClicks >= @minClicks
        AND numQueries > 1
        ORDER BY clickRatio ASC, numQueries DESC
    ) AS t
    INNER JOIN dbo.MSSQLogScope AS s 
    ON s.scopeId = t.scopeId
    INNER JOIN MSSQLogQueryString as q 
    ON q.queryId = t.queryId
    INNER JOIN dbo.MSSQLogContextualScope AS cs 
    ON cs.contextualScopeId = t.contextualScopeId
    INNER JOIN dbo.MSSQLogContextualScopeName AS csn 
    ON csn.contextualScopeNameId = cs.contextualScopeNameId
    LEFT OUTER JOIN MSSQLogUrl as cu 
    ON cu.urlId = cs.contextualScopeUrlId
    ORDER BY clickRatio ASC, numQueries DESC

GO
