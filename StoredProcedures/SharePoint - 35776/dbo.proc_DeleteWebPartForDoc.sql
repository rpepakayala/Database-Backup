/****** Object:  StoredProcedure [dbo].[proc_DeleteWebPartForDoc]    Script Date: 5/15/2018 12:11:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteWebPartForDoc
(
    @SiteId          uniqueidentifier,
    @DocId           uniqueidentifier,
    @Level           tinyint,
    @OldLevel        tinyint = NULL
)
AS
    IF @Level < @OldLevel OR @OldLevel is NULL
    BEGIN
        IF @OldLevel IS NOT NULL
        BEGIN
        UPDATE
            wpForDelete
        SET
            tp_Level = @OldLevel
        FROM
            WebParts AS wpForDelete
        WHERE
            wpForDelete.tp_Level = @Level AND
            wpForDelete.tp_PageUrlID = @DocID AND
            wpForDelete.tp_SiteID = @SiteID AND
            wpForDelete.tp_UserID IS NOT NULL AND
            NOT EXISTS (SELECT * FROM  WebParts AS wpRemain
            WHERE wpRemain.tp_Level = @OldLevel AND
            wpRemain.tp_ID = wpForDelete.tp_ID)
        END
        UPDATE
           wpForDelete
        SET
           tp_Level = 0
        FROM WebParts wpForDelete, WebParts wpRemain
        WHERE
           wpForDelete.tp_SiteID = wpRemain.tp_SiteID AND
           wpForDelete.tp_PageUrlID = wpRemain.tp_PageUrlID AND
           wpForDelete.tp_ID = wpRemain.tp_ID AND
           wpRemain.tp_Level <> @Level AND
           (@OldLevel IS NULL OR
           wpRemain.tp_Level >= @OldLevel) AND
           wpForDelete.tp_WebPartTypeId = wpRemain.tp_WebPartTypeId  AND
           wpForDelete.tp_Level = @Level AND
           wpForDelete.tp_PageUrlID = @DocID AND
           wpForDelete.tp_SiteID = @SiteID AND
           wpForDelete.tp_UserID IS NULL
        IF @Level = 1 AND @OldLevel = 255
        BEGIN
            DELETE
                WebPartLists
            WHERE
                WebPartLists.tp_SiteId = @SiteID AND
                WebPartLists.tp_PageUrlID = @DocID AND
                WebPartLists.tp_Level = 0
            DELETE
                WebParts
            WHERE
                WebParts.tp_SiteId = @SiteID AND
                WebParts.tp_PageUrlID = @DocID AND
                WebParts.tp_Level = 0
            UPDATE
                wpForDelete
            SET
                tp_Level = @OldLevel
            FROM WebParts AS wpForDelete
            WHERE
                wpForDelete.tp_Level = 2 AND
                wpForDelete.tp_PageUrlID = @DocID AND
                wpForDelete.tp_SiteID = @SiteID AND
                wpForDelete.tp_UserID IS NOT NULL AND
                NOT EXISTS (SELECT * FROM  WebParts AS wpRemain
                WHERE wpRemain.tp_Level = @OldLevel AND
                wpRemain.tp_ID = wpForDelete.tp_ID)
            UPDATE
                wpForDelete
            SET
                tp_Level = 0
            FROM WebParts wpForDelete, WebParts wpRemain
            WHERE
                wpForDelete.tp_SiteID = wpRemain.tp_SiteID AND
                wpForDelete.tp_PageUrlID = wpRemain.tp_PageUrlID AND
                wpForDelete.tp_ID = wpRemain.tp_ID AND
                wpRemain.tp_Level = 255 AND
                wpForDelete.tp_WebPartTypeId = wpRemain.tp_WebPartTypeId  AND
                wpForDelete.tp_Level = 2 AND
                wpForDelete.tp_PageUrlID = @DocID AND
                wpForDelete.tp_SiteID = @SiteID AND
                wpForDelete.tp_UserID IS NULL
        END
        DELETE
           WebPartLists
        WHERE
           WebPartLists.tp_SiteId = @SiteID AND
           WebPartLists.tp_PageUrlID = @DocID AND
           (WebPartLists.tp_Level = 0 OR
            @OldLevel IS NULL AND
            WebPartLists.tp_Level = @Level OR
            WebPartLists.tp_Level >= @Level AND
            WebPartLists.tp_Level < @OldLevel)
        DELETE
           WebParts
        WHERE
           WebParts.tp_SiteId = @SiteID AND
           WebParts.tp_PageUrlID = @DocID AND
           (WebParts.tp_Level = 0 OR
            @OldLevel IS NULL AND
            WebParts.tp_Level = @Level OR
            WebParts.tp_Level >= @Level AND
            WebParts.tp_Level < @OldLevel)
    END

GO
