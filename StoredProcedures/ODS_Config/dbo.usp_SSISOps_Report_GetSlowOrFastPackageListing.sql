/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Report_GetSlowOrFastPackageListing]    Script Date: 5/15/2018 12:11:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
	Source : Pragmatic Works - BI xPress Auditing Framework 22
	Created On : 12/18/2012
	Purpose : 
		- This proc is used by usp_SSISOps_Report_SlowOrFastRunningPackages to provide data about packages which are running slower or faster than usual trend using Standard Deviation calculation.
*/

CREATE PROCEDURE [dbo].[usp_SSISOps_Report_GetSlowOrFastPackageListing]
 @Status varchar(255)='ALL'
,@PackageNameFilter varchar(255)='%'
,@MachineName varchar(255)='%'
,@ExecutionAccountName varchar(255)='%'
,@ExecutionMode varchar(255)='ALL'
,@StartDate datetime=null
,@EndDate datetime=null
,@UpperThreashold float=1
,@LowerThreashold float=-1
,@HowManyExecutions int=10
AS

/* AUTO GENERATED CODE - DO NOT MODIFY */

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

if @StartDate is null
	set @StartDate=getdate()-365 --//Based on one year
if @EndDate is null
	set @EndDate=getdate()

if @UpperThreashold is null
	set @UpperThreashold=1
if @LowerThreashold is null
	set @LowerThreashold=-1

SELECT
	Cast(ExecutionID as varchar(50))as ExecutionID,
	EL.PackageName,
	EL.PackageID,
	ExecutionStartDateTime,
	ExecutionEndDateTime,
	DATEDIFF(second,[ExecutionStartDateTime], [ExecutionEndDateTime]) as ExecutionTime,
	RunTimeSecAvg,
	RunTimeSTDev,
	DATEDIFF(second,[ExecutionStartDateTime], [ExecutionEndDateTime])-RunTimeSecAvg as ExecTimeAvgTimeDiff
	--'IsGreaterThanStandDev'= case
	--	when (DATEDIFF(second,[ExecutionStartDateTime], [ExecutionEndDateTime])-RunTimeSecAvg)* @UpperThreashold > RunTimeSTDev then 1
	--	when (DATEDIFF(second,[ExecutionStartDateTime], [ExecutionEndDateTime])-RunTimeSecAvg)* @LowerThreashold > RunTimeSTDev then 1
	--	else 0
	--	end
From dbo.SSISPackageExecutionLog EL 
join ( select PackageName,PackageID, MAX(ExecutionStartDateTime)as LastStartDate
	   From dbo.SSISPackageExecutionLog EL
	   Group By PackageName,PackageID
) MS
	on MS.LastStartDate = EL.ExecutionStartDateTime and MS.PackageName = EL.PackageName and MS.PackageID = EL.PackageID 
join (
		SELECT [PackageName],[PackageID] 
		 ,AVG(DATEDIFF(second,[ExecutionStartDateTime], [ExecutionEndDateTime])) as RunTimeSecAvg
		 ,CAST(STDEV(DATEDIFF(second,[ExecutionStartDateTime], [ExecutionEndDateTime])) as Int) as RunTimeSTDev
		FROM [dbo].[SSISPackageExecutionLog] EL
		WHERE EL.[ExecutionStartDateTime] between @StartDate and @EndDate
		AND EL.[ExecutionEndDateTime] IS NOT NULL
		AND (isnull(EL.[TotalErrorCount],0) >=(case when isnull(@Status,'')='ERROR' then 1 else 0 end))
		AND (isnull(EL.[TotalWarningCount],0) >=(case when isnull(@Status,'')='WARNING' then 1 else 0 end))
		AND EL.PackageName Like @PackageNameFilter
		AND EL.UserName LIKE @ExecutionAccountName
		AND EL.MachineName LIKE @MachineName
		AND EL.InteractiveMode = (Case @ExecutionMode
			When 'ALL' then EL.InteractiveMode 
			When 'I' then 1
			else 0
			end)      
		GROUP BY  [PackageName],[PackageID]
) ES 
	on EL.PackageName= ES.PackageName and EL.PackageID= ES.PackageID
Where ((DATEDIFF(second,[ExecutionStartDateTime], [ExecutionEndDateTime])-RunTimeSecAvg)* @UpperThreashold > ES.RunTimeSTDev or 
       (DATEDIFF(second,[ExecutionStartDateTime], [ExecutionEndDateTime])-RunTimeSecAvg)* @LowerThreashold > ES.RunTimeSTDev
      )
AND EL.[ExecutionStartDateTime] between @StartDate and @EndDate
AND (isnull(EL.[TotalErrorCount],0) >=(case when isnull(@Status,'')='ERROR' then 1 else 0 end))
AND (isnull(EL.[TotalWarningCount],0) >=(case when isnull(@Status,'')='WARNING' then 1 else 0 end))
AND EL.PackageName Like @PackageNameFilter
AND EL.UserName LIKE @ExecutionAccountName
AND EL.MachineName LIKE @MachineName
AND EL.InteractiveMode = (Case @ExecutionMode
	When 'ALL' then EL.InteractiveMode 
	When 'I' then 1
	else 0
	end)      


GO
