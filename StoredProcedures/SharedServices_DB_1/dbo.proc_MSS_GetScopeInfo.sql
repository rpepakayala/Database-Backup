/****** Object:  StoredProcedure [dbo].[proc_MSS_GetScopeInfo]    Script Date: 5/15/2018 12:11:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetScopeInfo(
    @ScopeID int,
    @Name nvarchar( 60 ) OUTPUT,
    @Description nvarchar( 300 ) OUTPUT,
    @ConsumerName nvarchar( 60 ) OUTPUT,
    @DisplayInAdminUI bit OUTPUT,
    @AlternateResultsPageUrl nvarchar( 2048 ) OUTPUT,
    @CompilationType bit OUTPUT,
    @CompilationState smallint OUTPUT,
    @LastCompilationTime datetime OUTPUT,
    @LastModifiedTime datetime OUTPUT,    
    @LastModifiedBy nvarchar( 60 ) OUTPUT )
AS
    SELECT
        @Name = Name,
        @Description = Description,
        @ConsumerName = dbo.MSSRegisteredConsumers.ConsumerName,
        @DisplayInAdminUI = DisplayInAdminUI,
        @AlternateResultsPageUrl = AlternateResultsPageUrl,
        @CompilationType = CompilationType,
        @CompilationState = CompilationState,
        @LastCompilationTime = LastCompilationTime,
        @LastModifiedTime = LastModifiedTime,
        @LastModifiedBy = LastModifiedBy
    FROM
        dbo.MSSScopes, dbo.MSSRegisteredConsumers
    WHERE
        ScopeID = @ScopeID AND
        dbo.MSSScopes.ConsumerID = dbo.MSSRegisteredConsumers.ConsumerID

    IF @@ROWCOUNT = 0
        RETURN 1
    ELSE
        RETURN @@ERROR

GO
