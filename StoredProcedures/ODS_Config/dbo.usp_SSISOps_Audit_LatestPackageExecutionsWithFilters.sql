/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Audit_LatestPackageExecutionsWithFilters]    Script Date: 5/15/2018 12:11:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/*
 * Object: usp_SSISOps_Audit_LatestPackageExecutionsWithFilters
 * --------------------------------------------------------------
 * Updated By: Jeremiah Nazaruk
 * Source : Pragmatic Works - BI xPress Auditing Framework 47
 * Created On : 6/13/2013
 * Purpose : 
 *     - Loads the top X number of package executions with the option to use a package name filter and fiter operator.
 * --------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[usp_SSISOps_Audit_LatestPackageExecutionsWithFilters]
(
    @MaxNumberOfExecutions INT = 20,
    @MaxVariableLength INT = 4000,
    @DateRangeNumericValue INT = 1,
    @DateRangeUnitOfMeasure INT = 0, -- HOUR
    @RangeType INT = 1,
    @ExecutionStartDateTime DATETIME = NULL,
    @ExecutionEndDateTime DATETIME = NULL,
    @PackageNameContainsCsv NVARCHAR(4000) = NULL,
    @PackageNameStartsWithCsv NVARCHAR(4000) = NULL,
    @PackageNameEndsWithCsv NVARCHAR(4000) = NULL,
    @PackageNameDoesntContainCsv NVARCHAR(4000) = NULL,
    @PackageNameDoesntStartWithCsv NVARCHAR(4000) = NULL,
    @PackageNameDoesntEndWithCsv NVARCHAR(4000) = NULL
)
AS
BEGIN
    SET NOCOUNT ON
    SET FMTONLY OFF
 
    IF (@MaxNumberOfExecutions IS NULL OR @MaxNumberOfExecutions < 1 OR @MaxNumberOfExecutions > 100000)
    BEGIN
        SET @MaxNumberOfExecutions = 20
    END
    
    IF (@MaxVariableLength IS NULL)
    BEGIN
        SET @MaxVariableLength = 4000
    END

    IF (@DateRangeNumericValue IS NULL OR @DateRangeNumericValue < 1)
    BEGIN
        SET @DateRangeNumericValue = 1
    END

    /*
    /   @DateRangeUnitOfMeasure:
    /   0 = Hours,
    /   1 = Days,
    /   2 = Weeks,
    /   3 = Months,
    /   4 = Years
    */
    IF (@DateRangeUnitOfMeasure IS NULL OR @DateRangeUnitOfMeasure < 0 OR @DateRangeUnitOfMeasure > 4)
    BEGIN
        SET @DateRangeUnitOfMeasure = 0
    END

    /*
    /    @RangeType:
    /    0 = Unknown should default to 1,
    /    1 = Latest Number of Executions (e.g. last 100, last 1050, ...)
    /    2 = Latest Executions By Unit Of Time (e.g. last 4 hours, last 3 weeks, last 1 month, ...)
    /    3 = Date Range (e.g. January 1st 2013 to March 31st 2013)
    */
    IF (@RangeType IS NULL OR @RangeType < 1 OR @RangeType > 3)
    BEGIN
        SET @RangeType = 1
    END

    DECLARE @CurrentDate DATETIME

    SET @CurrentDate = GETDATE()

    IF (@ExecutionStartDateTime IS NULL OR @ExecutionStartDateTime < '1753/01/01')
    BEGIN
        SET @ExecutionStartDateTime = @CurrentDate - 7
    END

    IF (@ExecutionEndDateTime IS NULL OR @ExecutionEndDateTime < '1753/01/01')
    BEGIN
        SET @ExecutionEndDateTime = @CurrentDate
    END

    DECLARE @IsPackageNameFilterUsed BIT

    SET @IsPackageNameFilterUsed = 0

    -- Creating the temp table this way will allow the collation to match from the source table to the temp table instead of assuming the current instance's TempDB collation.
    SELECT TOP(0) [s].[PackageName]
    INTO #PackageNameTbl
    FROM [SSISPackageExecutionLog] [s]

    IF (@PackageNameContainsCsv IS NOT NULL AND LEN(@PackageNameContainsCsv) > 0)
    BEGIN
        SET @IsPackageNameFilterUsed = 1

        SELECT f.[Value]
        INTO #ContainsTbl
        FROM [dbo].[fn_ParseStringList](@PackageNameContainsCsv, ',') f

        INSERT INTO #PackageNameTbl ([PackageName])
            SELECT DISTINCT [s].[PackageName] FROM [SSISPackageExecutionLog] [s], #ContainsTbl [c] WHERE [s].[PackageName] LIKE '%' + [c].[Value] + '%'

        DROP TABLE #ContainsTbl
    END

    IF (@PackageNameStartsWithCsv IS NOT NULL AND LEN(@PackageNameStartsWithCsv) > 0)
    BEGIN
        SET @IsPackageNameFilterUsed = 1

        SELECT f.[Value]
        INTO #StartsWithTbl
        FROM [dbo].[fn_ParseStringList](@PackageNameStartsWithCsv, ',') f

        INSERT INTO #PackageNameTbl ([PackageName])
            SELECT DISTINCT [s].[PackageName] FROM [SSISPackageExecutionLog] [s], #StartsWithTbl [c] WHERE [s].[PackageName] LIKE [c].[Value] + '%'

        DROP TABLE #StartsWithTbl
    END

    IF (@PackageNameEndsWithCsv IS NOT NULL AND LEN(@PackageNameEndsWithCsv) > 0)
    BEGIN
        SET @IsPackageNameFilterUsed = 1

        SELECT f.[Value]
        INTO #EndsWithTbl
        FROM [dbo].[fn_ParseStringList](@PackageNameEndsWithCsv, ',') f

        INSERT INTO #PackageNameTbl ([PackageName])
            SELECT DISTINCT [s].[PackageName] FROM [SSISPackageExecutionLog] [s], #EndsWithTbl [c] WHERE [s].[PackageName] LIKE '%' + [c].[Value]

        DROP TABLE #EndsWithTbl
    END

    IF (@PackageNameDoesntContainCsv IS NOT NULL AND LEN(@PackageNameDoesntContainCsv) > 0)
    BEGIN
        SET @IsPackageNameFilterUsed = 1

        SELECT f.[Value]
        INTO #NotContainsTbl
        FROM [dbo].[fn_ParseStringList](@PackageNameDoesntContainCsv, ',') f

        INSERT INTO #PackageNameTbl ([PackageName])
            SELECT DISTINCT [s].[PackageName] FROM [SSISPackageExecutionLog] [s]
            WHERE [s].[PackageName] NOT IN
                (
                    SELECT DISTINCT [s].[PackageName]
                    FROM [dbo].[SSISPackageExecutionLog] [s], #NotContainsTbl [c]
                    WHERE [s].[PackageName] LIKE '%' + [c].[Value] + '%'
                )

        DROP TABLE #NotContainsTbl
    END

    IF (@PackageNameDoesntStartWithCsv IS NOT NULL AND LEN(@PackageNameDoesntStartWithCsv) > 0)
    BEGIN
        SET @IsPackageNameFilterUsed = 1

        SELECT f.[Value]
        INTO #NotStartsWithTbl
        FROM [dbo].[fn_ParseStringList](@PackageNameDoesntStartWithCsv, ',') f

        INSERT INTO #PackageNameTbl ([PackageName])
            SELECT DISTINCT [s].[PackageName] FROM [SSISPackageExecutionLog] [s]
            WHERE [s].[PackageName] NOT IN
                (
                    SELECT DISTINCT [s].[PackageName]
                    FROM [dbo].[SSISPackageExecutionLog] [s], #NotStartsWithTbl [c]
                    WHERE [s].[PackageName] LIKE [c].[Value] + '%'
                )

        DROP TABLE #NotStartsWithTbl
    END
    
    IF (@PackageNameDoesntEndWithCsv IS NOT NULL AND LEN(@PackageNameDoesntEndWithCsv) > 0)
    BEGIN
        SET @IsPackageNameFilterUsed = 1

        SELECT f.[Value]
        INTO #NotEndsWithTbl
        FROM [dbo].[fn_ParseStringList](@PackageNameDoesntEndWithCsv, ',') f

        INSERT INTO #PackageNameTbl ([PackageName])
            SELECT DISTINCT [s].[PackageName] FROM [SSISPackageExecutionLog] [s]
            WHERE [s].[PackageName] NOT IN
                (
                    SELECT DISTINCT [s].[PackageName]
                    FROM [dbo].[SSISPackageExecutionLog] [s], #NotEndsWithTbl [c]
                    WHERE [s].[PackageName] LIKE '%' + [c].[Value]
                )

        DROP TABLE #NotEndsWithTbl
    END
    
    SELECT TOP(@MaxNumberOfExecutions)
          [s].[LogID]
        , [s].[ExecutionID]
        , [s].[PackageName]
        , ISNULL([s].[LayoutID], 0) AS [LayoutID]
        , [s].[ExecutionStartDateTime]
        , [s].[ExecutionEndDateTime]
        , ISNULL([s].[TotalErrorCount], 0) AS [TotalErrorCount]
        , [Variables] = (
                (CASE WHEN DATALENGTH([s].[Variables]) > @MaxVariableLength
                    THEN LEFT(CAST([s].[Variables] AS NVARCHAR(MAX)), @MaxVariableLength) + ' ***** <LARGE STRING [Data truncated] - ' + CAST((DATALENGTH([s].[Variables])/1024) AS NVARCHAR(100)) + ' KB> Change max variable length option to see the full value *****'
                    ELSE [s].[Variables]
                 END)
            )
        , [s].[Connections]
        , [s].[UserName]
        , [s].[MachineName]
        , [s].[InteractiveMode]
        , [c].[ExecutionId] As [CatalogExecutionId]
        , [c].[PackageId] As [CatalogPackageId]
        , [c].[PackageGuid] As [CatalogPackageGuid]
        , [c].[FolderId] As [CatalogFolderId]
        , [c].[FolderName] As [CatalogFolderName]
        , [c].[ProjectId] As [CatalogProjectId]
        , [c].[ProjectName] As [CatalogProjectName]
        , [c].[MachineName] As [CatalogMachineName]
        , [c].[ServerName] As [CatalogServerName]
        , [c].[Status] As [CatalogStatus]
        , [c].[StoppedByName] As [CatalogStoppedByName]
    FROM [SSISPackageExecutionLog] AS [s] (NOLOCK)
        LEFT OUTER JOIN [SSISCatalogPackageExecution] [c] (NOLOCK)
            ON [c].[ExecutionGuid] = [dbo].[fn_ToUniqueIdentifier]([s].[ExecutionID])
    WHERE (
               @IsPackageNameFilterUsed = 0 OR @IsPackageNameFilterUsed = 1 AND [s].[PackageName] IN (SELECT DISTINCT [p].[PackageName] FROM #PackageNameTbl [p])
          )
        AND
          (
               (@RangeType < 2)
            OR (@RangeType = 2 AND [s].[ExecutionStartDateTime] >= @ExecutionStartDateTime)
            OR (@RangeType = 3 AND [s].[ExecutionStartDateTime] >= @ExecutionStartDateTime AND [s].[ExecutionEndDateTime] <= @ExecutionEndDateTime)
          )
    ORDER BY [s].[LogID] DESC

    DROP TABLE #PackageNameTbl

    SET NOCOUNT OFF
END

GO
