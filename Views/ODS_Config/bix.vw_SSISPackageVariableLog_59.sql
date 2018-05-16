/****** Object:  View [bix].[vw_SSISPackageVariableLog_59]    Script Date: 5/15/2018 12:14:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [bix].[vw_SSISPackageVariableLog_59]
AS
(
    SELECT 
        [LogID],
        [ExecutionID],
        [VariableName],
        [SourceID],
        [VariableValue],
        [LogDateTime]
    FROM [dbo].[SSISPackageVariableLog]
)
GO
