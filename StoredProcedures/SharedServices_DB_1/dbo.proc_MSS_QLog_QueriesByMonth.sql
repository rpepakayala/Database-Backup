/****** Object:  StoredProcedure [dbo].[proc_MSS_QLog_QueriesByMonth]    Script Date: 5/15/2018 12:11:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_QLog_QueriesByMonth
 @siteGuid uniqueidentifier,
 @isSspLevel bit
as

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @siteId int
    EXEC @siteId = proc_MSS_QLog_GetSiteId @siteGuid, @isSspLevel
    IF (@siteId IS NULL AND @isSspLevel <> 1) RETURN

    DECLARE @anyDataAvailable int
    SELECT @anyDataAvailable = 
    (
        SELECT TOP 1 numQueries
        FROM dbo.MSSQLogHistorical
        WHERE (searchDate >= DATEADD(month, DATEDIFF(month, '1/1/2000', GETDATE())-11, '1/1/2000')) 
        AND (searchDate <= GETDATE())
        AND (siteId = @siteId OR @isSspLevel = 1)
    )
    IF (@anyDataAvailable is NULL)
        RETURN

    SELECT m.searchMonth, numQueries FROM 
    (
        SELECT numQueries, DATEADD([month], searchMonth - 1, DATEADD([year], searchYear - 1900, CONVERT(DATETIME, '1900-01-01 00:00:00', 102))) AS searchMonth FROM
        (
            SELECT  SUM(numQueries) AS numQueries, DATEPART([month], searchDate) AS searchMonth, DATEPART([year], searchDate) AS searchYear
            FROM   dbo.MSSQLogHistorical
            WHERE (searchDate > DATEADD(day, -366, GETDATE())) 
            AND (searchDate <= GETDATE())
            AND (siteId = @siteId OR @isSspLevel = 1)
            GROUP BY DATEPART([month], searchDate), DATEPART([year], searchDate)
        ) AS x
    ) as t RIGHT OUTER JOIN 
    (
        SELECT DATEADD(month, DATEDIFF(month, '1/1/2000', GETDATE())-11, '1/1/2000') as searchMonth UNION
        SELECT DATEADD(month, DATEDIFF(month, '1/1/2000', GETDATE())-10, '1/1/2000') as searchMonth UNION
        SELECT DATEADD(month, DATEDIFF(month, '1/1/2000', GETDATE())-9, '1/1/2000') as searchMonth UNION
        SELECT DATEADD(month, DATEDIFF(month, '1/1/2000', GETDATE())-8, '1/1/2000') as searchMonth UNION
        SELECT DATEADD(month, DATEDIFF(month, '1/1/2000', GETDATE())-7, '1/1/2000') as searchMonth UNION
        SELECT DATEADD(month, DATEDIFF(month, '1/1/2000', GETDATE())-6, '1/1/2000') as searchMonth UNION
        SELECT DATEADD(month, DATEDIFF(month, '1/1/2000', GETDATE())-5, '1/1/2000') as searchMonth UNION
        SELECT DATEADD(month, DATEDIFF(month, '1/1/2000', GETDATE())-4, '1/1/2000') as searchMonth UNION
        SELECT DATEADD(month, DATEDIFF(month, '1/1/2000', GETDATE())-3, '1/1/2000') as searchMonth UNION
        SELECT DATEADD(month, DATEDIFF(month, '1/1/2000', GETDATE())-2, '1/1/2000') as searchMonth UNION
        SELECT DATEADD(month, DATEDIFF(month, '1/1/2000', GETDATE())-1, '1/1/2000') as searchMonth UNION
        SELECT DATEADD(month, DATEDIFF(month, '1/1/2000', GETDATE()), '1/1/2000') as searchMonth
    ) as m
    ON m.searchMonth = t.searchMonth
    ORDER BY m.searchMonth

GO
