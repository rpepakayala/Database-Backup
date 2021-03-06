/****** Object:  StoredProcedure [dbo].[proc_CanonicalDirNameFromUserInput]    Script Date: 5/15/2018 12:12:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CanonicalDirNameFromUserInput(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @FolderUrl nvarchar(256) OUTPUT,
    @ParentId uniqueidentifier OUTPUT,
    @ScopeId uniqueidentifier = NULL OUTPUT,
    @IgnoreWebId bit = 0)
AS
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    EXEC proc_SplitUrl
        @FolderUrl,
        @DirName OUTPUT,
        @LeafName OUTPUT
    SELECT
        @DirName = DirName,
        @LeafName = LeafName,
        @ParentId = Id,
        @ScopeId = ScopeId
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        IsCurrentVersion = 1 AND
        (Type = 1 OR Type = 2) AND
        (@IgnoreWebId = 1 OR (ISNULL(@WebId, WebId) = WebId))
    IF @@ROWCOUNT = 0
        RETURN 3
    SET @FolderUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END
    RETURN 0

GO
