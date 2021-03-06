/****** Object:  StoredProcedure [dbo].[proc_MSS_PropagationSetQueryServerState]    Script Date: 5/15/2018 12:13:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_PropagationSetQueryServerState(
    @Name nvarchar(256),
    @State int )
AS
    BEGIN TRANSACTION
    UPDATE 
        dbo.MSSPropagationSearchServerTable 
    SET
        MachineStatus = @State
    WHERE
        SearchServerName = @Name AND
        MachineStatus != 5  
    IF @State = 2
    BEGIN
        INSERT INTO
            dbo.MSSPropagationSearchServerReady (
                CatalogID,
                TaskType,
                ObjectID,
                SearchServerID
            )
        SELECT 
            CatalogID, TaskType, ObjectID, SearchServerID
        FROM 
            dbo.MSSPropagationPropagationTask,
            dbo.MSSPropagationSearchServerTable
        WHERE
            SearchServerName = @Name AND
            MachineStatus != 5
    END
    COMMIT TRANSACTION

GO
