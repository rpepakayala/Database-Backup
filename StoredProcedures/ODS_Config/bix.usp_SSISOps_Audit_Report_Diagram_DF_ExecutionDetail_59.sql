/****** Object:  StoredProcedure [bix].[usp_SSISOps_Audit_Report_Diagram_DF_ExecutionDetail_59]    Script Date: 5/15/2018 12:11:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
Source : Pragmatic Works - BI xPress Auditing Framework 59
Created On : 2/19/2016
Purpose : 
    - This stored proc is called by DataFlow Monitoring. It log returns records for specified execution and dataflow.
*/
CREATE PROC [bix].[usp_SSISOps_Audit_Report_Diagram_DF_ExecutionDetail_59]
(
      @ExecutionID VARCHAR(50)
    , @DataFlowID  VARCHAR(50)
)
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @execid uniqueidentifier
    DECLARE @dfid uniqueidentifier

    SET @execid = CAST(@ExecutionID AS uniqueidentifier)

    IF (ISNULL(@DataFlowID, '') = '')
    BEGIN
        SET @dfid = NULL
    END
    ELSE
    BEGIN
        SET @dfid = CAST(@DataFlowID AS uniqueidentifier)
    END
    
    IF (@dfid IS NULL)
    BEGIN
        SELECT d.[event], d.[message], d.[starttime], d.[sourceid] 
        FROM [bix].[vw_SSISDataFlowExecutionLog_59] d
        WHERE d.[executionid] = @execid ORDER BY d.[id]
    END
    ELSE
    BEGIN
        SELECT d.[event], d.[message], d.[starttime], d.[sourceid]
        FROM [bix].[vw_SSISDataFlowExecutionLog_59] d
        WHERE d.[executionid] = @execid
            AND d.[sourceid] = @dfid ORDER BY d.[id]
    END

    SET NOCOUNT OFF
END

GO
