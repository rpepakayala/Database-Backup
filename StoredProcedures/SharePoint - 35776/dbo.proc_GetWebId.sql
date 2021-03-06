/****** Object:  StoredProcedure [dbo].[proc_GetWebId]    Script Date: 5/15/2018 12:12:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetWebId(
    @SiteId uniqueidentifier,
    @WebUrl nvarchar(256),
    @@WebId uniqueidentifier OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    EXEC proc_SplitUrl @WebUrl, @DirName OUTPUT, @LeafName OUTPUT
    SELECT
        @@WebId = WebId
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName AND
        Type = 2

GO
