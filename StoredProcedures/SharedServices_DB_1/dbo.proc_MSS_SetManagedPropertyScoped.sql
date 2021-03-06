/****** Object:  StoredProcedure [dbo].[proc_MSS_SetManagedPropertyScoped]    Script Date: 5/15/2018 12:11:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_SetManagedPropertyScoped
@PID int,
@Scoped bit
AS

DECLARE @RetVal int  SET @RetVal = 0
DECLARE @Modified datetime SET @Modified = CURRENT_TIMESTAMP

Update [dbo].[MSSManagedProperties]
        Set Scoped = @Scoped,
            LastModified = @Modified
        where PID = @PID
    SELECT @RetVal = @@ERROR
    Update MSSSchemaHighLevelProps set LastManagedProp = @Modified
    if ( 0 != @RetVal )
     SELECT @RetVal = @@ERROR

return @RetVal

GO
