/****** Object:  StoredProcedure [dbo].[proc_MSS_AddPropertyMappingsFromIds]    Script Date: 5/15/2018 12:11:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_AddPropertyMappingsFromIds
@PID int,
@CrawledPropertyId int
AS
DECLARE @Order  int  SET @Order = 0
DECLARE @RetVal int  SET @RetVal = 0

if exists (Select * from MSSSchemaPropertyMappings where @PID = pid and @CrawledPropertyId = crawledPropertyId )
BEGIN
   return 0
END

BEGIN TRANSACTION
   select @Order = MAX(MappingOrder) from MSSSchemaPropertyMappings where @PID = PID
   if @Order is NULL
       Select @Order = 100
    else
       Select @Order = @Order + 100

    Insert Into MSSSchemaPropertyMappings 
           Values(@PID, @Order, @CrawledPropertyId                )
    SELECT @RetVal = @@ERROR

    if ( 0 != @RetVal )
        execute @RetVal = proc_MSS_SetCrawledPropertyLastModified @CrawledPropertyId

    IF 0 = @RetVal
        COMMIT TRANSACTION
    ELSE
    BEGIN
        ROLLBACK TRANSACTION
    END
return @RetVal

GO
