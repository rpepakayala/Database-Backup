/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Report_BestPracticesAnalysisItemDetail]    Script Date: 5/15/2018 12:11:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/*
 * Object: usp_SSISOps_Report_BestPracticesAnalysisItemDetail
 * -------------------------------------------------------------------------------------------------------------
 * Updated By: Jeremiah Nazaruk - 03/14/2013
 * Source : Pragmatic Works - BI xPress Auditing Framework 47
 * Created On : 6/13/2013
 * -------------------------------------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[usp_SSISOps_Report_BestPracticesAnalysisItemDetail]
(
    @EvaluationId UNIQUEIDENTIFIER,
    @ItemIdentifier NVARCHAR(2048),
    @ItemIdentifierAlias NVARCHAR(2048),
    @IsIncludeErrors BIT = 1,
    @IsIncludePerformance BIT = 1,
    @IsIncludeWarnings BIT = 1,
    @IsIncludeInformational BIT = 1,
    @IsIncludeSuccess BIT = 1,
    @PageSize INT = 50,
    @PageNumber INT = 1
)
AS
BEGIN
    SET NOCOUNT ON
    SET FMTONLY OFF

    DECLARE @EmptyGuid UNIQUEIDENTIFIER
    DECLARE @IsIncludeAll BIT
    DECLARE @FirstRow INT
    DECLARE @LastRow INT

    IF ISNULL(@IsIncludeErrors, 1) = 1
    BEGIN
        SET @IsIncludeErrors = 1
    END

    IF ISNULL(@IsIncludePerformance, 1) = 1
    BEGIN
        SET @IsIncludePerformance = 1
    END

    IF ISNULL(@IsIncludeWarnings, 1) = 1
    BEGIN
        SET @IsIncludeWarnings = 1
    END

    IF ISNULL(@IsIncludeInformational, 1) = 1
    BEGIN
        SET @IsIncludeInformational = 1
    END

    IF ISNULL(@IsIncludeSuccess, 1) = 1
    BEGIN
        SET @IsIncludeSuccess = 1
    END

    IF ISNULL(@PageSize, -1) < 0
    BEGIN
        SET @PageSize = 50
    END

    IF ISNULL(@PageNumber, -1) < 1
    BEGIN
        SET @PageNumber = 1
    END

    SET @FirstRow = ((@PageNumber - 1) * @PageSize) + 1
    SET @LastRow = ((@PageNumber - 1) * @PageSize) + @PageSize

    SET @EmptyGuid = '00000000-0000-0000-0000-000000000000'

    IF @IsIncludeErrors = 1 AND @IsIncludePerformance = 1 AND @IsIncludeWarnings = 1 AND @IsIncludeInformational = 1 AND @IsIncludeSuccess = 1 
    BEGIN
        SET @IsIncludeAll = 1
    END
    ELSE
    BEGIN
        SET @IsIncludeAll = 0
    END;

    WITH [BestPracticesAnalysisResultsDetails] AS
    (
        SELECT ROW_NUMBER() OVER (ORDER BY r.[RuleSeverity] DESC, b.[ObjectName] ASC, b.[ObjectPath] ASC) AS [RowNumber],
               b.[ObjectName],
               b.[ObjectPath],
               r.[RuleId],
               r.[RuleName],
               r.[ViolationMessage],
               r.[Recommendation],
               r.[RuleSeverity],
               r.[ReferenceUri]
        FROM [dbo].[BestPracticesResults] b
        INNER JOIN [dbo].[BestPracticesRules] r ON b.[RuleId] = r.[RuleId]
        WHERE b.[EvaluationId] = @EvaluationId AND
              (ISNULL(@ItemIdentifier, '') = '' OR b.[ItemIdentifier] = @ItemIdentifier) AND
              (ISNULL(@ItemIdentifierAlias, '') = '' OR b.[ItemIdentifierAlias] = @ItemIdentifierAlias) AND
              (@IsIncludeAll = 1 OR
                  (
                      (@IsIncludeErrors = 1 AND r.[RuleSeverity] = 100) OR
                      (@IsIncludePerformance = 1 AND r.[RuleSeverity] = 80) OR
                      (@IsIncludeWarnings = 1 AND r.[RuleSeverity] = 60) OR
                      (@IsIncludeInformational = 1 AND r.[RuleSeverity] = 30) OR
                      (@IsIncludeSuccess = 1 AND r.[RuleId] = @EmptyGuid)
                  )
              )
    )

    SELECT d.[ObjectName],
           d.[ObjectPath],
           d.[RuleId],
           d.[RuleName],
           d.[ViolationMessage],
           d.[Recommendation],
           d.[RuleSeverity],
           d.[ReferenceUri]
    FROM [BestPracticesAnalysisResultsDetails] d
    WHERE (@PageSize = 0 OR d.[RowNumber] BETWEEN @FirstRow AND @LastRow)

    SET NOCOUNT OFF
END

GO
