/****** Object:  StoredProcedure [dbo].[proc_UpdateListFields]    Script Date: 5/15/2018 12:12:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_UpdateListFields(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier, 
    @ListId uniqueidentifier, 
    @Fields ntext,
    @ContentTypes ntext,
    @Version int,
    @FieldSchemaModified bit = 1,
    @FieldIdDeleted uniqueidentifier = NULL,
    @VersionDelta int = 1)
AS
    SET NOCOUNT ON
    DECLARE @TimeLastModified datetime
    SET @TimeLastModified = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    UPDATE
        Lists
    SET
        tp_Fields = @Fields,
        tp_ContentTypes = CASE WHEN @ContentTypes IS NOT NULL THEN @ContentTypes ELSE tp_ContentTypes END,
        tp_Flags = CASE WHEN @FieldSchemaModified = 0
            THEN tp_Flags
            ELSE tp_Flags | 0x800000 END,
        tp_Version = tp_Version + @VersionDelta,
        tp_Modified = @TimeLastModified
    WHERE
        tp_WebId = @WebId AND
        tp_Id = @ListId AND
        tp_Version = @Version
    IF @@ROWCOUNT = 1
    BEGIN
        EXEC proc_LogChange @SiteId, @WebId, @ListId, NULL, NULL, @FieldIdDeleted, NULL,
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
