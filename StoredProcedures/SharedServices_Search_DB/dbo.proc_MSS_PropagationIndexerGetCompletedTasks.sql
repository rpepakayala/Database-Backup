/****** Object:  StoredProcedure [dbo].[proc_MSS_PropagationIndexerGetCompletedTasks]    Script Date: 5/15/2018 12:11:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_PropagationIndexerGetCompletedTasks(
    @CatalogID int,
    @UnresponsiveQueryServers int OUTPUT )
AS
BEGIN

SET NOCOUNT ON

    CREATE TABLE #UnresponsiveQueryServers ( 
        ServerID int )
    INSERT #UnresponsiveQueryServers    
    EXEC
        dbo.proc_MSS_PropagationGetUnresponsiveQueryServers

    SELECT
        @UnresponsiveQueryServers = COUNT(*)
    FROM #UnresponsiveQueryServers      

    DECLARE 
        @cQueryServers int
    SELECT
        @cQueryServers = COUNT(*)
    FROM
        dbo.MSSPropagationSearchServerTable
    WHERE
        MachineStatus = 3

    IF ( @cQueryServers = 0 )
    BEGIN
        SELECT
            CatalogID,
            TaskType,
            ObjectId,
            0,
            0
        FROM
            dbo.MSSPropagationPropagationTask
        WHERE
            CatalogID = @CatalogID

        RETURN
    END

    SELECT 
        SearchServersReadyCounts.CatalogID, 
        SearchServersReadyCounts.TaskType, 
        SearchServersReadyCounts.ObjectID, 
        0, 
        0
    FROM ( 
        SELECT 
            T.CatalogID, 
            T.TaskType, 
            T.ObjectID, 
            COUNT(*) AS SearchServersReady
        FROM 
            MSSPropagationPropagationTask AS T
        JOIN 
            MSSPropagationSearchServerReady AS R
        ON 
            T.CatalogId = R.CatalogId AND
            T.TaskType = R.TaskType AND
            T.ObjectId = R.ObjectId
        WHERE
            R.SearchServerID
        IN (
            SELECT
                SearchServerID
            FROM
                MSSPropagationSearchServerTable
            WHERE
                MachineStatus = 3
        )
        GROUP BY 
            T.CatalogId, 
            T.TaskType, 
            T.ObjectId
         ) AS SearchServersReadyCounts
    WHERE
        SearchServersReadyCounts.SearchServersReady = @cQueryServers AND 
        SearchServersReadyCounts.CatalogID = @CatalogID

END


GO
