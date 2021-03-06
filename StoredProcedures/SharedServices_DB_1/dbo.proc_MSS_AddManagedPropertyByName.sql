/****** Object:  StoredProcedure [dbo].[proc_MSS_AddManagedPropertyByName]    Script Date: 5/15/2018 12:11:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddManagedPropertyByName
@Name nvarchar (64), 
@ManagedType int,
@PID int OUTPUT,
@FullTextQueriable bit OUTPUT,
@Retrievable bit OUTPUT 
AS

DECLARE @RetVal int  SET @RetVal = 0
DECLARE @Modified datetime Select @Modified = CURRENT_TIMESTAMP
BEGIN TRANSACTION

Update dbo.MSSSchemaHighLevelProps Set PID = PID+ 1
SELECT @RetVal = @@ERROR

select @PID = pid from MSSSchemaHighLevelProps
set @FullTextQueriable  = 1
set @Retrievable        = 1
INSERT INTO [dbo].[MSSManagedProperties]
    (
        [PID], 
        [FriendlyName], 
        [ManagedType], 
        [FullTextQueriable], 
        [Retrievable], 
        [Scoped], 
        [RespectPriority],
        [LastModified]
    )
    VALUES(@PID, @Name, @ManagedType, @FullTextQueriable,@Retrievable,0,0, @Modified )

if ( 0 != @RetVal )
    SELECT @RetVal = @@ERROR

Update MSSSchemaHighLevelProps set LastManagedProp = @Modified
if ( 0 != @RetVal )
    SELECT @RetVal = @@ERROR

if ( 0 = @RetVal )
     COMMIT TRANSACTION
else
     ROLLBACK TRANSACTION

return @RetVal

GO
