/****** Object:  StoredProcedure [dbo].[proc_UpdateDocBuildDependencySet]    Script Date: 5/15/2018 12:13:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateDocBuildDependencySet(
    @DocSiteId uniqueidentifier,
    @DocDirName  nvarchar(256),
    @DocLeafName nvarchar(128),
    @Level tinyint,
    @BuildDependencySet image)
AS
    SET NOCOUNT ON
    UPDATE Docs 
    SET 
        BuildDependencySet =@BuildDependencySet
    WHERE 
        SiteId = @DocSiteId AND
        DirName = @DocDirName AND
        LeafName = @DocLeafName AND
        Level = @Level
    RETURN 0

GO
