/****** Object:  StoredProcedure [dbo].[proc_DeplAddWebToIncremental]    Script Date: 5/15/2018 12:12:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplAddWebToIncremental(
    @SiteId uniqueidentifier,
    @Id uniqueidentifier,
    @Url nvarchar(260),
    @IncludeDescendants tinyint,
    @ChangeTimeStart datetime,
    @ChangeNumberStart int)
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
            SELECT 1 FROM #IncrementalSearchScope
            WHERE
                DirName = @DirName AND
                LeafName = @LeafName AND
                Type = 1)
        RETURN 0
    INSERT INTO #IncrementalSearchScope(
        Id,
        Type,
        Level,
        DirName,
        LeafName,
        ParentId,
        ParentWebId,
        IncludeDescendants,
        FullUrl,
        ChangeTime,
        ChangeNumber,
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
        @ChangeTimeStart,
        @ChangeNumberStart,
        1
    FROM
        Docs
    INNER JOIN
        Webs
    ON
        Webs.Id = Docs.WebId
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @DirName AND
        Docs.LeafName = @LeafName AND
        Docs.Type = 2 AND
        Webs.ProductVersion >= 3
    IF @@ROWCOUNT = 0
        RETURN 2
    ELSE
        RETURN 0

GO
