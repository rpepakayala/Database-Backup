/****** Object:  StoredProcedure [dbo].[proc_GetUserStorageInfo]    Script Date: 5/15/2018 12:12:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetUserStorageInfo(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128))
AS
    SET NOCOUNT ON
    DECLARE @DocId uniqueidentifier
    DECLARE @DocWebId uniqueidentifier
    DECLARE @Ret int
    SELECT TOP 1
        @DocId = Id,
        @DocWebId = WebId
    FROM
        dbo.Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName
    IF ((@DocId IS NULL) OR (@DocWebId <> @WebId))
    BEGIN
        RETURN 2    
    END
    EXEC @Ret = proc_SizeOfPersonalizationsPerUser @SiteId, @DocId
    IF (@@ERROR <> 0 OR @Ret <> 0)
    BEGIN
        IF (@Ret = 0)
            SET @Ret = -2147467259
    END
    RETURN @Ret

GO
