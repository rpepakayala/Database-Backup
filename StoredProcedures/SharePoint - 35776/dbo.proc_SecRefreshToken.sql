/****** Object:  StoredProcedure [dbo].[proc_SecRefreshToken]    Script Date: 5/15/2018 12:12:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecRefreshToken(
    @SiteId uniqueidentifier,
    @UserId int,
    @ExternalToken image,
    @ExternalTokenTime datetime)
AS
    SET NOCOUNT ON
    UPDATE
        UserInfo
    SET
        tp_ExternalToken = @ExternalToken,
        tp_ExternalTokenLastUpdated = @ExternalTokenTime
    WHERE
        tp_SiteId = @SiteId AND
        tp_ID = @UserId

GO
