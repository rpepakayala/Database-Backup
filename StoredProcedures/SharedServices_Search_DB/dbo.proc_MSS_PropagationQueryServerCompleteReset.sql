/****** Object:  StoredProcedure [dbo].[proc_MSS_PropagationQueryServerCompleteReset]    Script Date: 5/15/2018 12:11:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_PropagationQueryServerCompleteReset(
    @CatalogID int, @TaskType int, @ServerName nvarchar( 31 ) )
AS

BEGIN

SET NOCOUNT ON

    DECLARE @RetVal int SET @RetVal = 0

    DECLARE
        @QueryServerID int
    SELECT
        @QueryServerID = SearchServerID
    FROM
        dbo.MSSPropagationSearchServerTable
    WHERE
        SearchServerName = @ServerName

    BEGIN TRANSACTION

        DELETE dbo.MSSPropagationSearchServerReady
        FROM dbo.MSSPropagationSearchServerReady 
        WHERE dbo.MSSPropagationSearchServerReady.CatalogID = @CatalogID AND
              dbo.MSSPropagationSearchServerReady.SearchServerID = @QueryServerID   

        SELECT @RetVal = @@ERROR
        IF 0 <> @RetVal  BEGIN
            ROLLBACK TRANSACTION
            return @RetVal
        END

        INSERT dbo.MSSPropagationSearchServerReady VALUES ( @CatalogID, @TaskType, 0, @QueryServerID )

        SELECT @RetVal = @@ERROR
        IF 0 <> @RetVal  BEGIN
            ROLLBACK TRANSACTION
            return @RetVal
        END

    COMMIT TRANSACTION

END


GO
