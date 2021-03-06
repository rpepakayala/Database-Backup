/****** Object:  StoredProcedure [dbo].[proc_MapUrlToListAndView]    Script Date: 5/15/2018 12:12:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MapUrlToListAndView(
    @SiteID     uniqueidentifier,
    @WebID      uniqueidentifier, 
    @DirName nvarchar(256),
    @LeafName nvarchar(128))
AS
    SET NOCOUNT ON
    SELECT TOP 1
        WebParts.tp_Id,
        WebParts.tp_ListId
    FROM
        Docs
    INNER JOIN
        WebParts
    ON
        WebParts.tp_SiteID = Docs.SiteId AND
        WebParts.tp_PageUrlID = Docs.Id AND
        WebParts.tp_Level = Docs.Level
    WHERE
        Docs.SiteId = @SiteID AND
        Docs.DirName = @DirName AND
        Docs.LeafName = @LeafName AND
        Docs.WebId = @WebID AND
        Docs.Level = 1
    RETURN 0

GO
