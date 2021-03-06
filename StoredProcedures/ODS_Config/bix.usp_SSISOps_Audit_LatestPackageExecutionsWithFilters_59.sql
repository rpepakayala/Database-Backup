/****** Object:  StoredProcedure [bix].[usp_SSISOps_Audit_LatestPackageExecutionsWithFilters_59]    Script Date: 5/15/2018 12:11:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/*
 * Object: usp_SSISOps_Audit_LatestPackageExecutionsWithFilters
 * --------------------------------------------------------------
 * Updated By: Jeremiah Nazaruk
 * Source : Pragmatic Works - BI xPress Auditing Framework 59
 * Created On : 2/19/2016
 * Purpose : 
 *     - Loads the top X number of package executions with the option to use a package name filter and fiter operator.
 * --------------------------------------------------------------
*/
CREATE PROCEDURE [bix].[usp_SSISOps_Audit_LatestPackageExecutionsWithFilters_59]
(
    @MaxNumberOfExecutions INT = 20,
    @MaxVariableLength INT = 4000,
    @DateRangeNumericValue INT = 1,
    @DateRangeUnitOfMeasure INT = 0, -- HOUR
    @RangeType INT = 1,
    @ExecutionStartDateTime DATETIME = NULL,
    @ExecutionEndDateTime DATETIME = NULL,
    @PackageNameContainsCsv NVARCHAR(MAX) = NULL,
    @PackageNameStartsWithCsv NVARCHAR(MAX) = NULL,
    @PackageNameEndsWithCsv NVARCHAR(MAX) = NULL,
    @PackageNameDoesntContainCsv NVARCHAR(MAX) = NULL,
    @PackageNameDoesntStartWithCsv NVARCHAR(MAX) = NULL,
    @PackageNameDoesntEndWithCsv NVARCHAR(MAX) = NULL,
    @GroupNameFilter NVARCHAR(MAX) = NULL
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
    FROM [bix].[vw_SSISPackageExecutionLog_59] [s]

    IF (@PackageNameContainsCsv IS NOT NULL AND LEN(@PackageNameContainsCsv) > 0)
    BEGIN
        SET @IsPackageNameFilterUsed = 1

        SELECT f.[Value]
        INTO #ContainsTbl
        FROM [dbo].[fn_ParseStringList](@PackageNameContainsCsv, ',') f

        INSERT INTO #PackageNameTbl ([PackageName])
            SELECT DISTINCT [s].[PackageName] FROM [bix].[vw_SSISPackageExecutionLog_59] [s], #ContainsTbl [c] WHERE [s].[PackageName] LIKE '%' + [c].[Value] + '%'

        DROP TABLE #ContainsTbl
    END

    IF (@PackageNameStartsWithCsv IS NOT NULL AND LEN(@PackageNameStartsWithCsv) > 0)
    BEGIN
        SET @IsPackageNameFilterUsed = 1

        SELECT f.[Value]
        INTO #StartsWithTbl
        FROM [dbo].[fn_ParseStringList](@PackageNameStartsWithCsv, ',') f

        INSERT INTO #PackageNameTbl ([PackageName])
            SELECT DISTINCT [s].[PackageName] FROM [bix].[vw_SSISPackageExecutionLog_59] [s], #StartsWithTbl [c] WHERE [s].[PackageName] LIKE [c].[Value] + '%'

        DROP TABLE #StartsWithTbl
    END

    IF (@PackageNameEndsWithCsv IS NOT NULL AND LEN(@PackageNameEndsWithCsv) > 0)
    BEGIN
        SET @IsPackageNameFilterUsed = 1

        SELECT f.[Value]
        INTO #EndsWithTbl
        FROM [dbo].[fn_ParseStringList](@PackageNameEndsWithCsv, ',') f

        INSERT INTO #PackageNameTbl ([PackageName])
            SELECT DISTINCT [s].[PackageName] FROM [bix].[vw_SSISPackageExecutionLog_59] [s], #EndsWithTbl [c] WHERE [s].[PackageName] LIKE '%' + [c].[Value]

        DROP TABLE #EndsWithTbl
    END

    IF (@PackageNameDoesntContainCsv IS NOT NULL AND LEN(@PackageNameDoesntContainCsv) > 0)
    BEGIN
        SET @IsPackageNameFilterUsed = 1

        SELECT f.[Value]
        INTO #NotContainsTbl
        FROM [dbo].[fn_ParseStringList](@PackageNameDoesntContainCsv, ',') f

        INSERT INTO #PackageNameTbl ([PackageName])
            SELECT DISTINCT [s].[PackageName] FROM [bix].[vw_SSISPackageExecutionLog_59] [s]
            WHERE [s].[PackageName] NOT IN
                (
                    SELECT DISTINCT [s].[PackageName]
                    FROM [bix].[vw_SSISPackageExecutionLog_59] [s], #NotContainsTbl [c]
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
            SELECT DISTINCT [s].[PackageName] FROM [bix].[vw_SSISPackageExecutionLog_59] [s]
            WHERE [s].[PackageName] NOT IN
                (
                    SELECT DISTINCT [s].[PackageName]
                    FROM [bix].[vw_SSISPackageExecutionLog_59] [s], #NotStartsWithTbl [c]
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
            SELECT DISTINCT [s].[PackageName] FROM [bix].[vw_SSISPackageExecutionLog_59] [s]
            WHERE [s].[PackageName] NOT IN
                (
                    SELECT DISTINCT [s].[PackageName]
                    FROM [bix].[vw_SSISPackageExecutionLog_59] [s], #NotEndsWithTbl [c]
                    WHERE [s].[PackageName] LIKE '%' + [c].[Value]
                )

        DROP TABLE #NotEndsWithTbl
    END
    
    IF (@GroupNameFilter IS NULL)
    BEGIN
        SET @GroupNameFilter = ''
    END

    IF (ISNULL(@GroupNameFilter, '') = '')
    BEGIN
        SELECT [p].[LogID]
            , [p].[ExecutionID]
            , [p].[PackageName]
            , [p].[LayoutID]
            , [p].[ExecutionStartDateTime]
            , [p].[ExecutionEndDateTime]
            , [p].[TotalErrorCount]
            , [p].[Variables]
            , [p].[Connections]
            , [p].[UserName]
            , [p].[MachineName]
            , [p].[InteractiveMode]
            , [p].[CatalogExecutionId]
            , [p].[CatalogPackageId]
            , [p].[CatalogPackageGuid]
            , [p].[CatalogFolderId]
            , [p].[CatalogFolderName]
            , [p].[CatalogProjectId]
            , [p].[CatalogProjectName]
            , [p].[CatalogMachineName]
            , [p].[CatalogServerName]
            , [p].[CatalogStatus]
            , [p].[CatalogStoppedByName]
            , [pgn].[GroupID]
            , [pgn].[GroupName]
        FROM (
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
            FROM [bix].[vw_SSISPackageExecutionLog_59] AS [s] (NOLOCK)
                LEFT OUTER JOIN [bix].[vw_SSISCatalogPackageExecution_59] [c] (NOLOCK)
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
        ) [p]
        LEFT OUTER JOIN (
            SELECT [g].[GroupID]
                , [g].[Name] AS [GroupName]
                , [spgn].[PackageName]
            FROM [bix].[vw_SSISPackageGroupNames_59] [spgn] (NOLOCK)
            INNER JOIN [bix].[vw_GroupNames_59] [g] (NOLOCK) ON [spgn].[GroupID] = [g].[GroupID]
        ) [pgn] ON [p].[PackageName] = [pgn].[PackageName] COLLATE Latin1_General_CI_AS
    END
    ELSE
    BEGIN
        DECLARE @IsUngroupedDesired BIT

        SELECT LTRIM(RTRIM(f.[Value])) As [GroupName]
        INTO #GroupNamesTbl
        FROM [dbo].[fn_ParseStringList](@GroupNameFilter, ',') f
        WHERE ISNULL(f.[Value], '') != ''

        IF EXISTS (SELECT 1 FROM #GroupNamesTbl [t] WHERE [t].[GroupName] = 'ungrouped' COLLATE Latin1_General_CI_AS)
        BEGIN
            SET @IsUngroupedDesired = 1
        END
        ELSE
        BEGIN
            SET @IsUngroupedDesired = 0
        END

        DELETE FROM #GroupNamesTbl WHERE [GroupName] = 'ungrouped' COLLATE Latin1_General_CI_AS

        SELECT [s].[LogID]
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
            , [x].[GroupID]
            , [x].[GroupName]
        FROM [bix].[vw_SSISPackageExecutionLog_59] AS [s] (NOLOCK)
        INNER JOIN (
            -- I did a distinct here because if ungrouped packages are allowed there will be multiple entries per package retrieved in the first subselect below.
            SELECT DISTINCT [p].[LogID]
                , [pgn].[GroupID]
                , [pgn].[GroupName]
            FROM (
                -- Filter the packages by package name, range, etc, first.
                SELECT TOP(@MaxNumberOfExecutions)
                      [s].[LogID]
                    , [s].[PackageName]
                FROM [bix].[vw_SSISPackageExecutionLog_59] AS [s] (NOLOCK)
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
            ) [p]
            LEFT OUTER JOIN (
                -- Denormalize the Package & Package Group Names in preparation for left outer joining to the selected packages above.
                SELECT [g].[GroupID]
                    , [g].[Name] AS [GroupName]
                    , [spgn].[PackageName]
                FROM [bix].[vw_SSISPackageGroupNames_59] [spgn] (NOLOCK)
                INNER JOIN [bix].[vw_GroupNames_59] [g] (NOLOCK) ON [spgn].[GroupID] = [g].[GroupID]
            ) [pgn] ON [p].[PackageName] = [pgn].[PackageName] COLLATE Latin1_General_CI_AS
            INNER JOIN #GroupNamesTbl [t] -- Next join the group names to that of the filtered group names, optionally allowing NULL values (ungrouped packages)
                ON [pgn].[GroupName] = t.[GroupName] COLLATE Latin1_General_CI_AS
                    OR (@IsUngroupedDesired = 1 AND [pgn].[GroupName] IS NULL)
        ) [x] on [s].[LogID] = x.[LogID]
        LEFT OUTER JOIN [bix].[vw_SSISCatalogPackageExecution_59] [c] (NOLOCK)
            ON [c].[ExecutionGuid] = [dbo].[fn_ToUniqueIdentifier]([s].[ExecutionID])

        DROP TABLE #GroupNamesTbl
    END

    DROP TABLE #PackageNameTbl

    SET NOCOUNT OFF
END

GO
