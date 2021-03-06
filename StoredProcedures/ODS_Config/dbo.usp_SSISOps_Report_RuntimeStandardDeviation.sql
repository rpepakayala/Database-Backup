/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Report_RuntimeStandardDeviation]    Script Date: 5/15/2018 12:11:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
 /*
 * --------------------------------------------------------------
 * Updated By: Matt Whitfield - 11/20/2012
 * Source : Pragmatic Works - BI xPress Auditing Framework 50
 * Created On : 11/7/2013
 * Purpose : 
 *     - This report displays packages which are running slower or faster than usual trend. Difference of Current vs Avg Runtime is compared to Standard Deviation to determine considerable increase or drop in performance.
 * --------------------------------------------------------------
 */

CREATE PROCEDURE [dbo].[usp_SSISOps_Report_RuntimeStandardDeviation]
     @Status varchar(255)='ALL'
    ,@PackageNameFilter varchar(255)='%'
    ,@MachineName varchar(255)='%'
    ,@ExecutionAccountName varchar(255)='%'
    ,@ExecutionMode varchar(255)='ALL'
    ,@StartDate datetime=null
    ,@EndDate datetime=null
    ,@UpperThreshold float=1
    ,@LowerThreshold float=-1
    ,@HowManyExecutions int=10
AS
CREATE TABLE #tmpPackageID (
    [UniqueID] [int] IDENTITY (1, 1) NOT NULL,
    [PackageName] [nvarchar](255) NOT NULL,
    [PackageID] [uniqueidentifier] NOT NULL,
    [LastExecutionStartDateTime] [datetime] NOT NULL,
    [LastExecutionEndDateTime] [datetime] NULL,
    [ExecutionTimeSeconds] [float] NULL,
    [RunTimeSecondsAverage] [float] NULL,
    [RecentRunTimeSecondsAverage] [float] NULL,
    [RunTimeSTDev] [float] NULL,
) 

CREATE TABLE [#SSISPackageExecutionLog] (
      [PackageName] [nvarchar] (255) NOT NULL,
      [PackageID] [uniqueidentifier] NOT NULL,
      [MachineName] [nvarchar] (255) NOT NULL,
      [UserName] [nvarchar] (255) NOT NULL,
      [ExecutionStartDateTime] [datetime] NOT NULL,
      [ExecutionEndDateTime] [datetime] NOT NULL,
      [TotalRecordsExtracted] [bigint] NOT NULL,
      [TotalRecordsLoaded] [bigint] NOT NULL)
      
CREATE TABLE [#NumberedExecutions] (
      [__RN] [int] NOT NULL,
      [PackageName] [nvarchar] (255) NOT NULL,
      [PackageID] [uniqueidentifier] NOT NULL,
      [MachineName] [nvarchar] (255) NOT NULL,
      [UserName] [nvarchar] (255) NOT NULL,
      [ExecutionStartDateTime] [datetime] NOT NULL,
      [ExecutionEndDateTime] [datetime] NOT NULL,
      [TotalRecordsExtracted] [bigint] NOT NULL,
      [TotalRecordsLoaded] [bigint] NOT NULL)

if @EndDate is null
    set @EndDate=getdate()
if @StartDate is null
    set @StartDate=DATEADD(yy, -1, @EndDate)

if @UpperThreshold is null
    set @UpperThreshold=1;
if @LowerThreshold is null
    set @LowerThreshold=-1;     

INSERT INTO [#SSISPackageExecutionLog] ([PackageName], [PackageID], [MachineName], [UserName], [ExecutionStartDateTime], [ExecutionEndDateTime], [TotalRecordsExtracted], [TotalRecordsLoaded])
SELECT [PackageName], [PackageID], [MachineName], [UserName], [ExecutionStartDateTime], ISNULL([ExecutionEndDateTime], GETDATE()), [TotalRecordsExtracted], [TotalRecordsLoaded] 
  FROM [dbo].[fn_SSISOps_Report_LogRowsByStartDateEndDate](@Status, @PackageNameFilter, @MachineName, @ExecutionAccountName, @ExecutionMode, @StartDate, @EndDate) [log]
  WHERE [ExecutionEndDateTime] IS NOT NULL
    AND [ExecutionEndDateTime] >= [ExecutionStartDateTime];

INSERT INTO [#NumberedExecutions] ([__RN], [PackageName], [PackageID], [MachineName], [UserName], [ExecutionStartDateTime], [ExecutionEndDateTime], [TotalRecordsExtracted], [TotalRecordsLoaded])
SELECT [__RN], [PackageName], [PackageID], [MachineName], [UserName], [ExecutionStartDateTime], [ExecutionEndDateTime], [TotalRecordsExtracted], [TotalRecordsLoaded] FROM (
SELECT ROW_NUMBER() OVER (PARTITION BY [PackageName], [PackageID] ORDER BY [ExecutionStartDateTime] DESC) AS __RN,
      [PackageName], [PackageID], [MachineName], [UserName], [ExecutionStartDateTime], [ExecutionEndDateTime], [TotalRecordsExtracted], [TotalRecordsLoaded]
      FROM #SSISPackageExecutionLog
      WHERE [ExecutionEndDateTime] IS NOT NULL
        AND [ExecutionEndDateTime] >= [ExecutionStartDateTime]
      ) numbered
WHERE [__RN] <= @HowManyExecutions;

WITH [RunTimeAverages] ([PackageName], [PackageID], [RunTimeSecAvg], [RunTimeSTDev]) 
  AS (SELECT [PackageName],
             [PackageID],
             AVG(DATEDIFF(second,[ExecutionStartDateTime], [ExecutionEndDateTime])) AS RunTimeSecAvg,
             STDEV(DATEDIFF(second,[ExecutionStartDateTime], [ExecutionEndDateTime])) AS RunTimeSTDev
        FROM #SSISPackageExecutionLog
    GROUP BY [PackageName], [PackageID]),
     [RunTimeAveragesLastX] ([PackageName], [PackageID], [RunTimeSecAvg], LastStartTime, LastEndTime) 
  AS (SELECT [PackageName],
             [PackageID],
             AVG(DATEDIFF(second,[ExecutionStartDateTime], [ExecutionEndDateTime])) AS RunTimeSecAvg,
             MAX(CASE WHEN [__RN] = 1 THEN [ExecutionStartDateTime] ELSE NULL END),
             MAX(CASE WHEN [__RN] = 1 THEN [ExecutionEndDateTime] ELSE NULL END)
        FROM #NumberedExecutions
    GROUP BY [PackageName], [PackageID])
INSERT INTO [#tmpPackageID] ([PackageName], [PackageID], [LastExecutionStartDateTime], [LastExecutionEndDateTime], [ExecutionTimeSeconds], [RunTimeSecondsAverage], [RecentRunTimeSecondsAverage], [RunTimeSTDev])
SELECT [rta].[PackageName], [rta].[PackageID], [rtalx].[LastStartTime], [rtalx].[LastEndTime], DATEDIFF(millisecond,[rtalx].[LastStartTime], [rtalx].[LastEndTime]) / 1000.0, [rta].[RunTimeSecAvg], rtalx.[RunTimeSecAvg], [rta].[RunTimeSTDev] FROM [RunTimeAverages] [rta] INNER JOIN [RunTimeAveragesLastX] [rtalx] ON
 [rtalx].[PackageID] = [rta].[PackageID] AND [rtalx].[PackageName] = [rta].[PackageName]
WHERE (([rta].[RunTimeSecAvg] - [rtalx].[RunTimeSecAvg]) > [rta].[RunTimeSTDev] * @UpperThreshold  or 
       ([rta].[RunTimeSecAvg] - [rtalx].[RunTimeSecAvg]) < [rta].[RunTimeSTDev] * @LowerThreshold)

SELECT [UniqueID], [PackageName], [LastExecutionStartDateTime], [LastExecutionEndDateTime], [ExecutionTimeSeconds], [RunTimeSecondsAverage], [RecentRunTimeSecondsAverage], [RunTimeSTDev] FROM #tmpPackageID
SELECT [UniqueID], [MachineName], [UserName], [ExecutionStartDateTime], [ExecutionEndDateTime], [TotalRecordsExtracted], [TotalRecordsLoaded]
FROM #NumberedExecutions a
inner Join #tmpPackageID GP ON a.PackageName = GP.PackageName AND a.[PackageID] = [GP].[PackageID]	

DROP TABLE #tmpPackageID
DROP TABLE #SSISPackageExecutionLog
DROP TABLE #NumberedExecutions

GO
