/****** Object:  StoredProcedure [dbo].[proc_GetGlobalAuditMask]    Script Date: 5/15/2018 12:12:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetGlobalAuditMask
(
    @SiteId             uniqueidentifier,
    @GlobalAuditMask    int             OUTPUT
)
AS
    SET NOCOUNT ON
    SELECT
        @GlobalAuditMask = AuditFlags
    FROM
        Sites WITH(NOLOCK)
    WHERE
        Id = @SiteId
    RETURN 0

GO
