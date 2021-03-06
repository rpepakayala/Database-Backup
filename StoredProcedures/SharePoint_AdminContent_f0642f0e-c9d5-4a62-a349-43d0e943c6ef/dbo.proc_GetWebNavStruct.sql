/****** Object:  StoredProcedure [dbo].[proc_GetWebNavStruct]    Script Date: 5/15/2018 12:12:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetWebNavStruct(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @Inherited bit)
AS
    SET NOCOUNT ON
    IF @Inherited=1
    BEGIN
        SELECT
            CachedDataVersion,
            ScopeId
        FROM 
            Webs
        WHERE
             SiteId = @SiteId AND
             Id = @WebId
    END
    EXEC proc_GetWebNavAcls @SiteId, @WebId, NULL, @Inherited
    SELECT
        NavNodes.Eid,
        NavNodes.EidParent,
        NavNodes.ElementType,
        CASE
            WHEN
                NavNodes.ElementType = 1 OR
                NavNodes.NavSequence = 1
            THEN
                NavNodes.Url 
            ELSE
                CASE WHEN (DATALENGTH(Docs.DirName) = 0) THEN Docs.LeafName WHEN (DATALENGTH(Docs.LeafName) = 0) THEN Docs.DirName ELSE Docs.DirName + N'/' + Docs.LeafName END
            END,
        NavNodes.Name,
        NavNodes.NodeMetainfo,
        NavNodes.NonNavPage,
        NavNodes.NavSequence,
        NavNodes.ChildOfSequence,
        NavNodes.DateLastModified,
        CASE
            WHEN
                NavNodes.Eid = 0 OR
                NavNodes.ElementType = 1 OR
                NavNodes.NavSequence = 1
            THEN
                0x0 
            ELSE
                Docs.ScopeId
            END,
        CASE
            WHEN
                NavNodes.Eid = 0 OR
                NavNodes.ElementType = 1 OR
                NavNodes.NavSequence = 1
            THEN
                0 
            WHEN
                Docs.ListId IS NULL
            THEN
                1
            WHEN
                Docs.DocLibRowId IS NULL
            THEN
                2
            ELSE
                3
        END
    FROM
        NavNodes
    LEFT OUTER JOIN
        Docs WITH (NOLOCK)
    ON
        NavNodes.DocId = Docs.Id AND
        Docs.Level = 1
    WHERE
        NavNodes.SiteId = @SiteId AND
        NavNodes.WebId = @WebId
    ORDER BY
        NavNodes.EidParent,
        NavNodes.RankChild
    RETURN 0

GO
