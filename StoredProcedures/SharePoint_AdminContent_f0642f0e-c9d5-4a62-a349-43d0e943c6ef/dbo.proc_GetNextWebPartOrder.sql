/****** Object:  StoredProcedure [dbo].[proc_GetNextWebPartOrder]    Script Date: 5/15/2018 12:12:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetNextWebPartOrder
(
    @SiteID     uniqueidentifier,
    @DocID      uniqueidentifier,
    @ZoneId     nvarchar(64),
    @NextOrder  int OUTPUT
)
AS
    SET NOCOUNT ON
    SELECT
        @NextOrder = MAX(WebParts.tp_PartOrder) + 1
    FROM
        WebParts
    WHERE
        @SiteID = WebParts.tp_SiteId AND
        @DocID = WebParts.tp_PageUrlID AND
        @ZoneId = WebParts.tp_ZoneID
    IF (@NextOrder IS NULL)
        SET @NextOrder = 1

GO
