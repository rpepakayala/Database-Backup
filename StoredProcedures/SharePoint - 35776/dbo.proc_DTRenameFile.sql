/****** Object:  StoredProcedure [dbo].[proc_DTRenameFile]    Script Date: 5/15/2018 12:11:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DTRenameFile(
    @SiteId uniqueidentifier,
    @OldFullUrl nvarchar(260),
    @NewFullUrl nvarchar(260),
    @DirName nvarchar(256),
    @NewUrlLeafName nvarchar(128)
)
AS
    SET NOCOUNT ON
    UPDATE
        Docs
    SET
        Docs.ParentLeafName = @NewUrlLeafName
    FROM 
        Docs INNER JOIN Deps
    ON
        Docs.SiteId = Deps.SiteId AND
        Docs.DirName = CASE WHEN (CHARINDEX(N'/', REVERSE(Deps.FullUrl)) > 0) THEN LEFT(Deps.FullUrl, DATALENGTH(Deps.FullUrl)/2 - CHARINDEX(N'/', REVERSE(Deps.FullUrl) COLLATE Latin1_General_BIN)) ELSE N'' END AND
        Docs.LeafName = CASE WHEN (CHARINDEX(N'/', REVERSE(Deps.FullUrl) COLLATE Latin1_General_BIN) > 0) THEN RIGHT(Deps.FullUrl, CHARINDEX(N'/', REVERSE(Deps.FullUrl) COLLATE Latin1_General_BIN) - 1) ELSE Deps.FullUrl END
    WHERE
        Deps.SiteId = @SiteId AND
        Deps.DepType = 8 AND
        Deps.DepDesc = @OldFullUrl AND
        Deps.DeleteTransactionId = 0x

GO
