/****** Object:  StoredProcedure [dbo].[proc_SecGetAccountStatus]    Script Date: 5/15/2018 12:12:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetAccountStatus(
    @SiteId uniqueidentifier,
    @Login nvarchar(255),
    @Email nvarchar(255))
AS
    SET NOCOUNT ON
    SELECT
        tp_Login,
        tp_Email,
        tp_SystemId
    FROM
        UserInfo
    WHERE
        tp_SiteId = @SiteId AND
        (tp_Login = @Login OR
        (tp_Email = @Email AND tp_Email <> N'')) AND
        tp_Deleted = 0 AND
        tp_DomainGroup = 0

GO
