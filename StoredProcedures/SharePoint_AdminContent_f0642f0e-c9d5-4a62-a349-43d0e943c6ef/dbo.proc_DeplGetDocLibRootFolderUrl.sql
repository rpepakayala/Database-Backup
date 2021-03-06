/****** Object:  StoredProcedure [dbo].[proc_DeplGetDocLibRootFolderUrl]    Script Date: 5/15/2018 12:12:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_DeplGetDocLibRootFolderUrl(
    @SiteId uniqueidentifier,
    @ListId uniqueidentifier,
    @Url nvarchar(1024) OUTPUT)
AS
    SET NOCOUNT ON
    SELECT
        @Url = CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
    FROM
        Docs WITH (NOLOCK)
    JOIN
        Lists
    ON
        Lists.tp_RootFolder = Docs.Id AND
        Lists.tp_ID = @ListId
    WHERE
        Docs.SiteId = @SiteId AND
        Lists.tp_BaseType = 1

GO
