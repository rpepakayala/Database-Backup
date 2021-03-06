/****** Object:  StoredProcedure [dbo].[proc_LockListForDocUpdate]    Script Date: 5/15/2018 12:12:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_LockListForDocUpdate(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128)
    )
AS
    DECLARE @guidT uniqueidentifier
    DECLARE @WebId uniqueidentifier
    DECLARE @guidT2 uniqueidentifier
    SET NOCOUNT ON
    SELECT
        @guidT = ListId,
        @WebId = WebId
    FROM
        Docs WITH(NOLOCK)
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName
    IF @guidT IS NOT NULL
    BEGIN
        SELECT
            @guidT2 = tp_Id
        FROM
            Lists WITH(UPDLOCK)
        WHERE
            tp_WebId = @WebId AND
            tp_Id = @guidT
    END
    RETURN 0

GO
