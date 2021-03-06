/****** Object:  StoredProcedure [dbo].[proc_SecGetWebPrincipalId]    Script Date: 5/15/2018 12:12:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetWebPrincipalId(
    @WebId uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @NextId int
    BEGIN TRAN
    SELECT
        @NextId = NextWebGroupId
    FROM
        Webs WITH (UPDLOCK)
    WHERE
        Id = @WebId
    UPDATE
        Webs
    SET
        NextWebGroupId = @NextId + 1
    WHERE
        Id = @WebId
    COMMIT TRAN
    RETURN @NextId

GO
