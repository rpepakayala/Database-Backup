/****** Object:  StoredProcedure [dbo].[proc_SecGetPrincipalByEmail]    Script Date: 5/15/2018 12:12:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetPrincipalByEmail(
    @SiteId uniqueidentifier,
    @Email nvarchar(255))
AS
    SET NOCOUNT ON
    SELECT TOP 1
        tp_ID,
        tp_SystemID,
        tp_Title,
        tp_Login,
        tp_Email,
        tp_Notes,
        tp_SiteAdmin,
        tp_DomainGroup
    FROM
        UserInfo
    WHERE
        tp_SiteId = @SiteId AND
        tp_Email = @Email AND
        tp_Deleted = 0

GO
