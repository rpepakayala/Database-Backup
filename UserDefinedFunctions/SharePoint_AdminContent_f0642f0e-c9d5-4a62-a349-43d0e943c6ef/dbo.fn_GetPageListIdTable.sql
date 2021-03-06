/****** Object:  UserDefinedFunction [dbo].[fn_GetPageListIdTable]    Script Date: 5/15/2018 12:15:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_GetPageListIdTable(
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
        AllLists.tp_ID AS tp_ListId,
        AllLists.tp_WebId AS tp_WebId,
        AllLists.tp_HasFGP AS tp_HasFGP,
        AllLists.tp_HasInternalFGP AS tp_HasInternalFGP,
        AllLists.tp_ScopeId AS tp_ScopeId,
        AllLists.tp_RootFolder AS tp_RootFolder
    FROM
        fn_GetPageListIdTableNoListInfo(
            @SiteId, @DocId, @RootWebId, @WebId, @ListId,
            @UserInfoListId, @UserId, @Level) AS PageLists
    INNER JOIN 
        AllLists WITH (NOLOCK)
    ON
        AllLists.tp_WebId = PageLists.tp_WebId AND
        AllLists.tp_ID = PageLists.tp_ListId
)

GO
