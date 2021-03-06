/****** Object:  StoredProcedure [dbo].[proc_MSS_GetScopeRulesInfo]    Script Date: 5/15/2018 12:11:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetScopeRulesInfo(
    @ScopeID int )
AS

    IF NOT EXISTS ( SELECT * FROM dbo.MSSScopes WHERE ScopeID = @ScopeID )
        RETURN 1

    SELECT
        RuleID,
        FilterBehavior,
        RuleType,
        UrlRuleType,
        PropertyID,
        UserValueString
    FROM
        dbo.MSSScopeRules
    WHERE
        ScopeID = @ScopeID   

    RETURN @@ERROR

GO
