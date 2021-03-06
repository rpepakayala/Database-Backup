/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Report_DataLoad]    Script Date: 5/15/2018 12:11:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/*
	Source : Pragmatic Works - BI xPress Auditing Framework 22
	Created On : 12/18/2012
	Purpose : 
		- Displays extract/load summary.
*/
CREATE PROCEDURE [dbo].[usp_SSISOps_Report_DataLoad]
 @Status varchar(255)='ALL'
,@PackageNameFilter varchar(255)=null
,@MachineName varchar(255)='%'
,@ExecutionAccountName varchar(255)='%'
,@ExecutionMode varchar(255)='ALL'
,@IntervalType varchar(10)='d'
,@MaxColCount int=null
,@DataSourceFilter varchar(255)='%'
,@CatalogFilter varchar(255)='%'
,@DataSourceObjectFilter varchar(255)='%'
,@ShowQuery varchar(10)=null
,@ShowConnStr varchar(10)=null
AS

/* AUTO GENERATED CODE - DO NOT MODIFY */

/*
RowLabel_1 = ComponentTypeCode
RowLabel_2 = DataObjectName
RowLabel_3 = PackageName
RowLabel_4 = Additional info (Conn Str, Conn Name, Query...)
RowLabel_5 = ComponentName
RowLabel_6 = Data Flow Name
RowLabel_7 = Component Type Name
*/

SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	

SELECT 
   RowLabel_1=b.[ComponentTypeCode]
  ,RowLabel_2=(case 
				when b.DataObjectType in('RawFile','TableOrView','FlatFile') then b.[DataObjectName]
				---when b.DataObjectType in('VariableFileName','TableOrView','FlatFile') then (case when charindex('\',reverse(b.DataObjectDataSource))>0 then right(b.DataObjectDataSource,charindex('\',reverse(b.DataObjectDataSource))-1) else b.DataObjectDataSource end)

				when b.DataObjectType in('VariableFileName','TableOrView','FlatFile') then b.DataObjectDataSource
				--when b.DataObjectType in('VariableSqlCommand','SqlCommand') then Left(b.DataObjectQuery,40) + ' ...'
				when b.DataObjectType in('VariableSqlCommand','SqlCommand') then b.DataObjectQuery
				when b.DataObjectType in('VariableTableOrView','Variable') then b.DataObjectQuery
				else b.DataObjectName
			  end)	 
  ,RowLabel_3=a.[PackageName]
  ,RowLabel_4= 'Connection String : ' + isnull(b.DataObjectConnectionString,'') + char(13) +  char(10)  + char(13) +  char(10) 
			 + 'Data Flow Name : ' + isnull(b.SourceName,'') + char(13) +  char(10)  + char(13) +  char(10) 	
			 + 'Connection Name : ' + isnull(b.DataObjectConnectionName,'') + char(13) +  char(10) 	 + char(13) +  char(10) 	
			 + 'Component Name/Type : ' + isnull(b.ComponentName,'') + ' ('+ isnull(b.ComponentTypeName,'') + ')' + char(13) +  char(10)  + char(13) +  char(10) 		
			 + (case 
				 when b.DataObjectType IN('TableOrView') then 'Table/View Name : ' + Isnull(b.DataObjectName,'UNKNOWN') --Additional Info
				 when b.DataObjectType IN('VariableTableOrView') then 'Table/View Name : ' + Isnull(b.DataObjectQuery,'UNKNOWN') --Additional Info
				 when b.DataObjectType IN('SqlCommand') then 'Query : ' + Isnull(b.DataObjectQuery,'UNKNOWN') --Additional Info
				 when b.DataObjectType IN('VariableSqlCommand') then 'Query : ' + Isnull(b.DataObjectQuery,'UNKNOWN') --Additional Info
				 when b.DataObjectType IN('XMLFile','RawFile','FlatFile','VariableFileName') then 'File Path : ' + Isnull(b.DataObjectDataSource,'UNKNOWN') --Additional Info
			    end)	
			
  ,RowLabel_5=b.ComponentName
  ,RowLabel_6=c.SourceName
  ,RowLabel_7=b.ComponentTypeName

  ,ColLabel_1=(case @IntervalType
				when 'd' then convert(varchar(10),a.[LogDate],101)
				when 'w' then cast(DatePart(week, a.[LogDate]) as varchar(10))
				when 'm' then cast(DatePart(month, a.[LogDate]) as varchar(10))
				when 'y' then cast(DatePart(year, a.[LogDate]) as varchar(10))
			  end)
  ,ColLabel_2=''
  ,ColLabel_3=''
  ,ColLabel_4=''
  ,ColLabel_5=''
  ,ColLabel_6=''
  ,ColLabel_7=''

  ,Measure_1=Avg(b.[RecordCount])
  ,Measure_2=(Case when b.[ComponentTypeCode]='SRC' then Avg(b.[RecordCount]) else 0 end)	--//Extracted
  ,Measure_3=(Case when b.[ComponentTypeCode]='DEST' then Avg(b.[RecordCount]) else 0 end)	--//Loaded
  ,Measure_4=0
  ,Measure_5=0
  ,Measure_6=0
  ,Measure_7=0
  ,Isnull(a.LayoutID,0) as LayoutID
  ,a.ExecutionID
FROM [SSISPackageExecutionLog] a
JOIN [SSISPackageRowCountLog] b
	on a.ExecutionID=b.ExecutionID
LEFT OUTER JOIN [SSISTaskExecutionLog] c
	on b.ExecutionID=c.ExecutionID And b.SourceID=c.SourceID
where a.[LogDate] >= (case @IntervalType
						when 'd' then DateAdd(day,  @MaxColCount * (-1),getdate())
						when 'w' then DateAdd(week,  @MaxColCount * (-1),getdate())
						when 'm' then DateAdd(month,  @MaxColCount * (-1),getdate())
						when 'y' then DateAdd(year,  @MaxColCount * (-1),getdate())
						else DateAdd(day,  @MaxColCount * (-1),getdate())
					  end)--(Datediff(day,a.[LogDate],getdate()) <= @MaxColCount ) and getdate()
and a.[ExecutionEndDateTime] IS NOT NULL
	And (isnull(a.[TotalErrorCount],0) >=(case when isnull(@Status,'')='ERROR' then 1 else 0 end))
	And (isnull(a.[TotalWarningCount],0) >=(case when isnull(@Status,'')='WARNING' then 1 else 0 end))
and a.PackageName LIKE @PackageNameFilter
and a.UserName LIKE @ExecutionAccountName
and a.MachineName LIKE @MachineName
and a.InteractiveMode = (Case @ExecutionMode
When 'ALL' then a.InteractiveMode 
When 'I' then 1
else 0
end)
and b.DataObjectDataSource LIKE @DataSourceFilter
and b.DataObjectCatalog LIKE @CatalogFilter
and (b.DataObjectQuery LIKE @DataSourceObjectFilter or b.DataObjectName LIKE @DataSourceObjectFilter)

group by c.SourceName,b.ComponentName,a.[PackageName],b.[DataObjectName],b.[ComponentTypeCode],b.[DataObjectType],b.DataObjectConnectionString,b.SourceName,b.DataObjectConnectionName,b.DataObjectConnectionName,b.ComponentTypeName,b.ComponentName,b.DataObjectQuery,b.DataObjectDataSource
,(case @IntervalType
				when 'd' then convert(varchar(10),a.[LogDate],101)
				when 'w' then cast(DatePart(week, a.[LogDate]) as varchar(10))
				when 'm' then cast(DatePart(month, a.[LogDate]) as varchar(10))
				when 'y' then cast(DatePart(year, a.[LogDate]) as varchar(10))
			  end)
  ,a.LayoutID
  ,a.ExecutionID
 order by b.[ComponentTypeCode],b.[DataObjectName],a.[PackageName]

GO
