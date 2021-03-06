/****** Object:  StoredProcedure [dbo].[proc_GetDoclibFoldersCursor]    Script Date: 5/15/2018 12:12:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetDoclibFoldersCursor
(
    @SiteId                 uniqueidentifier,
    @WebId                  uniqueidentifier,   
    @WebUrl                 nvarchar(256) = NULL,
    @@DocLibFolders_cursor  CURSOR VARYING OUTPUT
)
AS
    SET NOCOUNT ON
    IF @WebUrl IS NULL
    BEGIN
        IF @WebId IS NULL
            RETURN 13
        SELECT
            @WebUrl = FullUrl
        FROM
            Webs
        WHERE
            Id = @WebId
        IF @WebUrl IS NULL
            RETURN 3
    END
    DECLARE @WebFolderUrlLike nvarchar(1024)
    EXEC proc_EscapeForLike @WebUrl, @WebFolderUrlLike OUTPUT
    SET @@DocLibFolders_cursor = CURSOR
        LOCAL
        FAST_FORWARD
    FOR
    SELECT
        CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
    FROM
        Docs INNER JOIN Lists
    ON
        Docs.Id = Lists.tp_RootFolder
    WHERE
        Docs.SiteId = @SiteId AND           
        (Docs.DirName = @WebUrl OR
            Docs.DirName LIKE @WebFolderUrlLike) AND
        Docs.Type = 1 AND 
        Docs.WebId = @WebId AND             
        Lists.tp_WebId = @WebId AND
        Lists.tp_BaseType = 1 AND
        (Lists.tp_Flags & 0x20) <> 0
    OPEN @@DocLibFolders_cursor
    RETURN 0

GO
