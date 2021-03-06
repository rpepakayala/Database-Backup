/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Audit_SpecificPackageExecutions]    Script Date: 5/15/2018 12:11:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/*
 * Object: usp_SSISOps_Audit_SpecificPackageExecutions
 * --------------------------------------------------------------
 * Source : Pragmatic Works - BI xPress Auditing Framework 47
 * Created By : Matt Whitfield
 * Created On : 6/13/2013
 * Purpose : Loads package executions given a specific list of package execution IDs in a comma separated list
 * --------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[usp_SSISOps_Audit_SpecificPackageExecutions]
(
    @ExecutionIDs VARCHAR(MAX),
    @MaxVariableLength INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON
    SET @MaxVariableLength = ISNULL(@MaxVariableLength, 4000)

    SELECT 
          [s].[LogID]
        , [s].[ExecutionID]
        , [s].[PackageName]
        , ISNULL([s].[LayoutID], 0) AS [LayoutID]
        , [s].[ExecutionStartDateTime]
        , [s].[ExecutionEndDateTime]
        , ISNULL([s].[TotalErrorCount], 0) AS [TotalErrorCount]
        , [Variables] = (
                (CASE WHEN DATALENGTH([s].[Variables]) > @MaxVariableLength
                    THEN LEFT(CAST([s].[Variables] AS NVARCHAR(MAX)), @MaxVariableLength) + ' ***** <LARGE STRING [Data truncated] - ' + CAST((DATALENGTH([s].[Variables])/1024) AS NVARCHAR(100)) + ' KB> Change max variable length option to see the full value *****'
                    ELSE [s].[Variables]
                 END)
            )
        , [s].[Connections]
        , [s].[UserName]
        , [s].[MachineName]
        , [s].[InteractiveMode]
        , [c].[ExecutionId] As [CatalogExecutionId]
        , [c].[PackageId] As [CatalogPackageId]
        , [c].[PackageGuid] As [CatalogPackageGuid]
        , [c].[FolderId] As [CatalogFolderId]
        , [c].[FolderName] As [CatalogFolderName]
        , [c].[ProjectId] As [CatalogProjectId]
        , [c].[ProjectName] As [CatalogProjectName]
        , [c].[MachineName] As [CatalogMachineName]
        , [c].[ServerName] As [CatalogServerName]
        , [c].[Status] As [CatalogStatus]
        , [c].[StoppedByName] As [CatalogStoppedByName]
    FROM [SSISPackageExecutionLog] AS [s] (NOLOCK)
        INNER JOIN [dbo].[fn_ParseUniqueIdentifierList](@ExecutionIDs) executionIds
            ON [executionIds].[UniqueId] = [dbo].[fn_ToUniqueIdentifier]([s].[ExecutionID])
        LEFT OUTER JOIN [SSISCatalogPackageExecution] [c] (NOLOCK)
            ON [c].[ExecutionGuid] = [dbo].[fn_ToUniqueIdentifier]([s].[ExecutionID])
    ORDER BY [s].[LogID] DESC

    SET NOCOUNT OFF
END

GO
