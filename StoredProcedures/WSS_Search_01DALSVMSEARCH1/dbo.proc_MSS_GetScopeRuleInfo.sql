/****** Object:  StoredProcedure [dbo].[proc_MSS_GetScopeRuleInfo]    Script Date: 5/15/2018 12:13:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetScopeRuleInfo(
    @RuleID int,
    @FilterBehavior smallint OUTPUT,
    @RuleType smallint OUTPUT,
    @UrlRuleType smallint OUTPUT,
    @PropertyID int OUTPUT,
    @UserValueString nvarchar( 2048 ) OUTPUT)
AS
    SELECT
        @FilterBehavior = FilterBehavior,
        @RuleType = RuleType,
        @UrlRuleType = UrlRuleType,
        @PropertyID = PropertyID,
        @UserValueString = UserValueString
    FROM
        dbo.MSSScopeRules
    WHERE
        RuleID = @RuleID
    IF @@ROWCOUNT = 0
        RETURN 1
    ELSE
        RETURN @@ERROR

GO
