/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Report_PackageAndTaskExecutionSummary]    Script Date: 5/15/2018 12:11:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/*
 * Object: usp_SSISOps_Report_PackageAndTaskExecutionSummary
 * --------------------------------------------------------------
 * Updated By: Matt Whitfield - 11/29/2012
 * Source : Pragmatic Works - BI xPress Auditing Framework 50
 * Created On : 11/7/2013
 * Purpose : 
 *     - Displays Information about summary of package and task execution trend.
 * --------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[usp_SSISOps_Report_PackageAndTaskExecutionSummary]
(
     @Status VARCHAR(255) = 'ALL',
     @PackageNameFilter VARCHAR(255) = NULL,
     @MachineName VARCHAR(255) = '%',
     @ExecutionAccountName VARCHAR(255) = '%',
     @ExecutionMode VARCHAR(255) = 'ALL',
     @IntervalType VARCHAR(10) = 'd',
     @MaxColCount INT = NULL,
     @IncludeDataFlows bit = 0
)
AS
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
    
    CREATE TABLE [#SSISPackageExecutionLog] (
      [LogID] INT NOT NULL,
      [PackageName] [nvarchar] (255) NOT NULL,
      [PackageID] [uniqueidentifier] NOT NULL,
      [ExecutionID] [uniqueidentifier] NOT NULL,
      [ExecutionStartDateTime] [datetime] NOT NULL,
      [ExecutionEndDateTime] [datetime] NOT NULL,
      [RunTimeInSeconds] [int] NOT NULL,
      [TotalErrorCount] [int] NOT NULL,
      [TotalWarningCount] [int] NOT NULL,
      [LayoutID] [int] NULL)
    
    CREATE TABLE [#PackageRuntimeAvgTbl] (
        [PackageUniqueID] [uniqueidentifier] NOT NULL PRIMARY KEY CLUSTERED DEFAULT (NEWID()),
        [PackageID] [uniqueidentifier] NOT NULL,
        [PackageName] NVARCHAR(255) NOT NULL,
        [ExecutionCount] INT NOT NULL,
        [AverageRuntimeSeconds] INT NOT NULL,
        [PackageRuntimeStdDev] FLOAT NOT NULL,
    )

    CREATE TABLE [#PackageDetailsTable] (
        [LogID] INT NOT NULL,
        [PackageUniqueID] [uniqueidentifier] NOT NULL,
        [PackageID] [uniqueidentifier] NOT NULL,
        [ExecutionID] [uniqueidentifier] NOT NULL,
        [ExecutionStart] DATETIME NOT NULL,
        [ExecutionEnd] DATETIME NOT NULL,
        [RunTimeInSeconds] INT NOT NULL,
        [ZScore] FLOAT NOT NULL
    )

    CREATE CLUSTERED INDEX CX_SSISPackageExecutionLog ON #SSISPackageExecutionLog ([PackageID], [PackageName])
    CREATE INDEX CX_PackageDetailsTable ON #PackageDetailsTable ([PackageID]) INCLUDE ([ZScore])
    
    -- first of all get the rows we care about into a temp table
    INSERT INTO [#SSISPackageExecutionLog] ([LogID], [PackageName], [PackageID], [ExecutionID], [ExecutionStartDateTime], [ExecutionEndDateTime], [RunTimeInSeconds], [TotalErrorCount], [TotalWarningCount], [LayoutID])
    SELECT [LogID],
           [PackageName],
           [PackageID],
           [ExecutionID],
           [ExecutionStartDateTime],
           [ExecutionEndDateTime],
           DATEDIFF(s, [ExecutionStartDateTime], [ExecutionEndDateTime]) AS [RunTimeInSeconds],
           ISNULL([TotalErrorCount], 0),
           ISNULL([TotalWarningCount], 0),
           [LayoutID]
      FROM [dbo].[fn_SSISOps_Report_LogRowsByInterval](@Status, @PackageNameFilter, @MachineName, @ExecutionAccountName, @ExecutionMode, @IntervalType, @MaxColCount) [log]
     WHERE [ExecutionEndDateTime] IS NOT NULL
       AND [ExecutionEndDateTime] >= [ExecutionStartDateTime]

    INSERT INTO [#PackageRuntimeAvgTbl] ([PackageID], [PackageName], [ExecutionCount], [AverageRuntimeSeconds], [PackageRuntimeStdDev])
    SELECT [PackageID],
           [PackageName],
           COUNT(*),
           ISNULL(AVG([RunTimeInSeconds]), 0),
           ISNULL(STDEV([RunTimeInSeconds]), 0)
    FROM [#SSISPackageExecutionLog]
    GROUP BY [PackageID], [PackageName]

    INSERT INTO [#PackageDetailsTable] ([PackageUniqueID], [LogID], [PackageID], [ExecutionID], [ExecutionStart], [ExecutionEnd], [RunTimeInSeconds], [ZScore])
    SELECT [PackageUniqueID],
           [LogID],
           [executionLog].[PackageID],
           [ExecutionID],
           [ExecutionStartDateTime],
           [ExecutionEndDateTime],
           [RunTimeInSeconds],
           (CASE [PackageRuntimeStdDev]
            WHEN 0 THEN 0
            ELSE (([RunTimeInSeconds] - [AverageRuntimeSeconds]) / [PackageRuntimeStdDev])
            END)
      FROM [#SSISPackageExecutionLog] [executionLog] INNER JOIN 
           [#PackageRuntimeAvgTbl] [averages] 
        ON [averages].[PackageID] = [executionLog].[PackageID] AND [averages].[PackageName] = [executionLog].[PackageName]
     GROUP BY [ExecutionStartDateTime],
              [ExecutionEndDateTime],
              [RunTimeInSeconds],
              [PackageUniqueID],
              [executionLog].[PackageID],
              [LogID],
              [ExecutionID],
              [AverageRuntimeSeconds],
              [PackageRuntimeStdDev]

    SELECT [averages].[PackageUniqueID] AS [PackageID], 
           [PackageName], 
           [ExecutionCount], 
           [AverageRuntimeSeconds], 
           [PackageRuntimeStdDev], 
           [GoodCount], 
           [WarningCount], 
           [ErrorCount]
      FROM [#PackageRuntimeAvgTbl] averages INNER JOIN 
           (SELECT [PackageUniqueID], 
                   SUM(CASE WHEN ABS([ZScore]) < 1 THEN 1 ELSE 0 END) AS [GoodCount],
                   SUM(CASE WHEN ABS([ZScore]) >= 1 AND ABS([ZScore]) < 2 THEN 1 ELSE 0 END) AS [WarningCount],
                   SUM(CASE WHEN ABS([ZScore]) > 2 THEN 1 ELSE 0 END) AS [ErrorCount]
              FROM [#PackageDetailsTable]
             GROUP BY [PackageUniqueID]) NormalScores 
        ON [NormalScores].[PackageUniqueID] = [averages].[PackageUniqueID]

    SELECT [LogID], 
           [PackageUniqueID] AS [PackageID],
           [ExecutionID],
           [ExecutionStart], 
           [ExecutionEnd], 
           [RunTimeInSeconds], 
           [ZScore]
      FROM [#PackageDetailsTable]

    SELECT [ExecutionID], [sl].[TasklistXML], [sl].[LayoutID]
      FROM [dbo].[SSISPackageLayout] [sl] INNER JOIN 
           #SSISPackageExecutionLog [sel] 
        ON [sel].[LayoutID] = [sl].[LayoutID]

    SELECT [tasks].[ExecutionID], [SourceID], [tasks].[ExecutionStartDateTime], [tasks].[ExecutionEndDateTime]
      FROM [dbo].[SSISTaskExecutionLog] tasks INNER JOIN 
           #SSISPackageExecutionLog [sel] 
        ON [sel].[ExecutionID] = [tasks].[ExecutionID]  

    IF ISNULL(@IncludeDataFlows, 0) = 1
    BEGIN
      SELECT [event], [df].[executionid], [sourceid], [starttime], [endtime], [message]
        FROM [dbo].[SSISDataFlowExecutionLog] df INNER JOIN 
             #SSISPackageExecutionLog [sel] 
          ON [sel].[ExecutionID] = [df].[executionid]
    END

    DROP TABLE #SSISPackageExecutionLog
    DROP TABLE #PackageDetailsTable
    DROP TABLE #PackageRuntimeAvgTbl

GO
