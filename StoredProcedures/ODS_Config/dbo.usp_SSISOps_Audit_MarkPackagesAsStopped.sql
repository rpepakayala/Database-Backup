/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Audit_MarkPackagesAsStopped]    Script Date: 5/15/2018 12:11:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

/*
 * Object: usp_SSISOps_Audit_MarkPackagesAsStopped
 * -------------------------------------------------------------------------------------------------------------
 * Updated By: Jeremiah Nazaruk - 08/19/2015
 * Source : Pragmatic Works - BI xPress Auditing Framework 59
 * Created On : 2/19/2016
 * -------------------------------------------------------------------------------------------------------------
*/
CREATE PROCEDURE [dbo].[usp_SSISOps_Audit_MarkPackagesAsStopped]
(
    @ExecutionIds NVARCHAR(MAX)
)
AS
BEGIN
    IF ISNULL(@ExecutionIds, '') = ''
    BEGIN
        SET @ExecutionIds = ''
    END

    SELECT f.[Value] AS [ExecutionID]
    INTO #ExecutionIdsTable 
    FROM [dbo].[fn_ParseStringList](@ExecutionIds, ',') f

    UPDATE [dbo].[SSISPackageExecutionLog]
    SET [ExecutionEndDateTime] = '1850-01-01 00:00:00.0'
    WHERE [ExecutionID] IN (SELECT e.[ExecutionID] FROM #ExecutionIdsTable e)
        AND [ExecutionEndDateTime] IS NULL
END

GO
