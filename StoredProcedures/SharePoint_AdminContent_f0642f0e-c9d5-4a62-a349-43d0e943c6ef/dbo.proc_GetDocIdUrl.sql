/****** Object:  StoredProcedure [dbo].[proc_GetDocIdUrl]    Script Date: 5/15/2018 12:12:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetDocIdUrl
(
    @SiteID      uniqueidentifier,
    @DocDirName  nvarchar(256),
    @DocLeafName nvarchar(128),
    @DocID       uniqueidentifier   OUTPUT 
)
AS
    SET NOCOUNT ON
    SELECT 
        @DocID = Docs.Id
    FROM 
        Docs
    WHERE
        @DocDirName = Docs.DirName AND
        @DocLeafName = Docs.LeafName AND
        @siteID = Docs.SiteId
    IF (0 = @@ROWCOUNT)
        RETURN 2
    ELSE
        RETURN 0

GO
