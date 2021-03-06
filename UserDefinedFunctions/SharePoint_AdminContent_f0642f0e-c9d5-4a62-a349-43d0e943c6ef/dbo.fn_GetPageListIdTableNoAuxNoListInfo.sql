/****** Object:  UserDefinedFunction [dbo].[fn_GetPageListIdTableNoAuxNoListInfo]    Script Date: 5/15/2018 12:15:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_GetPageListIdTableNoAuxNoListInfo(
    @SiteId uniqueidentifier,
    @DocId uniqueidentifier,
    @RootWebId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @UserInfoListId uniqueidentifier,
    @UserId int,
    @Level tinyint)
RETURNS TABLE
AS
RETURN
(
    SELECT
        WebPartLists.tp_WebId AS tp_WebId,
        WebPartLists.tp_ListId AS tp_ListId
    FROM
        WebPartLists
    WHERE
        tp_SiteId = @SiteId AND
        tp_UserID IS NULL AND
        tp_PageUrlId = @DocId AND
        tp_Level = @Level
    UNION
    SELECT
        WebPartLists.tp_WebId AS tp_WebId,
        WebPartLists.tp_ListId AS tp_ListId
    FROM
        WebPartLists
    WHERE
        tp_SiteId = @SiteId AND
        tp_UserID = @UserId AND
        tp_PageUrlId = @DocId AND
        tp_Level = @Level
)

GO
