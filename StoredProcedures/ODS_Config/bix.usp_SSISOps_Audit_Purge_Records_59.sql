/****** Object:  StoredProcedure [bix].[usp_SSISOps_Audit_Purge_Records_59]    Script Date: 5/15/2018 12:11:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
Source : Pragmatic Works - BI xPress Auditing Framework 59
Created On : 2/19/2016
Purpose : 
    - Purge audit records from various tables. Purge records based on Days, MachineName, Package or ExecutionID
*/
CREATE PROCEDURE [bix].[usp_SSISOps_Audit_Purge_Records_59]
    @PackageName NVARCHAR(255) = '%',
    @ExecutionID VARCHAR(255) = NULL,
    @MachineName NVARCHAR(255) = '%',
    @DaysToKeep INT = 180
AS 
BEGIN
    IF @ExecutionID IS NOT NULL
        SET @PackageName ='<N/A>'

    DECLARE @TimeToDelete DATETIME

    SET @TimeToDelete = GETDATE() - @DaysToKeep

    -- Delete records from SSISPackageRowCountLog
    DELETE a 
    FROM [bix].[vw_SSISPackageRowCountLog_59] a 
    JOIN [bix].[vw_SSISPackageExecutionLog_59] b
        ON a.[ExecutionID] = b.[ExecutionID]
    WHERE (
            (@PackageName = '%' OR b.[PackageName] LIKE @PackageName)
            AND (@MachineName = '%' OR b.[MachineName] LIKE @MachineName)
            AND b.[ExecutionStartDateTime] <= @TimeToDelete
        )
        OR a.[ExecutionID] = @ExecutionID

    -- Delete records from SSISTaskExecutionAlerts
    DELETE a
    FROM [bix].[vw_SSISTaskExecutionAlerts_59] a
    JOIN [bix].[vw_SSISPackageExecutionLog_59] b
        ON a.[ExecutionID] = b.[ExecutionID]
    WHERE (
            (@PackageName = '%' OR b.[PackageName] LIKE @PackageName)
            AND (@MachineName = '%' OR b.[MachineName] LIKE @MachineName)
            AND b.[ExecutionStartDateTime] <= @TimeToDelete
        )
        OR a.[ExecutionID] = @ExecutionID

    -- Delete records from SSISTaskExecutionLog
    DELETE a
    FROM [bix].[vw_SSISTaskExecutionLog_59] a
    JOIN [bix].[vw_SSISPackageExecutionLog_59] b
        ON a.[ExecutionID] = b.[ExecutionID]
    WHERE (
            (@PackageName = '%' OR b.[PackageName] LIKE @PackageName)
            AND (@MachineName = '%' OR b.[MachineName] LIKE @MachineName)
            AND b.[ExecutionStartDateTime] <= @TimeToDelete
        )
        OR a.[ExecutionID] = @ExecutionID

    -- Delete pipeline history
    DELETE a
    FROM [SSISDataFlowExecutionLog] a
    JOIN [SSISPackageExecutionLog] b
        ON a.[executionid] = b.[ExecutionID]
    WHERE (
            (@PackageName = '%' OR b.[PackageName] LIKE @PackageName)
            AND (@MachineName = '%' OR b.[MachineName] LIKE @MachineName)
            AND b.[ExecutionStartDateTime] <= @TimeToDelete
        )
        OR (@ExecutionID IS NOT NULL AND a.[executionid] = CAST(@ExecutionID AS uniqueidentifier))

    -- Delete variable change log
    DELETE a
    FROM [bix].[vw_SSISPackageVariableLog_59] a
    JOIN [bix].[vw_SSISPackageExecutionLog_59] b
        ON a.[ExecutionID] = b.[ExecutionID]
    WHERE (
            (@PackageName = '%' OR b.[PackageName] LIKE @PackageName) 
            AND (@MachineName = '%' OR b.[MachineName] LIKE @MachineName)
            AND b.[ExecutionStartDateTime] <= @TimeToDelete
        )
        OR (@ExecutionID IS NOT NULL AND a.[ExecutionID] = CAST(@ExecutionID AS uniqueidentifier))

    -- Delete records from SSISPackageExecutionLog
    DELETE FROM [bix].[vw_SSISPackageExecutionLog_59]
    WHERE (
            (@PackageName = '%' OR [PackageName] LIKE @PackageName)
            AND (@MachineName = '%' OR [MachineName] LIKE @MachineName)
            AND [ExecutionStartDateTime] <= @TimeToDelete
        )
        OR [ExecutionID] = @ExecutionID

    -- Delete unused layouts
    DELETE FROM [bix].[vw_SSISPackageLayout_59]
    WHERE [LayoutID] NOT IN (SELECT DISTINCT [LayoutID] FROM [bix].[vw_SSISPackageExecutionLog_59])
END

GO
