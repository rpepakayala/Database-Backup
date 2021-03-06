/****** Object:  StoredProcedure [dbo].[proc_DTClearRelationshipFromParent]    Script Date: 5/15/2018 12:11:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DTClearRelationshipFromParent(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @ParentLeafName nvarchar(128)
)
AS
    SET NOCOUNT ON
    DECLARE @FullParentUrl nvarchar(260)
    SET @FullParentUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @ParentLeafName WHEN (DATALENGTH(@ParentLeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @ParentLeafName END
    UPDATE
        Docs
    SET
        Docs.ParentVersion = NULL,
        Docs.TransformerId = NULL,
        Docs.ParentLeafName = NULL
    FROM 
        Docs INNER JOIN Deps WITH(UPDLOCK)
    ON
        Docs.SiteId = Deps.SiteId AND
        Docs.DirName = CASE WHEN (CHARINDEX(N'/', REVERSE(Deps.FullUrl)) > 0) THEN LEFT(Deps.FullUrl, DATALENGTH(Deps.FullUrl)/2 - CHARINDEX(N'/', REVERSE(Deps.FullUrl) COLLATE Latin1_General_BIN)) ELSE N'' END AND
        Docs.LeafName = CASE WHEN (CHARINDEX(N'/', REVERSE(Deps.FullUrl) COLLATE Latin1_General_BIN) > 0) THEN RIGHT(Deps.FullUrl, CHARINDEX(N'/', REVERSE(Deps.FullUrl) COLLATE Latin1_General_BIN) - 1) ELSE Deps.FullUrl END
    WHERE
        Deps.SiteId = @SiteId AND
        Deps.DepType = 8 AND
        Deps.DepDesc = @FullParentUrl AND
        Deps.DeleteTransactionId = 0x
    DELETE FROM
        Deps
    WHERE
        SiteId = @SiteId AND
        DepDesc = @FullParentUrl AND
        DepType = 8

GO
