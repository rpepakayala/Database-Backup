/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Audit_LoadLatestPackageExecutionsVariableLogs]    Script Date: 5/15/2018 12:11:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/*
 * Object: usp_SSISOps_Audit_LoadLatestPackageExecutionsVariableLogs
 * --------------------------------------------------------------
 * Source : Pragmatic Works - BI xPress Auditing Framework 47
 * Created By : Jeremiah Nazaruk
 * Created On : 6/13/2013
 * Purpose : Loads latest package executions variable logs given a specific list of package execution IDs in a comma separated list.  
 *           Only one instance of the variable will be loaded by package exection ID.
 * --------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[usp_SSISOps_Audit_LoadLatestPackageExecutionsVariableLogs]
(
    @ExecutionIds NVARCHAR(MAX)
)
AS
BEGIN
    SET NOCOUNT ON

    CREATE TABLE #UniqueIdsTbl ([UniqueId] uniqueidentifier NOT NULL)

    INSERT INTO #UniqueIdsTbl ([UniqueId]) 
        SELECT [UniqueId] FROM [dbo].[fn_ParseUniqueIdentifierList](@ExecutionIds)

    SELECT a.[ExecutionID]
        ,a.[VariableName]
        ,a.[VariableValue]
        ,a.[LogDateTime]
    FROM (
            SELECT v.[ExecutionID]
                ,v.[VariableName]
                ,v.[VariableValue]
                ,v.[LogDateTime]
                ,ROW_NUMBER() OVER(PARTITION BY v.[ExecutionID], v.[SourceID], v.[VariableName] ORDER BY v.[LogDateTime] DESC) AS [RowNum]
            FROM [dbo].[SSISPackageVariableLog] v
            WHERE [ExecutionID] IN (
                SELECT u.[UniqueId] FROM #UniqueIdsTbl u
            )
        ) a
    WHERE a.[RowNum] = 1
    ORDER BY a.[LogDateTime] DESC

    DROP TABLE #UniqueIdsTbl

    SET NOCOUNT OFF
END

GO
