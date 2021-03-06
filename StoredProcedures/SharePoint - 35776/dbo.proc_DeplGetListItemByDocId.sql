/****** Object:  StoredProcedure [dbo].[proc_DeplGetListItemByDocId]    Script Date: 5/15/2018 12:11:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplGetListItemByDocId(
    @SiteId uniqueidentifier,
    @ListId uniqueidentifier,
    @DocId uniqueidentifier,
    @IsDeleted bit OUTPUT,
    @ListItemId int OUTPUT)
AS
    SET NOCOUNT ON
    IF @SiteId IS NULL OR @ListId IS NULL OR @DocId IS NULL
        RETURN 87
    SET @IsDeleted = 0
    SELECT TOP 1
        @ListItemId = Docs.DocLibRowId,
        @IsDeleted =
            CASE
                WHEN DeleteTransactionId=0x0 THEN 0
                ELSE 1
            END
    FROM
        AllDocs as Docs
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.Id = @DocId AND
        Docs.ListId = @ListId

GO
