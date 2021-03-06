/****** Object:  StoredProcedure [dbo].[proc_DeleteSite]    Script Date: 5/15/2018 12:12:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteSite(
    @SiteId uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    BEGIN TRAN
    EXEC @iRet = proc_DeleteSiteInternal @SiteId
    IF @iRet = 0
    BEGIN
        DELETE FROM
            Sites
        WHERE
            Id = @SiteId
        EXEC proc_LogChange @SiteId, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
            16384,  8, NULL
    END
cleanup:
    IF (@iRet <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @iRet

GO
