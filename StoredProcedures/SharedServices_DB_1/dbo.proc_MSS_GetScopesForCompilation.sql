/****** Object:  StoredProcedure [dbo].[proc_MSS_GetScopesForCompilation]    Script Date: 5/15/2018 12:11:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetScopesForCompilation(
    @TakeSnapshot bit,
    @CompilationID int OUTPUT,
    @PreviousCompilationID int OUTPUT )
AS
    DECLARE @LastError int

    IF @TakeSnapshot = 1
    BEGIN
        BEGIN TRANSACTION

        TRUNCATE TABLE dbo.MSSScopesForCompilation

        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END

        TRUNCATE TABLE dbo.MSSScopeRulesForCompilation

        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END

        TRUNCATE TABLE dbo.MSSDeletedScopesForCompilation

        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END

        DECLARE
            @LastCompilationID int
        SELECT
            @LastCompilationID = LastCompilationId
        FROM
            dbo.MSSScopesSystem

        INSERT INTO dbo.MSSScopesForCompilation ( 
            ScopeID,
            ConsumerID,
            Name,
            CompilationState )
        SELECT 
            ScopeID,
            ConsumerID,
            Name,
            CompilationState
        FROM
            dbo.MSSScopes
        WHERE
            LastChangeID > @LastCompilationID

        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END

        SELECT
            @CompilationID = LastChangeID
        FROM
            dbo.MSSScopesSystem

        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END

        UPDATE
            dbo.MSSScopesSystem
        SET
            CompilationChangeID = @CompilationID

        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END

        INSERT INTO dbo.MSSScopeRulesForCompilation ( 
            ScopeID, 
            FilterBehavior, 
            RuleType, 
            UrlRuleType, 
            PropertyID, 
            UserValueString )
        SELECT
            dbo.MSSScopeRules.ScopeID,
            FilterBehavior,
            RuleType,
            UrlRuleType,
            PropertyID,
            UserValueString        
        FROM
            dbo.MSSScopeRules, dbo.MSSScopesForCompilation
        WHERE
            dbo.MSSScopeRules.ScopeID = dbo.MSSScopesForCompilation.ScopeID

        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END

        INSERT INTO dbo.MSSDeletedScopesForCompilation ( 
            ScopeID )
        SELECT
            ScopeID
        FROM
            dbo.MSSDeletedScopes

        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END

        COMMIT TRANSACTION
    END

    SELECT
        ScopeID,
        CompilationState
    FROM
        dbo.MSSScopesForCompilation

    SELECT @LastError = @@ERROR
    IF @LastError <> 0  
        RETURN @LastError

    SELECT 
        @CompilationId = CompilationChangeID,
        @PreviousCompilationId = LastCompilationID
    FROM
        dbo.MSSScopesSystem

    RETURN @@ERROR

GO
