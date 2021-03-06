/****** Object:  StoredProcedure [dbo].[proc_DeplAddWeb]    Script Date: 5/15/2018 12:11:53 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplAddWeb(
    @SiteId uniqueidentifier,
    @Id uniqueidentifier,
    @Url nvarchar(260),
    @IncludeDescendants tinyint,
    @IsSelected tinyint)
AS
    SET NOCOUNT ON
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    IF @Url IS NOT NULL
        EXEC proc_SplitUrl @Url,
                           @DirName OUTPUT,
                           @LeafName OUTPUT
    ELSE
        SELECT
            @DirName = DirName,
            @LeafName = LeafName
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            WebId = @Id AND
            Type = 2
    IF EXISTS (
            SELECT 1 FROM #ExportObjects
            WHERE
                DirName = @DirName AND
                LeafName = @LeafName AND
                Type = 1)
        RETURN 0
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        DirName,
        LeafName,
        ParentId,
        ParentWebId,
        IncludeDescendants,
        FullUrl,
        IsSelected)
    SELECT
        Docs.WebId,
        1,
        0,
        @DirName,
        @LeafName,
        Docs.ParentId,
        Docs.WebId,
        @IncludeDescendants,
        CASE
            WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName
            WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName
            ELSE @DirName + N'/' + @LeafName
        END,
        @IsSelected
    FROM
        Docs
    INNER JOIN
        Webs
    ON
        Webs.Id = Docs.WebId
    WHERE
        Docs.SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        Type = 2 AND
        Webs.ProductVersion >= 3
    IF @@ROWCOUNT = 0
        RETURN 2
    ELSE
        RETURN 0

GO
