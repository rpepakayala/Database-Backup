/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Audit_OnPostExecute_CustomCode]    Script Date: 5/15/2018 12:11:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
	Source : Pragmatic Works - BI xPress Auditing Framework 22
	Created On : 12/18/2012
	Purpose : 
		- Write your own code which will be called when task/package is completed
	*/
	CREATE PROCEDURE [dbo].[usp_SSISOps_Audit_OnPostExecute_CustomCode]
		@Scope varchar(10), --//Package or Task
		@ExecutionID varchar(50),
		@SourceID varchar(50),
		@RowCountSupport bit=Null,
		@LogCustomValues bit=Null,
		@CustomValue_Num_1 nvarchar(255)=Null,
		@CustomValue_Num_2 nvarchar(255)=Null,
		@CustomValue_Num_3 nvarchar(255)=Null,
		@CustomValue_Dt_1 datetime=Null,
		@CustomValue_Dt_2 datetime=Null,
		@CustomValue_Dt_3 datetime=Null,
		@CustomValue_Str_1 nvarchar(255)=Null,
		@CustomValue_Str_2 nvarchar(255)=Null,
		@CustomValue_Str_3 nvarchar(255)=Null
	AS 
/*
		IF @Scope='Package'
		Begin
		/* Package Level */
		End
		
		IF @Scope='Task'
		Begin
		/* Task Level */
		End
*/
		
	
GO
