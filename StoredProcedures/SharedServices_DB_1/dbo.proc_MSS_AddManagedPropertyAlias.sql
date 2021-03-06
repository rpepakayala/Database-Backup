/****** Object:  StoredProcedure [dbo].[proc_MSS_AddManagedPropertyAlias]    Script Date: 5/15/2018 12:11:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddManagedPropertyAlias
@PID int,
@Name nvarchar (2048), 
@UpdateManagedProperty bit = 1
AS

DECLARE @RetVal int  SET @RetVal = 0

IF EXISTS ( SELECT * FROM dbo.[MSSManagedPropAliases] 
        WHERE binary_checksum(@Name) = AliasHash
          AND @Name = Alias )
BEGIN
    return @RetVal
END

BEGIN TRANSACTION

IF EXISTS (SELECT * FROM dbo.[MSSManagedProperties] Where @Name = FriendlyName )
BEGIN
    ROLLBACK TRANSACTION
END
ELSE IF EXISTS ( SELECT * FROM dbo.[MSSManagedPropAliases] 
        WHERE binary_checksum(@Name) = AliasHash
          AND @Name = Alias )
BEGIN
    ROLLBACK TRANSACTION
END
ELSE
BEGIN
    INSERT INTO dbo.[MSSManagedPropAliases]
        (
            [PID], 
            [Alias] 
        )
        VALUES(@PID, @Name )

    if ( 0 != @RetVal )
        SELECT @RetVal = @@ERROR

    if @UpdateManagedProperty = 1
        exec @RetVal = proc_MSS_SetManagedPropertyLastModified @PID

    if ( 0 = @RetVal )
        COMMIT TRANSACTION
    else
        ROLLBACK TRANSACTION
END
return @RetVal

GO
