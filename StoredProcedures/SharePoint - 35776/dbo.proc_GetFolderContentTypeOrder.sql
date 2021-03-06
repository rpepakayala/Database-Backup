/****** Object:  StoredProcedure [dbo].[proc_GetFolderContentTypeOrder]    Script Date: 5/15/2018 12:12:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetFolderContentTypeOrder(
    @SiteId uniqueidentifier,
    @CurrentFolderUrl nvarchar(260))
AS
    SET NOCOUNT ON
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    EXEC proc_SplitUrl
        @CurrentFolderUrl,
        @DirName OUTPUT,
        @LeafName OUTPUT
    DECLARE @CtoOffset int
    SELECT
        @CtoOffset = CtoOffset
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName
    IF @@ROWCOUNT = 0
    BEGIN
        SELECT
            N'',
            NULL
        RETURN 87
    END
    ELSE IF @CtoOffset IS NULL
    BEGIN
        SELECT
            @CurrentFolderUrl,
            NULL
        RETURN 0
    END
    ELSE
    BEGIN
        DECLARE @ParentFolderUrl nvarchar(260)
        SET @ParentFolderUrl = SUBSTRING(@CurrentFolderUrl, 1, @CtoOffset)
        EXEC proc_SplitUrl
            @ParentFolderUrl,
            @DirName OUTPUT,
            @LeafName OUTPUT
        SELECT
            @CurrentFolderUrl,
            MetaInfo
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName
        RETURN 0
    END

GO
