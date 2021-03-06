/****** Object:  View [bix].[vw_BestPracticesResults_59]    Script Date: 5/15/2018 12:14:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [bix].[vw_BestPracticesResults_59]
AS
(
    SELECT 
        [Id],
        [EvaluationId],
        [RuleId],
        [EvaluatedDateTime],
        [ItemIdentifier],
        [ItemIdentifierAlias],
        [ObjectName],
        [ObjectPath]
    FROM [dbo].[BestPracticesResults]
)
GO
