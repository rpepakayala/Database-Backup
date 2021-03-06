/****** Object:  StoredProcedure [dbo].[proc_SecGetPrincipalById]    Script Date: 5/15/2018 12:12:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetPrincipalById(
    @SiteId           uniqueidentifier,
    @PrincipalId      int,
    @GetSTSToken      bit = 0,
    @GetExternalToken bit = 0,
    @GetExpandedSTSGroup bit = 0)
AS
    SET NOCOUNT ON
    SELECT
        tp_ID,
        tp_SystemID,
        tp_Title,
        tp_Login,
        tp_Email,
        tp_Notes,
        tp_SiteAdmin,
        tp_DomainGroup,
        CASE WHEN @GetExternalToken = 1 THEN tp_ExternalTokenLastUpdated ELSE NULL END,
        CASE WHEN @GetExternalToken = 1 THEN tp_ExternalToken ELSE NULL END,
        CASE WHEN @GetSTSToken = 1 THEN tp_token ELSE NULL END
    FROM
        UserInfo
    WHERE
        tp_SiteId = @SiteId AND
        tp_Id = @PrincipalId AND
        tp_Deleted = 0
    IF (@@ROWCOUNT <> 1 AND @GetExpandedSTSGroup = 1)
    BEGIN
        SELECT
            U.tp_ID,
            U.tp_SystemID,
            U.tp_Title,
            U.tp_Login,
            U.tp_Email,
            U.tp_Notes,
            U.tp_SiteAdmin,
            U.tp_DomainGroup,
            CASE WHEN @GetExternalToken = 1 THEN U.tp_ExternalTokenLastUpdated ELSE NULL END,
            CASE WHEN @GetExternalToken = 1 THEN U.tp_ExternalToken ELSE NULL END,
            CASE WHEN @GetSTSToken = 1 THEN U.tp_token ELSE NULL END
        FROM
            UserInfo AS U
        INNER JOIN
            GroupMembership AS G
        ON
            G.SiteId = U.tp_SiteId AND
            G.MemberId = U.tp_ID
        WHERE
            G.SiteId = @SiteId AND
            G.GroupId = @PrincipalId AND
            U.tp_Deleted = 0
    END

GO
