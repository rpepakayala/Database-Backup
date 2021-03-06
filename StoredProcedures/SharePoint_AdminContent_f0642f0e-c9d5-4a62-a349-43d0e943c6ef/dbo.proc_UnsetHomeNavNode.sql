/****** Object:  StoredProcedure [dbo].[proc_UnsetHomeNavNode]    Script Date: 5/15/2018 12:13:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UnsetHomeNavNode(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @ChangedHome bit OUTPUT
    )
AS
    SET @ChangedHome = 0
    IF EXISTS (SELECT 
        *
        FROM
            NavNodes
        INNER JOIN
            Docs
        ON
            Docs.SiteId = NavNodes.SiteId AND
            Docs.WebId = NavNodes.WebId AND
            Docs.Id = NavNodes.DocId
        WHERE
            NavNodes.SiteId = @SiteId AND
            NavNodes.WebId = @WebId AND
            NavNodes.Eid = 1000 AND
            Docs.DirName = @DirName AND
            Docs.LeafName = @LeafName)
    BEGIN
        DECLARE @EidNew int
        DECLARE @EidBase int
        EXEC proc_NavStructAllocateEidBlockWebId
            @WebId,
            1,  
            0,  
            @EidBase OUTPUT
        EXEC proc_TranslateTempEid 1, 
            @EidBase,
            NULL,
            @EidNew OUTPUT
        UPDATE
            NavNodes
        SET
            Eid = @EidNew
        WHERE
            SiteId = @SiteId AND
            WebId = @WebId AND
            Eid = 1000
        UPDATE
            NavNodes
        SET
            EidParent = @EidNew
        WHERE
            SiteId = @SiteId AND
            WebId = @WebId AND
            EidParent = 1000
        SET @ChangedHome = 1
        EXEC proc_NavStructLogChangesAndUpdateSiteChangedTime @SiteId, @WebId, NULL
    END

GO
