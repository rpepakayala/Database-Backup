/****** Object:  StoredProcedure [dbo].[proc_MSS_DeleteLocationVisualisations]    Script Date: 5/15/2018 12:11:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_DeleteLocationVisualisations(
    @LocationId int,
    @VisualisationName nvarchar(60) = NULL)
 AS

SET NOCOUNT ON

DECLARE @LastError int

BEGIN TRAN

IF (datalength(@VisualisationName) = NULL) Or (datalength(@VisualisationName) = 0)
BEGIN
    -- Delete all visualisation for a given location
   Delete dbo.MSSLocationVisualisations
   WHERE LocationId = @LocationId

    SELECT @LastError = @@ERROR
    IF @LastError <> 0
    BEGIN 
        ROLLBACK TRAN
        RETURN @LastError
    END

    EXEC @LastError = dbo.proc_MSS_UpdateCacheInformation

    SELECT @LastError = @@ERROR
    IF @LastError <> 0
    BEGIN 
        ROLLBACK TRAN
        RETURN @LastError
    END

    COMMIT TRAN
    RETURN 0
END

--We need to delete a particular Visualisation for a given Location
DELETE dbo.MSSLocationVisualisations
WHERE LocationId = @LocationId And VisualisationName = @VisualisationName

SELECT @LastError = @@ERROR
IF (@LastError <> 0) 
BEGIN 
    ROLLBACK TRAN
    RETURN @LastError
END

EXEC @LastError = dbo.proc_MSS_UpdateCacheInformation

SELECT @LastError = @@ERROR
IF @LastError <> 0
BEGIN 
    ROLLBACK TRAN
    RETURN @LastError
END

COMMIT TRAN
RETURN 0

GO
