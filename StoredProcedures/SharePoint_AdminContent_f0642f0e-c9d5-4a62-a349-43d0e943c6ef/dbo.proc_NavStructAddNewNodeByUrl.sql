/****** Object:  StoredProcedure [dbo].[proc_NavStructAddNewNodeByUrl]    Script Date: 5/15/2018 12:12:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_NavStructAddNewNodeByUrl(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @Eid int,
    @EidParent int,
    @EidPrevSib int,
    @ElementType tinyint,
    @Url nvarchar(260),
    @Name nvarchar(256),
    @NodeMetainfo image,
    @IgnoreIfExists bit,
    @NonNavPage bit,
    @NavSequence bit,
    @DateLastModified datetime,
    @EidBase int,
    @@EidHome int OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @ret int
    DECLARE @DocId uniqueidentifier
    IF @IgnoreIfExists = 1
    BEGIN
        IF EXISTS (
            SELECT *
            FROM
                NavNodes
            WHERE
                SiteId = @SiteId AND
                WebId = @WebId AND
                Eid = @Eid)
        BEGIN
            EXEC @ret = proc_GetWebNavStructNodeByIds @SiteId, @WebId, @Eid
            RETURN @ret
        END
    END
    IF @NavSequence = 0 AND @ElementType <> 1 
    BEGIN
        DECLARE @DirName nvarchar(256)
        DECLARE @LeafName nvarchar(128)
        EXEC proc_SplitUrl @Url, @DirName OUTPUT, @LeafName OUTPUT
        SELECT
            @DocId = Id
        FROM
            Docs
        WHERE
            SiteId = @SiteId AND
            DirName = @DirName AND
            LeafName = @LeafName AND
            Level = 1
        IF @DocId IS NULL
        BEGIN
            IF EXISTS (
                SELECT Id
                FROM
                    Docs
                WHERE
                    SiteId = @SiteId AND
                    DirName = @DirName AND
                    LeafName = @LeafName)
            BEGIN
                RETURN 10008
            END
            ELSE
            BEGIN
                RETURN 10007
            END
        END
        SET @Url = NULL
    END
    EXEC @ret = proc_NavStructAddNewNode @SiteId, @WebId,
        @Eid, @EidParent, @EidPrevSib, @ElementType, @Url, @DocId, @Name,
        @NodeMetainfo, @NonNavPage, @NavSequence, @DateLastModified, @EidBase,
        @@EidHome OUTPUT, @SelectNewNode = 1
    RETURN @ret

GO
