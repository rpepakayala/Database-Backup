/****** Object:  StoredProcedure [dbo].[proc_MSS_SetScopeRuleInfo]    Script Date: 5/15/2018 12:13:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_SetScopeRuleInfo(
    @RuleID int,
    @FilterBehavior smallint,
    @UrlRuleType smallint,
    @PropertyID int,
    @UserValueString nvarchar( 2048 ),
    @ModifierName nvarchar( 60 ) )
AS
    BEGIN TRAN
    DECLARE @LastError int
    DECLARE
        @ScopeID int
    SELECT
        @ScopeID = ScopeID
    FROM
        dbo.MSSScopeRules
    WHERE
        RuleID = @RuleID
    SELECT @LastError = @@ERROR
    IF @LastError <> 0
    BEGIN
        ROLLBACK TRANSACTION
        RETURN @LastError
    END
    UPDATE
        dbo.MSSScopeRules
    SET
        FilterBehavior = @FilterBehavior,
        UrlRuleType = @UrlRuleType,
        PropertyID = @PropertyID,
        UserValueString = @UserValueString
    WHERE
        RuleID = @RuleID
    IF @@ROWCOUNT = 0
        RETURN 1
    SELECT @LastError = @@ERROR
    IF @LastError <> 0
    BEGIN
        ROLLBACK TRANSACTION
        RETURN @LastError
    END
    EXEC
        @LastError = dbo.proc_MSS_ScopeHasChanged @ScopeID, @ModifierName
    IF @LastError <> 0
    BEGIN
        ROLLBACK TRAN
        RETURN @LastError
    END
    COMMIT TRAN
    RETURN 0

GO
