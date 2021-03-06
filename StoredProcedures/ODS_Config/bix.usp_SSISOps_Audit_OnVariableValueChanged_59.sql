/****** Object:  StoredProcedure [bix].[usp_SSISOps_Audit_OnVariableValueChanged_59]    Script Date: 5/15/2018 12:11:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
Source : Pragmatic Works - BI xPress Auditing Framework 59
Created On : 2/19/2016
Purpose : 
    - Records variable changes during ssis package execution. Called from OnVariableChanged event
*/
CREATE PROCEDURE [bix].[usp_SSISOps_Audit_OnVariableValueChanged_59]
    @ExecutionID VARCHAR(50),
    @SourceID VARCHAR(50),
    @VariableName NVARCHAR(255),
    @VariableValue NVARCHAR(MAX) = null
AS
BEGIN
    IF LEN(RTRIM(@ExecutionID)) < 5 or @ExecutionID IS NULL
     SET @ExecutionID = '{00000000-0000-0000-0000-000000000000}'

    IF LEN(RTRIM(@SourceID)) < 5  or @SourceID IS NULL
     SET @SourceID = '{00000000-0000-0000-0000-000000000000}'

    INSERT INTO [bix].[vw_SSISPackageVariableLog_59](ExecutionID, SourceID, VariableName, VariableValue, LogDateTime)
        VALUES(@ExecutionID, @SourceID, @VariableName, @VariableValue, GETDATE())
END

GO
