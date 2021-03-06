/****** Object:  StoredProcedure [dbo].[proc_SecGetSitePrincipalId]    Script Date: 5/15/2018 12:12:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetSitePrincipalId(
    @SiteId uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @NextId int
    BEGIN TRAN
    SELECT
        @NextId = NextUserOrGroupId
    FROM
        Sites WITH (UPDLOCK)
    WHERE
        Id = @SiteId
    UPDATE
        Sites
    SET
        NextUserOrGroupId = @NextId + 1
    WHERE
        Id = @SiteId
    COMMIT TRAN
    RETURN @NextId

GO
