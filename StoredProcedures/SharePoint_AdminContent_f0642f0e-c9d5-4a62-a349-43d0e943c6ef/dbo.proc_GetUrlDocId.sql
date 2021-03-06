/****** Object:  StoredProcedure [dbo].[proc_GetUrlDocId]    Script Date: 5/15/2018 12:12:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetUrlDocId
(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @DocId uniqueidentifier 
)
AS
    SET NOCOUNT ON
    SELECT 
        Docs.DirName,
        Docs.LeafName
    FROM 
        Docs
    WHERE
        @DocId = Docs.Id AND
        @SiteId = Docs.SiteId AND
        @WebId = Docs.WebId
    IF (0 = @@ROWCOUNT)
        RETURN 2
    ELSE
        RETURN 0

GO
