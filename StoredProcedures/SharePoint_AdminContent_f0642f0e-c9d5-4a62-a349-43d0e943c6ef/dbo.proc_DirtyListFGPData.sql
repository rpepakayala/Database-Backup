/****** Object:  StoredProcedure [dbo].[proc_DirtyListFGPData]    Script Date: 5/15/2018 12:12:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DirtyListFGPData(
    @SiteId       uniqueidentifier,
    @WebId        uniqueidentifier,
    @ListId       uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @HasInternalFGP bit
    SELECT
        @HasInternalFGP = tp_HasInternalFGP
    FROM
        AllLists WITH (NOLOCK)
    WHERE
        tp_WebId = @WebId AND
        tp_Id = @ListId
    IF (@HasInternalFGP = 0)
    BEGIN
        DECLARE @ListFullUrl nvarchar(260)
        DECLARE @ListLike nvarchar(1024)
        SELECT
            @ListFullUrl = CASE WHEN (DATALENGTH(AllDocs.DirName) = 0) THEN AllDocs.LeafName WHEN (DATALENGTH(AllDocs.LeafName) = 0) THEN AllDocs.DirName ELSE AllDocs.DirName + N'/' + AllDocs.LeafName END
        FROM
            AllLists WITH (NOLOCK)
        INNER JOIN
            AllDocs WITH (NOLOCK)
        ON
            AllLists.tp_RootFolder = AllDocs.Id AND
            AllDocs.Level = 1
        WHERE
            AllLists.tp_WebId = @WebId AND
            AllLists.tp_Id = @ListId
        EXEC proc_EscapeForLike @ListFullUrl, @ListLike OUTPUT
        SET @HasInternalFGP = CASE WHEN EXISTS(
            SELECT
                *
            FROM
                Perms
            WHERE
                Perms.SiteId = @SiteId AND
                Perms.DelTransId = 0x AND
                Perms.ScopeUrl LIKE @ListLike)
        THEN 1 ELSE 0 END
    END
    UPDATE
        AllLists
    SET
        tp_HasFGP = 1,
        tp_HasInternalFGP = @HasInternalFGP
    WHERE
        tp_WebId = @WebId AND
        tp_Id = @ListId
    UPDATE
        WebParts
    SET
        tp_HasFGP = 1
    WHERE
        tp_ListId = @ListId
    RETURN 0

GO
