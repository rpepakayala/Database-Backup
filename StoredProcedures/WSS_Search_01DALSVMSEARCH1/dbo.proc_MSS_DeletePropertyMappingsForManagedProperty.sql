/****** Object:  StoredProcedure [dbo].[proc_MSS_DeletePropertyMappingsForManagedProperty]    Script Date: 5/15/2018 12:13:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_DeletePropertyMappingsForManagedProperty
@PID int
AS
DECLARE @RetVal int  SET @RetVal = 0
DECLARE @DateNow datetime Select @DateNow = CURRENT_TIMESTAMP
BEGIN TRANSACTION
    Update dbo.MSSCrawledProperties set LastModified = @DateNow
           where crawledPropertyId in
           ( Select crawledPropertyId 
             From   dbo.MSSSchemaPropertyMappings
             Where  pid = @PID )
    SELECT @RetVal = @@ERROR
    IF 0 != @RetVal
    BEGIN
        ROLLBACK TRANSACTION
        return @RetVal
    END
    delete MSSSchemaPropertyMappings
           where pid = @PID
    SELECT @RetVal = @@ERROR
    IF 0 = @RetVal
    BEGIN
        COMMIT TRANSACTION
    END
    ELSE
    BEGIN
        ROLLBACK TRANSACTION
    END
    return @RetVal

GO
