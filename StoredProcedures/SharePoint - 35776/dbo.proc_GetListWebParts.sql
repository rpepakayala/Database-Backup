/****** Object:  StoredProcedure [dbo].[proc_GetListWebParts]    Script Date: 5/15/2018 12:12:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetListWebParts(
    @ListId uniqueidentifier,
    @UserID int,
    @bGetAllLevel bit,
    @bGetDeleted bit = 0,
    @bGetAllUsers bit = 0,
    @SiteId uniqueidentifier)
AS
    SET NOCOUNT ON
    SELECT
        WP1.tp_ListID,
        WP1.tp_Type,
        WP1.tp_ID,
        WP1.tp_Flags,
        WP1.tp_DisplayName,
        CASE WHEN (DATALENGTH(AllDocs.DirName) = 0) THEN AllDocs.LeafName WHEN (DATALENGTH(AllDocs.LeafName) = 0) THEN AllDocs.DirName ELSE AllDocs.DirName + N'/' + AllDocs.LeafName END
        AS
            tp_PageUrl,
        WP1.tp_BaseViewId,
        WP1.tp_View,
        WP1.tp_Level,
        WP1.tp_ContentTypeId
    FROM
        WebParts AS WP1
    INNER JOIN 
        AllDocs
    ON
        AllDocs.SiteId = @SiteId AND 
        WP1.tp_SiteID = @SiteId AND
        AllDocs.Id = WP1.tp_PageUrlID AND
        AllDocs.Level = WP1.tp_Level AND
        (@bGetDeleted = 1 OR AllDocs.DeleteTransactionId = 0x) AND
        (@bGetAllLevel = 1 OR 
        (AllDocs.Level = 255 AND 
            AllDocs.LTCheckoutUserId = @UserID OR
        ((AllDocs.Level = 1 AND 
          (AllDocs.DraftOwnerId IS NULL OR 
          WP1.tp_UserID = @UserID AND
          NOT EXISTS (SELECT * FROM WebParts AS WP2 
          WHERE WP2.tp_Level = 2 AND
          WP2.tp_ID = WP1.tp_ID AND
          WP2.tp_SiteID = WP1.tp_SiteID)) OR
          AllDocs.Level = 2)  AND
        (AllDocs.LTCheckoutUserId IS NULL OR 
            AllDocs.LTCheckoutUserId <> @UserID))))
    WHERE
        WP1.tp_ListId = @ListId
        AND (@bGetAllUsers = 1 OR 
            WP1.tp_UserID IS NULL OR
            WP1.tp_UserID = @UserID)        
    ORDER BY
        WP1.tp_CreationTime

GO
