/****** Object:  StoredProcedure [dbo].[proc_MSS_ReportScopesCompilationEnd]    Script Date: 5/15/2018 12:13:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_ReportScopesCompilationEnd(
    @Aborted bit )
AS
    BEGIN TRAN
    DECLARE @LastError int
    DECLARE
        @Time datetime
    SET
        @Time = GETUTCDATE()
    DECLARE
        @CompilationSeconds int,
        @AverageCompilationDuration int,
        @NextCompilationTime datetime,
        @CompilationID int
    SET
        @CompilationSeconds = DATEDIFF( s, ( SELECT CompilationStartTime
                                             FROM dbo.MSSScopesSystem ), @Time )
    UPDATE
        dbo.MSSScopesSystem
    SET
        AverageCompilationDuration = ( AverageCompilationDuration * 4 + @CompilationSeconds ) / 5
    SELECT @LastError = @@ERROR
    IF @LastError <> 0  
    BEGIN
        ROLLBACK TRANSACTION
        RETURN @LastError
    END
    SELECT
        @AverageCompilationDuration = AverageCompilationDuration,
        @CompilationID = CompilationChangeID
    FROM
        dbo.MSSScopesSystem
    SELECT @LastError = @@ERROR
    IF @LastError <> 0  
    BEGIN
        ROLLBACK TRANSACTION
        RETURN @LastError
    END
    IF ( ( @AverageCompilationDuration * 10 ) < ( 15 * 60 ) )
        SET @NextCompilationTime = DATEADD( s, ( 15 * 60 ), @Time )
    ELSE
        SET @NextCompilationTime = DATEADD( s, ( @AverageCompilationDuration * 10 ), @Time )
    IF ( @Aborted = 0 )
    BEGIN
        UPDATE
            dbo.MSSScopes
        SET
            CompilationState = 4,       
            LastCompilationTime = @Time
        WHERE
            LastChangeID <= @CompilationID AND
            ( CompilationState = 3 OR                         
              CompilationState = 5 )
        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END
        DELETE FROM                                                 
            dbo.MSSDeletedScopes
        WHERE
            ChangeID <= @CompilationID
        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END
        DELETE FROM
            dbo.MSSCompiledScopes
        WHERE
            ScopeID IN ( SELECT ScopeID FROM dbo.MSSScopesForCompilation ) OR
            ScopeID IN ( SELECT ScopeID FROM dbo.MSSDeletedScopesForCompilation )
        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END
        DELETE FROM
            dbo.MSSCompiledScopeRules
        WHERE
            ScopeID IN ( SELECT ScopeID FROM dbo.MSSScopesForCompilation ) OR
            ScopeID IN ( SELECT ScopeID FROM dbo.MSSDeletedScopesForCompilation )
        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END
        INSERT INTO
            dbo.MSSCompiledScopes
        SELECT
            *
        FROM
            dbo.MSSScopesForCompilation
        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END
        UPDATE
            dbo.MSSScopesSystem
        SET
            LastConsumerChangeID = LastConsumerChangeID + 1
        UPDATE
            dbo.MSSRegisteredConsumers
        SET
            LastUpdate = ( SELECT LastConsumerChangeID FROM dbo.MSSScopesSystem )
        WHERE
            ConsumerID IN ( SELECT DISTINCT ConsumerID
                            FROM dbo.MSSScopesForCompilation )
        UPDATE
            dbo.MSSCompiledScopes
        SET
            CompilationState = 4
        WHERE
            ( CompilationState = 3 OR                         
              CompilationState = 5 )
        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END
        INSERT INTO
            dbo.MSSCompiledScopeRules
        SELECT
            *
        FROM
            dbo.MSSScopeRulesForCompilation
        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END
        UPDATE 
            dbo.MSSScopesSystem 
        SET
            NextCompilationTime = @NextCompilationTime,
            CompilationState = 0,
            CompilationPercentComplete = 0,
            LastCompilationTime = @Time,
            LastCompilationID = CompilationChangeID,
            StopCompilation = 0
        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END
    END
    ELSE
    BEGIN   
        UPDATE
            dbo.MSSScopesSystem
        SET
            NextCompilationTime = @NextCompilationTime,
            CompilationState = 0,
            CompilationPercentComplete = 0,
            StopCompilation = 0
        SELECT @LastError = @@ERROR
        IF @LastError <> 0  
        BEGIN
            ROLLBACK TRANSACTION
            RETURN @LastError
        END
    END
    COMMIT TRAN
    TRUNCATE TABLE dbo.MSSScopesForCompilation
    TRUNCATE TABLE dbo.MSSScopeRulesForCompilation
    TRUNCATE TABLE dbo.MSSDeletedScopesForCompilation
    RETURN 0

GO
