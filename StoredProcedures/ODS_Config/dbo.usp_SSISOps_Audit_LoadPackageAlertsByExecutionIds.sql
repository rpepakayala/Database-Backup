/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Audit_LoadPackageAlertsByExecutionIds]    Script Date: 5/15/2018 12:11:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/*
 * Object: usp_SSISOps_Audit_LoadPackageAlertsByExecutionIds
 * --------------------------------------------------------------
 * Updated By: Jeremiah Nazaruk - 11/21/2012
 * Source : Pragmatic Works - BI xPress Auditing Framework 47
 * Created On : 6/13/2013
 * Purpose : 
 *     - Loads package alert information such as package execution warnings or errors.
 * --------------------------------------------------------------
 */
CREATE PROCEDURE [dbo].[usp_SSISOps_Audit_LoadPackageAlertsByExecutionIds]
(
    @PackageExecutionIdCsv VARCHAR(MAX) = NULL
)
AS
BEGIN
    SET FMTONLY OFF
    SET NOCOUNT ON

    CREATE TABLE #PackageExecutionId ([ExecutionId] VARCHAR(50) NOT NULL)

    DECLARE @delimiter VARCHAR(1)
    DECLARE @idx INT
    DECLARE @slice VARCHAR(8000)

    SET @delimiter = ','
    SET @idx = 1

    -- SEPARATE THE VALUES WITHIN THE @PackageExecutionIdCsv list of execution IDs.
    IF (@PackageExecutionIdCsv IS NOT NULL) AND (LEN(@PackageExecutionIdCsv) > 0)
    BEGIN
        WHILE @idx != 0
        BEGIN
            SET @idx = charindex(@delimiter, @PackageExecutionIdCsv)
        
            IF (@idx != 0)
                SET @slice = LEFT(@PackageExecutionIdCsv, @idx - 1)
            ELSE
                SET @slice = @PackageExecutionIdCsv

            IF (LEN(@slice) > 0)
                INSERT INTO #PackageExecutionId([ExecutionId]) VALUES (@slice)

            SET @PackageExecutionIdCsv = RIGHT(@PackageExecutionIdCsv, LEN(@PackageExecutionIdCsv) - @idx)
        
            IF LEN(@PackageExecutionIdCsv) = 0
                BREAK
        END
    END
    
    SELECT[a].[EventType]
        , [a].[ExecutionID]
        , [a].[LogDate]
        , [a].[MessageCode]
        , [a].[MessageDescription]
        , [a].[SourceID]
        , [a].[SourceName]
        , [a].[SourceType]
    FROM [dbo].[SSISTaskExecutionAlerts] [a]
    WHERE (@PackageExecutionIdCsv IS NULL OR LEN(@PackageExecutionIdCsv) < 1)
        OR [a].[ExecutionID] IN ( SELECT [p].[ExecutionId] COLLATE DATABASE_DEFAULT FROM #PackageExecutionId [p] )
    ORDER BY [a].[LogDate] DESC

    DROP TABLE #PackageExecutionId

    SET NOCOUNT OFF
END

GO
