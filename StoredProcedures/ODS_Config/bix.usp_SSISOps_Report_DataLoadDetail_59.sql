/****** Object:  StoredProcedure [bix].[usp_SSISOps_Report_DataLoadDetail_59]    Script Date: 5/15/2018 12:11:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/*
    Source : Pragmatic Works - BI xPress Auditing Framework 59
    Created On : 2/19/2016
    Purpose : 
        - Displays extract/load detail.
*/
CREATE PROCEDURE [bix].[usp_SSISOps_Report_DataLoadDetail_59]
(
     @Status varchar(255) = 'ALL'
    ,@PackageNameFilter varchar(255) = null
    ,@MachineName varchar(255) = '%'
    ,@ExecutionAccountName varchar(255) = '%'
    ,@ExecutionMode varchar(255) = 'ALL'
    ,@IntervalType varchar(10) = 'd'
    ,@MaxColCount int = null
    ,@DataSourceFilter varchar(255) = '%'
    ,@CatalogFilter varchar(255) = '%'
    ,@DataSourceObjectFilter varchar(255) = '%'
    ,@StartDate datetime = null
    ,@EndDate datetime = null
    ,@ShowQuery varchar(10) = null
    ,@ShowConnStr varchar(10) = null
)
AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @CurrentDate DATETIME
    
    SET @CurrentDate = GETDATE()

    IF @StartDate IS NULL
        SET @StartDate = DATEADD(YEAR, -1, @CurrentDate)

    IF @EndDate IS NULL
        SET @EndDate = @CurrentDate

    SELECT a.ExecutionID
        ,a.ExecutionStartDateTime as P_ExecutionStartDateTime
        ,a.ExecutionEndDateTime as P_ExecutionEndDateTime
        ,a.TotalErrorCount as P_TotalErrorCount
        ,a.TotalWarningCount as P_TotalWarningCount
        ,b.ExecutionStartDateTime
        ,b.ExecutionEndDateTime
        ,b.TotalErrorCount as  TotalErrorCount
        ,b.TotalWarningCount as TotalWarningCount
        ,a.PackageName
        ,b.SourceName
        ,c.ComponentTypeCode
        ,c.ComponentTypeName
        ,c.ComponentName
        ,a.TotalRecordsExtracted
        ,a.TotalRecordsLoaded
        ,Sum(c.RecordCount) as RecordCount
        ,DataSourceObject=
            (case 
                when c.DataObjectType IN('TableOrView') then Isnull(c.DataObjectName,'UNKNOWN') --Additional Info
                when c.DataObjectType IN('VariableTableOrView') then Isnull(c.DataObjectQuery,'UNKNOWN') --Additional Info
                when c.DataObjectType IN('SqlCommand') then Isnull(c.DataObjectQuery,'UNKNOWN') --Additional Info
                when c.DataObjectType IN('VariableSqlCommand') then Isnull(c.DataObjectQuery,'UNKNOWN') --Additional Info
                when c.DataObjectType IN('XMLFile','RawFile','FlatFile','VariableFileName') then Isnull(c.DataObjectDataSource,'UNKNOWN') --Additional Info
                else Isnull(c.DataObjectName,'UNKNOWN')
            end)
        ,c.DataObjectConnectionString
        ,c.DataObjectDataSource
        ,c.DataObjectCatalog
        ,c.DataObjectUserName	
        ,c.ParentLogID	
        ,Isnull(a.LayoutID,0) as LayoutID	
    FROM [bix].[vw_SSISPackageExecutionLog_59] a
    JOIN [bix].[vw_SSISTaskExecutionLog_59] b
        on a.ExecutionID = b.ExecutionID
    JOIN [bix].[vw_SSISPackageRowCountLog_59] c
        on b.[ExecutionID] = c.[ExecutionID] AND b.[LogID] = ISNULL(c.[ParentLogID], b.[LogID]) AND b.[SourceID] = c.[SourceID]
    where a.[ExecutionStartDateTime] between @StartDate and @EndDate
        and a.[ExecutionEndDateTime] IS NOT NULL
        and c.DataObjectDataSource LIKE @DataSourceFilter
        and a.PackageName LIKE @PackageNameFilter
        and c.DataObjectCatalog LIKE @CatalogFilter
        and (c.DataObjectQuery LIKE @DataSourceObjectFilter or c.DataObjectName LIKE @DataSourceObjectFilter)
            And (isnull(a.[TotalErrorCount],0) >=(case when isnull(@Status,'')='ERROR' then 1 else 0 end))
            And (isnull(a.[TotalWarningCount],0) >=(case when isnull(@Status,'')='WARNING' then 1 else 0 end))
        and a.UserName LIKE @ExecutionAccountName
        and a.MachineName LIKE @MachineName
        and a.InteractiveMode = (Case @ExecutionMode
            When 'ALL' then a.InteractiveMode 
            When 'I' then 1
            else 0
            end)
    group by a.ExecutionID
        ,c.ParentLogID	 
        ,c.ComponentName
        ,a.PackageName
        ,a.ExecutionStartDateTime
        ,a.ExecutionEndDateTime
        ,b.ExecutionStartDateTime
        ,b.ExecutionEndDateTime
        ,a.LogDate
        ,a.TotalRecordsExtracted
        ,a.TotalRecordsLoaded
        ,b.SourceName
        ,c.DataObjectName
        ,c.ComponentTypeCode
        ,c.DataObjectType
        ,c.DataObjectConnectionString
        ,c.DataObjectConnectionName
        ,c.DataObjectConnectionName
        ,c.ComponentTypeName
        ,c.ComponentName
        ,c.DataObjectQuery
        ,c.DataObjectDataSource
        ,c.DataObjectCatalog
        ,c.DataObjectUserName
        ,a.TotalErrorCount
        ,a.TotalWarningCount
        ,b.TotalErrorCount
        ,b.TotalWarningCount
        ,a.LayoutID

    SET NOCOUNT OFF
END

GO
