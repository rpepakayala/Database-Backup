/****** Object:  StoredProcedure [dbo].[proc_MSS_GetScopeRulesForCompilation]    Script Date: 5/15/2018 12:13:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetScopeRulesForCompilation
AS
    SELECT
        ScopeID,
        FilterBehavior,
        RuleType,
        UrlRuleType,
        PropertyID,
        UserValueString
    FROM
        dbo.MSSScopeRulesForCompilation
    ORDER BY
        ScopeID
    RETURN @@ERROR

GO
