/****** Object:  StoredProcedure [dbo].[proc_MSS_AddScopeDisplayGroup]    Script Date: 5/15/2018 12:13:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddScopeDisplayGroup(
    @Name nvarchar( 60 ),
    @Description nvarchar( 300 ),
    @ConsumerName nvarchar( 60 ),   
    @DisplayInAdminUI bit,
    @Undeletable bit,
    @DefaultScopeID int,
    @ModifierName nvarchar( 60 ),
    @DisplayGroupID int OUTPUT )
AS
    BEGIN TRANSACTION
    DECLARE @LastError int
    DECLARE
        @ConsumerID int
    SELECT
        @ConsumerID = ConsumerID
    FROM
        dbo.MSSRegisteredConsumers
    WHERE
        ConsumerName = @ConsumerName
    IF @@ROWCOUNT = 0
        RETURN 1
    SELECT @LastError = @@ERROR
    IF @LastError <> 0
    BEGIN
        ROLLBACK TRANSACTION
        RETURN @LastError
    END
    INSERT INTO
        dbo.MSSScopeDisplayGroups (
            Name,
            Description,
            ConsumerID,
            DisplayInAdminUI,
            Undeletable,
            DefaultScopeID,
            LastModifiedTime,
            LastModifiedBy )
    VALUES (
        @Name,
        @Description,
        @ConsumerID,
        @DisplayInAdminUI,
        @Undeletable,
        @DefaultScopeID,
        GETUTCDATE(),
        @ModifierName
    )
    SELECT @LastError = @@ERROR
    IF @LastError <> 0
    BEGIN
        ROLLBACK TRANSACTION
        RETURN @LastError
    END
    SET
        @DisplayGroupID = @@IDENTITY
    EXEC
        @LastError = dbo.proc_MSS_ConsumerHasChanged @ConsumerID
    IF @LastError <> 0
    BEGIN
        ROLLBACK TRAN
        RETURN @LastError
    END
    COMMIT TRAN
    RETURN 0

GO
