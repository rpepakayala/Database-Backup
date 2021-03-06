/****** Object:  StoredProcedure [dbo].[proc_UpdateContentTypeInScope]    Script Date: 5/15/2018 12:13:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateContentTypeInScope(
    @SiteId uniqueidentifier,
    @Class tinyint,
    @Scope nvarchar(256),
    @ContentTypeId tContentTypeId,
    @Definition ntext,
    @Version int
    )
AS
    SET NOCOUNT ON
    DECLARE @QuotaStatus int,
        @cbDelta int
    SELECT @QuotaStatus = dbo.fn_IsOverQuotaOrWriteLocked(@SiteId)
    IF (@QuotaStatus = 1)
    BEGIN
        RETURN 1816
    END
    ELSE IF (@QuotaStatus > 1)
    BEGIN
        RETURN 212
    END
    SELECT
        @cbDelta = ContentTypes.Size
    FROM
        ContentTypes
    WHERE
        ContentTypes.SiteId = @SiteId AND
        ContentTypes.Class = @Class AND
        ContentTypes.Scope = @Scope AND
        ContentTypes.ContentTypeId = @ContentTypeId  
    SET @cbDelta = ISNULL(DATALENGTH(@Definition), 16) - @cbDelta
    UPDATE
        ContentTypes
    SET
        ContentTypes.Definition = @Definition,
        ContentTypes.Size = ContentTypes.Size + @cbDelta,
        ContentTypes.Version = @Version + 1
    WHERE
        ContentTypes.SiteId = @SiteId AND
        ContentTypes.Class = @Class AND
        ContentTypes.Scope = @Scope AND
        ContentTypes.ContentTypeId = @ContentTypeId AND
        ContentTypes.Version = @Version
    IF (@@ROWCOUNT = 0 OR @@ERROR <> 0)
    BEGIN
        IF EXISTS (
            SELECT
                Version
            FROM
                ContentTypes
            WHERE
                ContentTypes.SiteId = @SiteId AND
                ContentTypes.Class = @Class AND
                ContentTypes.Scope = @Scope AND
                ContentTypes.ContentTypeId = @ContentTypeId AND
                ContentTypes.Version != @Version
            )
        BEGIN
            RETURN 1150
        END        
        RETURN 2
    END
    EXEC proc_LogContentTypeChange @SiteId, NULL, @Class, @Scope,
        @ContentTypeId, 8192
    EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, @cbDelta, 0
    RETURN 0

GO
