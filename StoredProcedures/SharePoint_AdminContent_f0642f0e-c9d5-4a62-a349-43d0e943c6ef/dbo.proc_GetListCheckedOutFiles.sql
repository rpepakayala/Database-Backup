/****** Object:  StoredProcedure [dbo].[proc_GetListCheckedOutFiles]    Script Date: 5/15/2018 12:12:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_GetListCheckedOutFiles(
    @SiteId uniqueidentifier,
    @ListUrl nvarchar(260)
    )
AS
    SET NOCOUNT ON
    DECLARE @UrlLike nvarchar(260)
    EXEC proc_EscapeForLike @ListUrl, @UrlLike OUTPUT, 0
    SET @UrlLike = SUBSTRING(@UrlLike,2,LEN(@UrlLike)-1) + '%'
    DECLARE @Files table(
        Id uniqueidentifier,
        Level int,
        DirName nvarchar(256),
        LeafName nvarchar(128),
        DoclibRowId int,
        CheckoutUserId int,
        TimeLastModified datetime,
        Size bigint,
        DocFlags int
    )
    INSERT INTO @Files
    SELECT
        Id, 
        Level, 
        DirName, 
        LeafName, 
        DoclibRowId,
        CheckoutUserId, 
        TimeLastModified, 
        Size,
        DocFlags
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName LIKE @UrlLike AND
        Type = 0
    DELETE FROM 
        @Files
    WHERE
        Id IN (
            SELECT
                Id
            FROM 
                @Files
            WHERE
                Level != 255)
    SELECT 
        DirName,
        LeafName,
        DoclibRowId,
        CheckoutUserId,
        ISNULL(UA.tp_Title,''),
        ISNULL(UA.tp_Email,''),
        TimeLastModified,
        Size
    FROM 
        @Files F
    LEFT OUTER JOIN
        UserInfo UA
    ON
        UA.tp_SiteId = @SiteId AND 
        UA.tp_Id = CheckoutUserId
    WHERE
        F.DocFlags & 32 <> 0
    ORDER BY
        DirName, LeafName
    RETURN 0

GO
