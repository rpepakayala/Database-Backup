/****** Object:  StoredProcedure [dbo].[proc_MSS_SetScopeInfo]    Script Date: 5/15/2018 12:11:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_SetScopeInfo(
    @ScopeID int,
    @Name nvarchar( 60 ),
    @Description nvarchar( 300 ),
    @ConsumerName nvarchar( 60 ),
    @DisplayInAdminUI bit,
    @AlternateResultsPageUrl nvarchar( 2048 ) = NULL,
    @CompilationType smallint,
    @ModifierName nvarchar( 60 ) )
AS
    BEGIN TRAN
    DECLARE @LastError int

    UPDATE
        dbo.MSSScopes
    SET
        Name = @Name,
        Description = @Description,
        ConsumerID = ( SELECT ConsumerID
                       FROM dbo.MSSRegisteredConsumers
                       WHERE ConsumerName = @ConsumerName ),
        DisplayInAdminUI = @DisplayInAdminUI,
        AlternateResultsPageUrl = @AlternateResultsPageUrl,
        CompilationType = @CompilationType
    WHERE
        ScopeID = @ScopeID

    IF @@ROWCOUNT = 0
    BEGIN
        ROLLBACK TRANSACTION
        RETURN 1
    END
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
