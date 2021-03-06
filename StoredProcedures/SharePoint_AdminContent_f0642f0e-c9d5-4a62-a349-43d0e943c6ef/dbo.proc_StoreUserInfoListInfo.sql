/****** Object:  StoredProcedure [dbo].[proc_StoreUserInfoListInfo]    Script Date: 5/15/2018 12:13:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_StoreUserInfoListInfo(
    @SiteId uniqueidentifier,
    @ListId uniqueidentifier,
    @RowOrdinal int,
    @ColName nvarchar(64))
AS
    SET NOCOUNT ON
    UPDATE
        Sites
    SET
        UserInfoListId = ISNULL(@ListId, UserInfoListId),
        UserIsActiveFieldRowOrdinal = @RowOrdinal,
        UserIsActiveFieldColumnName = @ColName
    WHERE
        Id = @SiteId

GO
