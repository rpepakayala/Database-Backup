/****** Object:  StoredProcedure [dbo].[proc_GetAllAttachmentsInfo]    Script Date: 5/15/2018 12:12:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetAllAttachmentsInfo(
    @SiteID     uniqueidentifier,
    @WebID      uniqueidentifier,
    @ListID     uniqueidentifier,
    @ItemID     int)
AS
    DECLARE @ListRootUrl   nvarchar(260)
    DECLARE @dirName nvarchar(260)
    DECLARE @dirNameLike nvarchar(1024)
    SET NOCOUNT ON
    SELECT @ListRootUrl = CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
    FROM Docs, Lists
    WHERE
        Lists.tp_WebId      = @WebID AND
        Lists.tp_ID         = @ListID AND
        Lists.tp_RootFolder = Docs.Id
    SET @dirName = @ListRootUrl + N'/' + N'Attachments'
    EXEC proc_EscapeForLike @dirName, @dirNameLike OUTPUT, 1
    IF (@ListRootUrl IS NOT NULL)
    BEGIN
    IF (@ItemID = -1)
    BEGIN
        SELECT
                dbo.fn_GetDocItemid(Docs.DirName) as A, 
                Docs.LeafName,
                Docs.Id,
                Docs.Version,
                Perms.Acl,
                Perms.AnonymousPermMask
            FROM 
                Docs
            INNER JOIN Perms ON
                Docs.SiteId = Perms.SiteId AND
                Docs.ScopeId = Perms.ScopeId
            WHERE
                Docs.SiteId  = @SiteID AND
                DirName Like @dirNameLike AND
                Level = 1 AND
                Type = 0
            ORDER BY A ASC
    END
    ELSE
    BEGIN
            SELECT
                Docs.Id, Docs.LeafName
            FROM Docs	
            WHERE
                SiteId  = @SiteID AND
                DirName = @dirName +
                    N'/' + CAST(@ItemID AS nvarchar(10)) AND
                Level = 1 AND
                Type = 0
    END                
    END
    RETURN 0            

GO
