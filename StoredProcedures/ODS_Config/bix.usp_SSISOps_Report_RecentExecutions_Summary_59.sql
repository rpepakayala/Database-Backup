/****** Object:  StoredProcedure [bix].[usp_SSISOps_Report_RecentExecutions_Summary_59]    Script Date: 5/15/2018 12:11:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/*
    Source : Pragmatic Works - BI xPress Auditing Framework 59
    Created On : 2/19/2016
    Purpose : 
        - Displays summary of executions (without task detail) about packages already completed or running.
    example :
        EXEC [bix].[usp_SSISOps_Report_RecentExecutions_Summary_59] @StartDate='8/2/2010', @EndDate='9/3/2010', @PackageNameFilter='%'
*/
CREATE PROCEDURE [bix].[usp_SSISOps_Report_RecentExecutions_Summary_59]
(
    @Status varchar(255) = 'ALL'
    ,@PackageNameFilter varchar(255) = null
    ,@MachineName varchar(255) = '%'
    ,@ExecutionAccountName varchar(255) = '%'
    ,@ExecutionMode varchar(255) = 'ALL'
    ,@StartDate datetime = null
    ,@EndDate datetime = null
    ,@ShowOnlyRunning int = 0
)
AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	

    DECLARE @CurrentDate AS DATETIME
    
    SET @CurrentDate = GETDATE()

    IF @StartDate IS NULL
        SET @StartDate = DATEADD(YEAR, -1, @CurrentDate)

    IF @EndDate IS NULL
        SET @EndDate = @CurrentDate

    IF @ShowOnlyRunning IS NULL
        set @ShowOnlyRunning = 0
    
    IF @Status = 'RUNNING'
        set @ShowOnlyRunning = 1
    
    IF @Status = 'SUCCESS'
    begin
        set @ShowOnlyRunning = 0
        set @Status = null
    end

    Declare @MaxChars int 
    select @MaxChars = SettingValue	FROM [bix].[vw_SSISGlobalSettings_59] Where SettingKey = 'SSISOpsMaxVarLength'
    set @MaxChars = isnull(@MaxChars,15000)
        
    SELECT a.[ExecutionID]
      ,a.[PackageName]
      ,a.[InteractiveMode]
      ,a.[UserName]
      ,a.[MachineName]
      ,a.[ExecutionStartDateTime] as P_ExecutionStartDateTime
      ,a.[ExecutionEndDateTime] as P_ExecutionEndDateTime
      ,a.[TotalErrorCount] as P_TotalErrorCount
      ,a.[TotalWarningCount] as P_TotalWarningCount
      ,a.[TotalRecordsExtracted] as P_TotalRecordsExtracted
      ,a.[TotalRecordsLoaded] as P_TotalRecordsLoaded
      ,c.[EventType]
      ,c.[MessageDescription]
      ,ISNULL(a.[LayoutID], 0) as LayoutID
      ,Variables = (Case when DATALENGTH(a.[Variables]) > @MaxChars then left(cast(a.[Variables] as varchar(max)), @MaxChars) + ' ***<LARGE VALUE - DATA TRUNCATED - Original Length ' + CAST(DATALENGTH(a.[Variables])/1024 as Varchar(100)) + ' KB (to modify truncation limit change value in SSISGlobalSettings table)>' else a.[Variables] end)
      ,a.[Connections]  
    FROM [bix].[vw_SSISPackageExecutionLog_59] a
        LEFT OUTER JOIN [bix].[vw_SSISTaskExecutionAlerts_59] c on (a.ExecutionID = c.ExecutionID)
    where (a.[ExecutionStartDateTime] between @StartDate and @EndDate or (@ShowOnlyRunning=1 and a.[ExecutionEndDateTime] IS NULL and a.[ExecutionStartDateTime] > @CurrentDate - 2))
        And (isnull(a.[TotalErrorCount],0) >=(case when isnull(@Status,'') = 'ERROR' then 1 else 0 end))
        And (isnull(a.[TotalWarningCount],0) >=(case when isnull(@Status,'') = 'WARNING' then 1 else 0 end))
        And a.PackageName LIKE @PackageNameFilter
        And a.UserName LIKE @ExecutionAccountName
        And a.MachineName LIKE @MachineName
        And a.InteractiveMode = (Case @ExecutionMode
            When 'ALL' then a.InteractiveMode 
            When 'I' then 1
            else 0
            end)
    Order By a.[ExecutionStartDateTime] Desc

    SET NOCOUNT OFF
END

GO
