/****** Object:  StoredProcedure [dbo].[proc_DTSetRelationship]    Script Date: 5/15/2018 12:11:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DTSetRelationship(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @ChildDocLevel tinyint,
    @ChildLeafName nvarchar(128),
    @ParentDocLevel tinyint,
    @ParentLeafName nvarchar(128),
    @TransformerId uniqueidentifier,
    @ParentVersion int
)
AS
    SET NOCOUNT ON
    UPDATE Docs
    SET
        TransformerId = @TransformerId,
        ParentLeafName = @ParentLeafName,
        ParentVersion = @ParentVersion
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @ChildLeafName AND
        Level = @ChildDocLevel
    UPDATE Docs
    SET
        DocFlags = DocFlags | 1024
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @ParentLeafName AND
        Level = @ParentDocLevel
    DECLARE @FullChildUrl nvarchar(260)
    DECLARE @FullParentUrl nvarchar(260)
    SET @FullChildUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @ChildLeafName WHEN (DATALENGTH(@ChildLeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @ChildLeafName END
    SET @FullParentUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @ParentLeafName WHEN (DATALENGTH(@ParentLeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @ParentLeafName END
    EXEC proc_AddDependency @SiteId,
                            @FullChildUrl,
                            @ChildDocLevel,
                            8,
                            @FullParentUrl

GO
