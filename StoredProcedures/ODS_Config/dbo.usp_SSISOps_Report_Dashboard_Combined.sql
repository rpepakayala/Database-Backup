/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Report_Dashboard_Combined]    Script Date: 5/15/2018 12:11:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
 * Object: usp_SSISOps_Report_Dashboard_Combined
 * --------------------------------------------------------------
 * Created By: Matt Whitfield
 * Source : Pragmatic Works - BI xPress Auditing Framework 47
 * Created On : 6/13/2013
 * --------------------------------------------------------------
 */
CREATE PROCEDURE [dbo].[usp_SSISOps_Report_Dashboard_Combined]
 @Status varchar(255)='ALL'
,@PackageNameFilter varchar(255)='%'
,@MachineName varchar(255)='%'
,@ExecutionAccountName varchar(255)='%'
,@ExecutionMode varchar(255)='ALL'
,@IntervalType varchar(10)='d'
,@MaxColCount int=1
AS
EXECUTE [dbo].[usp_SSISOps_Report_Dashboard_ExecutionStatus] @Status, @PackageNameFilter, @MachineName, @ExecutionAccountName, @ExecutionMode, @IntervalType, @MaxColCount
EXECUTE [dbo].[usp_SSISOps_Report_Dashboard_Top20s] @Status, @PackageNameFilter, @MachineName, @ExecutionAccountName, @ExecutionMode, @IntervalType, @MaxColCount

GO
