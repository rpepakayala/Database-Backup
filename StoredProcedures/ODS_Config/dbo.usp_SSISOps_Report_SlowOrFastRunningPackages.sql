/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Report_SlowOrFastRunningPackages]    Script Date: 5/15/2018 12:11:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
	Source : Pragmatic Works - BI xPress Auditing Framework 22
	Created On : 12/18/2012
	Purpose : 
		- This report displays packages which are running slower or faster than usual trend. Difference of Current vs Avg Runtime is compared to Standard Deviation to determine considerable increase or drop in performance.
*/

CREATE PROCEDURE [dbo].[usp_SSISOps_Report_SlowOrFastRunningPackages]
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
As

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

if @StartDate is null
	set @StartDate=getdate()-365 --//Based on one year
if @EndDate is null
	set @EndDate=getdate()

declare @tmpPackageID table(
	[ExecutionID] [varchar](50) NULL,
	[PackageName] [nvarchar](255) NOT NULL,
	[PackageID] [varchar](50) NOT NULL,
	[ExecutionStartDateTime] [datetime] NOT NULL,
	[ExecutionEndDateTime] [datetime] NULL,
	[ExecutionTime] [int] NULL,
	[RunTimeSecAvg] [int] NULL,
	[RunTimeSTDev] [int] NULL,
	[ExecTimeAvgTimeDiff] [int] NULL
	--[IsGreaterThanStandDev] [int] NOT NULL
) 

insert into @tmpPackageID
EXECUTE usp_SSISOps_Report_GetSlowOrFastPackageListing
   @Status
  ,@PackageNameFilter
  ,@MachineName
  ,@ExecutionAccountName
  ,@ExecutionMode
  ,@StartDate
  ,@EndDate
  ,@UpperThreashold
  ,@LowerThreashold

select * from 
( 
	Select 
		RN = ROW_NUMBER() OVER (PARTITION BY EL.PackageName ORDER BY EL.ExecutionStartDateTime DESC),
		Cast(EL.ExecutionID as varchar(50))as ExecutionID,
		EL.PackageName,
		EL.PackageID,
		EL.MachineName,
		EL.UserName,
		EL.ExecutionStartDateTime,
		EL.ExecutionEndDateTime,
		TotalRecordsExtracted,
		TotalRecordsLoaded,
		ISNULL(DATEDIFF(second,EL.[ExecutionStartDateTime], EL.[ExecutionEndDateTime]),0) as ExecutionTime
	From dbo.SSISPackageExecutionLog EL
	Join @tmpPackageID GP on EL.PackageName COLLATE DATABASE_DEFAULT = GP.PackageName COLLATE DATABASE_DEFAULT 
	WHERE EL.[ExecutionEndDateTime] IS NOT NULL
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
) as a
where RN <= @HowManyExecutions

GO
