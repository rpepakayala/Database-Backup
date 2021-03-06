/****** Object:  StoredProcedure [bix].[usp_SSISOps_Audit_LoadLatestPackageExecutionsVariableLogs_59]    Script Date: 5/15/2018 12:11:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/*
 * Object: usp_SSISOps_Audit_LoadLatestPackageExecutionsVariableLogs
 * --------------------------------------------------------------
 * Source : Pragmatic Works - BI xPress Auditing Framework 59
 * Created By : Jeremiah Nazaruk
 * Created On : 2/19/2016
 * Purpose : Loads latest package executions variable logs given a specific list of package execution IDs in a comma separated list.  
 *           Only one instance of the variable will be loaded by package exection ID.
 * --------------------------------------------------------------
*/
CREATE PROCEDURE [bix].[usp_SSISOps_Audit_LoadLatestPackageExecutionsVariableLogs_59]
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
            FROM [bix].[vw_SSISPackageVariableLog_59] v
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
