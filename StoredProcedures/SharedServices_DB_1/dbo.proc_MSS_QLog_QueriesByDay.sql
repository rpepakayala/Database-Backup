/****** Object:  StoredProcedure [dbo].[proc_MSS_QLog_QueriesByDay]    Script Date: 5/15/2018 12:11:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_QLog_QueriesByDay
 @siteGuid uniqueidentifier,
 @isSspLevel bit
as

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @siteId int
    EXEC @siteId = proc_MSS_QLog_GetSiteId @siteGuid, @isSspLevel
    IF (@siteId IS NULL AND @isSspLevel <> 1) RETURN

    SELECT SUM(numQueries) AS numQueries, searchDate
    FROM  dbo.MSSQLogHistorical
    WHERE (searchDate > DATEADD(day, -30, GETDATE())) 
    AND (searchDate <= GETDATE())
    AND (siteId = @siteId OR @isSspLevel = 1)
    GROUP BY searchDate
    ORDER BY searchDate


GO
