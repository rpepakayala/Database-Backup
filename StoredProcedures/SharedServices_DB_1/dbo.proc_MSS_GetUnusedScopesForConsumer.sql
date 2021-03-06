/****** Object:  StoredProcedure [dbo].[proc_MSS_GetUnusedScopesForConsumer]    Script Date: 5/15/2018 12:11:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetUnusedScopesForConsumer(
    @ConsumerName nvarchar( 60 ) )
AS
    DECLARE
        @ConsumerID int
    SELECT
        @ConsumerID = ConsumerID
    FROM 
        dbo.MSSRegisteredConsumers
    WHERE
        ConsumerName = @ConsumerName

    DECLARE @Temp table(
        ScopeID int
    )

    INSERT INTO
        @Temp
    SELECT DISTINCT
        ScopeID
    FROM 
        dbo.MSSScopeDisplayGroupMemberships AS M,
        dbo.MSSScopeDisplayGroups AS G
    WHERE
        M.DisplayGroupID = G.DisplayGroupID AND
        G.ConsumerID = @ConsumerID

    SELECT
        ScopeID,
        Name,
        Description,
        C.ConsumerName,
        DisplayInAdminUI,
        AlternateResultsPageUrl,
        CompilationType,
        CompilationState,
        LastCompilationTime,
        LastModifiedTime,
        LastModifiedBy
    FROM
        dbo.MSSScopes AS S,
        dbo.MSSRegisteredConsumers AS C
    WHERE
        S.ConsumerID = C.ConsumerID AND
        ( S.ConsumerID = @ConsumerID OR
          S.ConsumerID = 0 ) AND
        ScopeID NOT IN ( SELECT ScopeID
                         FROM @Temp )

    RETURN @@ERROR

GO
