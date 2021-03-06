/****** Object:  StoredProcedure [dbo].[proc_DeplFixWebPartsOnListCreation]    Script Date: 5/15/2018 12:11:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplFixWebPartsOnListCreation(
    @SiteId uniqueidentifier,
    @WebPartId uniqueidentifier,
    @OldListId uniqueidentifier,
    @NewListId uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @HasFGP bit
    DECLARE @ListWebId uniqueidentifier
    IF @NewListId IS NOT NULL
    BEGIN
        SELECT
            @HasFGP = tp_HasFGP,
            @ListWebId = tp_WebId
        FROM
            AllLists
        WHERE
            tp_Id = @NewListId
    END
    BEGIN TRAN
    UPDATE WebParts
    SET
        tp_ListId = @NewListId,
        tp_HasFGP =
            CASE
                WHEN @HasFGP IS NULL THEN tp_HasFGP
                ELSE @HasFGP
        END
    FROM
        WebParts
    WHERE
        tp_SiteId = @SiteId AND
        tp_Id = @WebPartId AND
        tp_ListId = @OldListId
    UPDATE WebPartLists
    SET
        tp_ListId = @NewListId,
        tp_WebId =
            CASE
                WHEN @ListWebId IS NULL THEN tp_WebId
                ELSE @ListWebId
        END
    FROM
        WebPartLists
    WHERE
        tp_SiteId = @SiteId AND
        tp_WebPartId = @WebPartId AND
        tp_ListId = @OldListId
    COMMIT TRAN

GO
