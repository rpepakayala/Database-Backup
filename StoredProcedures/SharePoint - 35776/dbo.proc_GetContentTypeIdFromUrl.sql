/****** Object:  StoredProcedure [dbo].[proc_GetContentTypeIdFromUrl]    Script Date: 5/15/2018 12:12:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetContentTypeIdFromUrl
(
    @DocSiteID     uniqueidentifier,
    @DocDirName    nvarchar(256),
    @DocLeafName   nvarchar(128)
)
AS
    SET NOCOUNT ON
    SELECT TOP 1
        ISNULL(UserData.tp_ContentTypeId, 0x012001)
    FROM
        Docs LEFT OUTER JOIN UserData
    ON
        Docs.SiteId = UserData.tp_SiteId AND
        Docs.DirName = UserData.tp_DirName AND
        Docs.LeafName = UserData.tp_LeafName AND
        Docs.Level = UserData.tp_Level
    WHERE
        Docs.SiteId = @DocSiteId AND
        Docs.DirName = @DocDirName AND
        Docs.LeafName = @DocLeafName AND
        UserData.tp_IsCurrent = 1

GO
