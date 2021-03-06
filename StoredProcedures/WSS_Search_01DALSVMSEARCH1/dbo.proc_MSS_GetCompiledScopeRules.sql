/****** Object:  StoredProcedure [dbo].[proc_MSS_GetCompiledScopeRules]    Script Date: 5/15/2018 12:13:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetCompiledScopeRules
AS
    SELECT
        ScopeID,
        FilterBehavior,
        RuleType,
        UrlRuleType,
        PropertyID,
        UserValueString        
    FROM
        dbo.MSSCompiledScopeRules
    ORDER BY
        ScopeID
    RETURN @@ERROR

GO
