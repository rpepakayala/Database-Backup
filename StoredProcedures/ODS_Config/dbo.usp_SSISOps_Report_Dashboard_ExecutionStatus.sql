/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Report_Dashboard_ExecutionStatus]    Script Date: 5/15/2018 12:11:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
 * Object: usp_SSISOps_Report_Dashboard_ExecutionStatus
 * --------------------------------------------------------------
 * Created By: Matt Whitfield
 * Source : Pragmatic Works - BI xPress Auditing Framework 47
 * Created On : 6/13/2013
 * --------------------------------------------------------------
 */
CREATE PROCEDURE [dbo].[usp_SSISOps_Report_Dashboard_ExecutionStatus]
 @Status varchar(255)='ALL'
,@PackageNameFilter varchar(255)='%'
,@MachineName varchar(255)='%'
,@ExecutionAccountName varchar(255)='%'
,@ExecutionMode varchar(255)='ALL'
,@IntervalType varchar(10)='d'
,@MaxColCount int=1
AS
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT 
    a.[PackageName]
   ,a.[TotalErrorCount]
   ,a.[TotalWarningCount]
   ,a.[ExecutionStartDateTime]
   ,a.[ExecutionEndDateTime]
   ,a.[MachineName]
   ,ExecutionStatus=(case 
        --//If anything before 2 days and still No end date then must be stopped 
        when (a.[ExecutionStartDateTime]> getdate()-2 and a.[ExecutionEndDateTime] is null) then 'Running'
        when (a.[ExecutionEndDateTime] is not null) then 'Completed'
        else 'Unknown'
    END	) 
    ,convert([bigint],ISNULL(b.LoadedRecordCount,0)) as LoadedRecordCount
    ,Isnull(a.LayoutID,0) as LayoutID
    ,a.ExecutionID
FROM [dbo].[fn_SSISOps_Report_LogRowsByInterval](@Status, @PackageNameFilter, @MachineName, @ExecutionAccountName, @ExecutionMode, @IntervalType, @MaxColCount) a
LEFT OUTER JOIN (select ExecutionID,Sum(RecordCount) as LoadedRecordCount from dbo.SSISPackageRowCountLog where ComponentTypeCode='DEST' group by ExecutionID) b ON a.ExecutionID=b.ExecutionID 

GO
