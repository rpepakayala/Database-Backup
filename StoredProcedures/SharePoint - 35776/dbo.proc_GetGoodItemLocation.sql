/****** Object:  StoredProcedure [dbo].[proc_GetGoodItemLocation]    Script Date: 5/15/2018 12:12:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetGoodItemLocation
(
    @ItemType           tinyint,
    @SiteId             uniqueidentifier,
    @DirName            nvarchar(256),
    @LeafName           nvarchar(128),
    @Location           nvarchar(255),
    @NewLocation        nvarchar(255) OUTPUT
)
AS
    SET NOCOUNT ON
    SET @NewLocation = @Location
    IF (@ItemType = 4)
        BEGIN
            DECLARE @ListId uniqueidentifier
            SELECT TOP 1
                @ListId = Docs.ListId
            FROM
                Docs
            WHERE
                @SiteId = Docs.SiteId AND
                @DirName = Docs.DirName AND
                @LeafName = Docs.LeafName
            SELECT TOP 1
                @NewLocation = CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
            FROM 
                Docs
            INNER JOIN
                Lists WITH (NOLOCK)
            ON 
                Docs.Id = Lists.tp_RootFolder AND
                Docs.WebId = Lists.tp_WebId
            WHERE
                Lists.tp_ID = @ListId
        END
    ELSE  IF (@ItemType = 3 OR @ItemType = 1)
        BEGIN
                SET @NewLocation = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END
        END
    ELSE IF (@ItemType = 6)
        BEGIN
            SELECT TOP 1
                @NewLocation = Webs.FullUrl
            FROM 
                Docs
            INNER JOIN
                Webs WITH (NOLOCK)
            ON
                Webs.SiteId = Docs.SiteId AND        
                Webs.Id = Docs.WebId 
            WHERE
                @SiteId = Docs.SiteId AND
                @DirName = Docs.DirName AND
                @LeafName = Docs.LeafName
        END
    RETURN 0

GO
