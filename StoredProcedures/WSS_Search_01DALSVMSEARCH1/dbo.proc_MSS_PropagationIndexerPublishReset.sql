/****** Object:  StoredProcedure [dbo].[proc_MSS_PropagationIndexerPublishReset]    Script Date: 5/15/2018 12:13:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_PropagationIndexerPublishReset(
    @CatalogID int, @TaskType int )
AS
BEGIN
SET NOCOUNT ON
    DECLARE @RetVal int SET @RetVal = 0
    BEGIN TRANSACTION
        DELETE dbo.MSSPropagationPropagationTask
        FROM dbo.MSSPropagationPropagationTask 
        WHERE dbo.MSSPropagationPropagationTask.CatalogID = @CatalogID
        SELECT @RetVal = @@ERROR
        IF 0 <> @RetVal  BEGIN
            ROLLBACK TRANSACTION
            return @RetVal
        END
        INSERT dbo.MSSPropagationPropagationTask VALUES ( @CatalogID, @TaskType, 0, 0, 0, GETUTCDATE() )
        SELECT @RetVal = @@ERROR
        IF 0 <> @RetVal  BEGIN
            ROLLBACK TRANSACTION
            return @RetVal
        END
    COMMIT TRANSACTION
END

GO
