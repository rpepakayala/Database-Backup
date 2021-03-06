/****** Object:  StoredProcedure [dbo].[proc_DeplFixupListDirectories]    Script Date: 5/15/2018 12:12:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplFixupListDirectories(
    @SiteId uniqueidentifier,
    @ListId uniqueidentifier,
    @RootFolderId uniqueidentifier)
AS
    SET NOCOUNT ON
    SET NOCOUNT ON
    DECLARE @RootFolderUrl nvarchar(260)
    SELECT @RootFolderUrl = CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
    FROM Docs
    WHERE Docs.Id = @RootFolderId
	UPDATE Docs
		SET ListId = @ListId
	FROM Docs 
	WHERE
		Docs.Id = @RootFolderId 
    DECLARE @RootFolderUrlLike nvarchar(260)
    EXEC proc_EscapeForLike @RootFolderUrl, @RootFolderUrlLike OUTPUT
	UPDATE Docs
        SET ListId = @ListId
    FROM Docs 
    WHERE
        Docs.SiteId = @SiteId AND
        (Docs.DirName = @RootFolderUrl OR
        Docs.DirName LIKE @RootFolderUrlLike) AND
        Docs.Type <> 2
    RETURN 0

GO
