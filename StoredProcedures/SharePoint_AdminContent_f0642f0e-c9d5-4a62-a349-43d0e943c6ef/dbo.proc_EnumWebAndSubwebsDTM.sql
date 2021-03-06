/****** Object:  StoredProcedure [dbo].[proc_EnumWebAndSubwebsDTM]    Script Date: 5/15/2018 12:12:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_EnumWebAndSubwebsDTM(
    @WebId uniqueidentifier)
AS
    SELECT
        Webs.Id,
        N'/' + Webs.FullUrl AS FullUrl,
        Webs.LastMetadataChange,
        (SELECT MAX(tp_Modified) FROM Lists WHERE
            Lists.tp_WebId = Webs.Id) AS ListsMaxModified,
        (SELECT MAX(tp_LastSecurityChange) FROM Lists WHERE
            Lists.tp_WebId = Webs.Id) AS ListsMaxLastSecurityChange
    FROM
        Webs
    WHERE
        Id = @WebId OR
        ParentWebId = @WebId
    IF @@ROWCOUNT > 0
        RETURN 0
    ELSE
        RETURN 3

GO
