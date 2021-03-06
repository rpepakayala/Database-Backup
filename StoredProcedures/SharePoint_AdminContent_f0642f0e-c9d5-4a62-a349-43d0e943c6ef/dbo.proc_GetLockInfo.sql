/****** Object:  StoredProcedure [dbo].[proc_GetLockInfo]    Script Date: 5/15/2018 12:12:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetLockInfo(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @Level tinyint)
AS
    SELECT 
        UserInfo.tp_Login,                              
        Docs.CheckoutDate,                              
        CASE WHEN Docs.LTCheckoutUserId IS NULL         
        THEN 
            Docs.CheckoutExpires
        ELSE NULL
        END
    FROM
        Docs
    LEFT OUTER JOIN
        UserInfo
    ON
        Docs.CheckoutUserId = UserInfo.tp_Id AND
        Docs.SiteId = UserInfo.tp_SiteID
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @DirName AND
        Docs.LeafName = @LeafName AND
        Docs.Level = @Level

GO
