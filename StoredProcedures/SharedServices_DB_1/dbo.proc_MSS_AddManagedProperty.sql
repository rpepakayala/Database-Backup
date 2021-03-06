/****** Object:  StoredProcedure [dbo].[proc_MSS_AddManagedProperty]    Script Date: 5/15/2018 12:11:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddManagedProperty
@PID int,
@Name nvarchar (64), 
@ManagedType int,
@FullTextQueriable bit,
@Retrievable bit,
@Scoped bit,
@RespectPriority bit

AS

DECLARE @RetVal int  SET @RetVal = 0

IF not exists (select * from dbo.MSSManagedProperties where @PID = pid)
Begin
INSERT INTO [dbo].[MSSManagedProperties]
    (
        [PID], 
        [FriendlyName], 
        [ManagedType], 
        [FullTextQueriable], 
        [Retrievable], 
        [Scoped], 
        [RespectPriority]
    )
    VALUES(@PID, @Name, @ManagedType, 
        @FullTextQueriable,
        @Retrievable,
        @Scoped, 
        @RespectPriority 
    )
End

SELECT @RetVal = @@ERROR

return @RetVal

GO
