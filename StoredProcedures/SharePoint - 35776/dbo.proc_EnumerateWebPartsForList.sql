/****** Object:  StoredProcedure [dbo].[proc_EnumerateWebPartsForList]    Script Date: 5/15/2018 12:11:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_EnumerateWebPartsForList(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        WebParts.tp_ID,
        WebParts.tp_ListId,
        WebParts.tp_Type,
        WebParts.tp_Flags,
        WebParts.tp_DisplayName,
        WebParts.tp_Version,
        CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END, 
        WebParts.tp_PartOrder,
        WebParts.tp_ZoneID,            
        WebParts.tp_IsIncluded,
        WebParts.tp_FrameState,
        WebParts.tp_WebPartTypeId,
        WebParts.tp_AllUsersProperties,
        WebParts.tp_PerUserProperties,
        WebParts.tp_Cache,
        WebParts.tp_Source
    FROM
        WebParts
    INNER JOIN
        Docs
    ON
        Docs.SiteId = @SiteId AND
        Docs.WebId = @WebId AND
        Docs.Id = WebParts.tp_PageUrlID AND
        Docs.SiteId = WebParts.tp_SiteID AND
        Docs.Level = WebParts.tp_Level AND
        Docs.ListId = @ListId AND
        Docs.Level = 1 AND
        WebParts.tp_UserID IS NULL  
    RETURN 0            

GO
