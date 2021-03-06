/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Audit_OnVariableValueChanged]    Script Date: 5/15/2018 12:11:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
Source : Pragmatic Works - BI xPress Auditing Framework 22
Created On : 12/18/2012
Purpose : 
	- Records variable changes during ssis package execution. Called from OnVariableChanged event
*/
CREATE PROCEDURE [dbo].[usp_SSISOps_Audit_OnVariableValueChanged]
	@ExecutionID varchar(50),
	@SourceID varchar(50),
	@VariableName nvarchar(255),
	@VariableValue ntext=null
AS

if len(rtrim(@ExecutionID)) < 5 or @ExecutionID is null
 set @ExecutionID = '{00000000-0000-0000-0000-000000000000}'

if len(rtrim(@SourceID)) < 5  or @SourceID is null
 set @SourceID = '{00000000-0000-0000-0000-000000000000}'

INSERT INTO [SSISPackageVariableLog](ExecutionID,SourceID,VariableName,VariableValue,LogDateTime)
VALUES(@ExecutionID,@SourceID,@VariableName,@VariableValue,getdate()) 


GO
