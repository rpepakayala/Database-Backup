/****** Object:  StoredProcedure [dbo].[proc_SecFixScopeByTransactionId]    Script Date: 5/15/2018 12:12:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecFixScopeByTransactionId(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @DeleteTransactionId varbinary(16))
AS
    SET NOCOUNT ON    
    DECLARE @ScopeId uniqueidentifier
    SELECT
        @ScopeId = ScopeId
    FROM
        Perms
    WHERE
        SiteId = @SiteId AND
        DelTransId = @DeleteTransactionId
    EXEC proc_SecFixScope @SiteId, @WebId, @ScopeId

GO
