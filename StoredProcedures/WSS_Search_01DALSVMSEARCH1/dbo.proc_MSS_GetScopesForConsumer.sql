/****** Object:  StoredProcedure [dbo].[proc_MSS_GetScopesForConsumer]    Script Date: 5/15/2018 12:13:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetScopesForConsumer(
    @ConsumerName nvarchar( 60 ) )
AS
    SELECT
        ScopeID,
        Name,
        Description,
        dbo.MSSRegisteredConsumers.ConsumerName,
        DisplayInAdminUI,
        AlternateResultsPageUrl,
        CompilationType,
        CompilationState,
        LastCompilationTime,
        LastModifiedTime,
        LastModifiedBy
    FROM
        dbo.MSSScopes, dbo.MSSRegisteredConsumers
    WHERE
        dbo.MSSScopes.ConsumerID = dbo.MSSRegisteredConsumers.ConsumerID AND
        dbo.MSSRegisteredConsumers.ConsumerName = @ConsumerName
    RETURN @@ERROR

GO
