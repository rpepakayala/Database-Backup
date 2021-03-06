/****** Object:  StoredProcedure [dbo].[proc_UpdateListContentTypes]    Script Date: 5/15/2018 12:13:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_UpdateListContentTypes(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier, 
    @ListId uniqueidentifier, 
    @val ntext,
    @Version int) 
AS
    SET NOCOUNT ON
    DECLARE @TimeLastModified datetime
    SET @TimeLastModified = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    UPDATE
        Lists
    SET
        tp_ContentTypes = @val,
        tp_Version = tp_Version + 1,
        tp_Modified = @TimeLastModified
    WHERE
        tp_WebId = @WebId AND
        tp_Id = @ListId AND
        tp_Version = @Version
    IF @@ROWCOUNT = 1
    BEGIN
        EXEC proc_LogChange @SiteId, @WebId, @ListId, NULL, NULL, NULL, NULL,
            NULL, 8192, 2,
            @TimeLastModified
        EXEC proc_DirtyDocsInList @WebId, @ListId 
        EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, 0, 1
        RETURN 0
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT * FROM Lists WHERE tp_WebId = @WebId AND
            tp_Id = @ListId)
        BEGIN
            RETURN 1150
        END
        ELSE
        BEGIN
            RETURN 3
        END
    END

GO
