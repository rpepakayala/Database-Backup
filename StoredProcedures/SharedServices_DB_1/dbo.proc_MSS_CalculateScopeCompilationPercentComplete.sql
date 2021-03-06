/****** Object:  StoredProcedure [dbo].[proc_MSS_CalculateScopeCompilationPercentComplete]    Script Date: 5/15/2018 12:11:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_CalculateScopeCompilationPercentComplete
AS

    DECLARE
        @CompilationState int
    SELECT
        @CompilationState = CompilationState 
    FROM 
        dbo.MSSScopesSystem

    IF ( @CompilationState = 0 AND
         ( SELECT StartCompilation FROM dbo.MSSScopesSystem ) != 1 )
        RETURN 100

    DECLARE
        @CompilationPercentComplete int

    IF ( ( SELECT CompilationState FROM dbo.MSSScopesSystem ) = 1 )
        SELECT
            @CompilationPercentComplete = CompilationPercentComplete
        FROM
            dbo.MSSScopesSystem
    ELSE
        SET
            @CompilationPercentComplete = 0

    DECLARE
        @QueryServers int
    SELECT
        @QueryServers = QueryServers
    FROM
        dbo.MSSScopesSystem

    IF (@QueryServers > 0)
    BEGIN
        SELECT @CompilationPercentComplete = @CompilationPercentComplete / 2
        SELECT @CompilationPercentComplete = @CompilationPercentComplete + QueryServersDone * 50 / @QueryServers FROM dbo.MSSScopesSystem
        IF (@CompilationPercentComplete > 100)
            SELECT @CompilationPercentComplete = 100
    END

    RETURN @CompilationPercentComplete

GO
