/****** Object:  StoredProcedure [dbo].[proc_DeplAddSite]    Script Date: 5/15/2018 12:12:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeplAddSite(@SiteId uniqueidentifier)
AS
    SET NOCOUNT ON
    IF @SiteId IS NULL
        RETURN 87
    INSERT INTO #ExportObjects(
        Id,
        Type,
        Level,
        DirName,
        LeafName,
        ParentId,
        ParentWebId,
        IncludeDescendants,
        FullUrl)
    SELECT
        @SiteId,
        0,
        0,
        NULL,
        NULL,
        NULL,
        NULL,
        0,
        NULL
    RETURN 0

GO
