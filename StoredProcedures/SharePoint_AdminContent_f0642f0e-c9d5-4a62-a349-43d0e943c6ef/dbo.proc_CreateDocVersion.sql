/****** Object:  StoredProcedure [dbo].[proc_CreateDocVersion]    Script Date: 5/15/2018 12:12:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_CreateDocVersion(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @ListId uniqueidentifier,
    @ItemId int,
    @Level tinyint)
AS
    INSERT INTO DocVersions (
        SiteId,
        Id,
        Version,
        TimeCreated,
        MetaInfoSize,
        Size,
        Content,
        MetaInfo,
        DocFlags,
        VirusVendorID,
        VirusStatus,
        VirusInfo,
        CheckinComment,
        Level,
        DraftOwnerId)
    SELECT
        Docs.SiteId,
        Docs.Id,
        Docs.UIVersion,
        TimeLastModified,
        Docs.MetaInfoSize,
        COALESCE(DocStreams.Size, Docs.Size),
        DocStreams.Content,
        Docs.MetaInfo,
        Docs.DocFlags & ~32 & ~512,
        Docs.VirusVendorID,
        Docs.VirusStatus,
        Docs.VirusInfo,
        Docs.CheckinComment,
        @Level,
        DraftOwnerId
    FROM
        Docs LEFT OUTER JOIN DocStreams
    ON
        Docs.SiteId = DocStreams.SiteId AND
        Docs.ParentId = DocStreams.ParentId AND
        Docs.Id = DocStreams.Id AND
        Docs.Level = DocStreams.Level
    WHERE
        Docs.SiteId = @SiteId AND
        Docs.DirName = @DirName AND
        Docs.LeafName = @LeafName AND 
        Docs.Level = @Level    
    IF (@ListId IS NOT NULL AND @ItemId IS NOT NULL)
        EXEC proc_CreateItemVersion @ListId, @ItemId, @Level

GO
