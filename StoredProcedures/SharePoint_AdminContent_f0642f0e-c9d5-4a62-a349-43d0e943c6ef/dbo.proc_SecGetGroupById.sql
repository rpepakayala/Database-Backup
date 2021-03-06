/****** Object:  StoredProcedure [dbo].[proc_SecGetGroupById]    Script Date: 5/15/2018 12:12:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetGroupById(
    @SiteId uniqueidentifier,
    @GroupId int,
    @Count int OUTPUT)
AS
    SET @Count = 0
    IF @Count = 0
    BEGIN
        SELECT
            @Count = COUNT(*)
        FROM
            Groups WITH (NOLOCK)
        WHERE
            Groups.SiteId = @SiteId AND
            Groups.ID = @GroupId
    END
    IF @Count = 0
    BEGIN
        SELECT
            @Count = COUNT(*)
        FROM
            UserInfo WITH (NOLOCK)
        WHERE
            UserInfo.tp_SiteID = @SiteId AND
            UserInfo.tp_DomainGroup = 1 AND
            UserInfo.tp_ID = @GroupId
    END

GO
