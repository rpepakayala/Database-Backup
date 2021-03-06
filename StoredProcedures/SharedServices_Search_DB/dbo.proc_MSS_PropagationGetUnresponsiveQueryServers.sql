/****** Object:  StoredProcedure [dbo].[proc_MSS_PropagationGetUnresponsiveQueryServers]    Script Date: 5/15/2018 12:11:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_PropagationGetUnresponsiveQueryServers
AS

    DECLARE @OldTasks table(
        CatalogID int,
        TaskType int,
        ObjectID int
    )
    INSERT INTO 
        @OldTasks
    SELECT 
        CatalogID, 
        TaskType, 
        ObjectID 
    FROM 
        dbo.MSSPropagationPropagationTask 
    WHERE 
        (TaskType = 1 OR            
         TaskType = 5) AND          
        300 < DATEDIFF (s, Time, GETUTCDATE())

    DECLARE
       @NumOldTasks int
    SELECT
       @NumOldTasks = COUNT(*)
    FROM
       @OldTasks

    SELECT
        SearchServerID
    FROM
        dbo.MSSPropagationSearchServerTable AS S
    WHERE
        MachineStatus = 4 OR
        ( MachineStatus = 3 AND
          @NumOldTasks != ( SELECT COUNT(*) FROM dbo.MSSPropagationSearchServerReady AS R
                            JOIN @OldTasks AS T
                            ON S.SearchServerID = R.SearchServerID AND
                               R.CatalogID = T.CatalogID AND
                               R.TaskType = T.TaskType AND
                               R.ObjectID = T.ObjectID ) )

GO
