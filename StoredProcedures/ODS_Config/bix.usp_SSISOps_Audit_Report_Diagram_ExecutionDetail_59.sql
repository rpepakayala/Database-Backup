/****** Object:  StoredProcedure [bix].[usp_SSISOps_Audit_Report_Diagram_ExecutionDetail_59]    Script Date: 5/15/2018 12:11:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
Source : Pragmatic Works - BI xPress Auditing Framework 59
Created On : 2/19/2016
Purpose : 
    - Called from ControlFlow Diagram Report. Returns information about specified execution
*/
CREATE PROCEDURE [bix].[usp_SSISOps_Audit_Report_Diagram_ExecutionDetail_59]
(
      @ExecutionID VARCHAR(4000)
    , @ShowRowCount BIT = 1
)
AS
BEGIN
    SET FMTONLY OFF
    SET NOCOUNT ON

    CREATE TABLE #executionid_list([ExecutionID] VARCHAR(50))

    -- If multiple execution IDS are passed, then split using comma
    IF 	CHARINDEX(',', @ExecutionID) > 0
    begin
        DECLARE @pos int
 
        --add comma to end of list
        SET @ExecutionID = @ExecutionID + ','
            --loop through list
        WHILE CHARINDEX(',', @ExecutionID) > 0
        BEGIN
          --get next comma position
          SET @pos = CHARINDEX(',', @ExecutionID)

          --insert next value into table
          INSERT #executionid_list VALUES (LTRIM(RTRIM(LEFT(@ExecutionID, @pos - 1))))

          --delete inserted value from list
          SET @ExecutionID = STUFF(@ExecutionID, 1, @pos, '')
        END
    END
    ELSE
    BEGIN
        INSERT #executionid_list VALUES (@ExecutionID)
    END
    
    IF @ShowRowCount = 1 
    BEGIN
        SELECT 
          a.ExecutionID
        , b.SourceID  --TaskID
        , ExecStatus = CASE 
            WHEN b.ExecutionEndDateTime IS NULL THEN 2 -- Executing
            WHEN b.TotalErrorCount > 0 THEN 3 --Failed
            WHEN b.ExecutionEndDateTime IS NOT NULL AND b.TotalErrorCount=0 THEN 4 --Completed w/ Success
            ELSE 0 -- Initial
            End
        , b.ExecutionStartDateTime --Task Start Time
        , b.ExecutionEndDateTime --Task End Time
        , a.ExecutionEndDateTime as P_ExecutionEndDateTime --Package End Time
        , a.TotalErrorCount as P_TotalErrorCount 
        , a.TotalWarningCount as P_TotalWarningCount 
        , CAST(ISNULL(c.TotalRecordsExtracted, 0) AS BIGINT) as TotalRecordsExtracted
        , CAST(ISNULL(c.TotalRecordsLoaded, 0) AS BIGINT) as TotalRecordsLoaded
        , ISNULL(b.ParentSourceID, '') as ParentSourceID
        , b.SourceType
        , b.SourceName
        FROM [bix].[vw_SSISPackageExecutionLog_59] a
        LEFT JOIN [bix].[vw_SSISTaskExecutionLog_59] b on a.ExecutionID = b.ExecutionID 
        LEFT JOIN (
                    Select SourceID
                        ,ExecutionID
                        ,TotalRecordsExtracted = sum(case when ComponentTypeCode = 'SRC' then RecordCount else 0 end) 
                        ,TotalRecordsLoaded = sum(case when ComponentTypeCode = 'DEST' then RecordCount else 0 end) 
                    from [bix].[vw_SSISPackageRowCountLog_59] where [ExecutionID] in (SELECT [ExecutionID] COLLATE DATABASE_DEFAULT FROM #executionid_list)
                    group by [SourceID], [SourceName], [ExecutionID]
                  ) c
        on b.ExecutionID = c.ExecutionID and b.SourceID = c.[SourceID]
        where a.ExecutionID in (select ExecutionID COLLATE DATABASE_DEFAULT from #executionid_list)  
        ORDER BY b.[LogID] DESC
    END
    ELSE
    BEGIN
        SELECT 
          a.ExecutionID
        , b.SourceID  --TaskID
        , ExecStatus = CASE 
                      WHEN b.[ExecutionEndDateTime] IS NULL THEN 2 -- Executing
                      WHEN b.[TotalErrorCount] > 0 THEN 3 --Failed
                      WHEN b.[ExecutionEndDateTime] IS NOT NULL AND b.[TotalErrorCount] = 0 THEN 4 --Completed w/ Success
                      ELSE 0 -- Initial
                      END
        , b.ExecutionStartDateTime --Task Start Time
        , b.ExecutionEndDateTime --Task End Time
        , a.ExecutionEndDateTime as P_ExecutionEndDateTime --Package End Time
        , a.TotalErrorCount as P_TotalErrorCount 
        , a.TotalWarningCount as P_TotalWarningCount 
        , CAST(0 AS BIGINT) as TotalRecordsExtracted
        , CAST(0 AS BIGINT) as TotalRecordsLoaded
        , ISNULL(b.ParentSourceID, '') as ParentSourceID
        , b.SourceType
        , b.SourceName
        FROM [bix].[vw_SSISPackageExecutionLog_59] a 
        LEFT JOIN [bix].[vw_SSISTaskExecutionLog_59] b on a.[ExecutionID] = b.[ExecutionID] 
        WHERE a.[ExecutionID] in (SELECT [ExecutionID] COLLATE DATABASE_DEFAULT from #executionid_list)
        ORDER BY b.[LogID] DESC
    END
END

GO
