/****** Object:  StoredProcedure [dbo].[proc_DeactivateContentTypeInScope]    Script Date: 5/15/2018 12:12:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeactivateContentTypeInScope(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @UserId int,
    @Class tinyint,
    @Scope nvarchar(256),
    @ContentTypeId tContentTypeId,
    @IsDeactivatingFeature tinyint = 0)
AS
    SET NOCOUNT ON
    DECLARE @Ret int
    DECLARE @ResourceDir nvarchar(128)
    DECLARE @ScopeDir nvarchar(256)
    DECLARE @ResourceUrl nvarchar(260)
    BEGIN TRAN
    DECLARE @cUsage int
    SET @cUsage = 0
    IF (@IsDeactivatingFeature <> 2)
    BEGIN
        EXEC @cUsage = proc_CountContentTypeInUse @SiteId, @ContentTypeId
        IF (@cUsage > 0)
        BEGIN
            SET @Ret = 4307
            GOTO cleanup
        END
    END
    IF (@IsDeactivatingFeature = 0)
    BEGIN
        SELECT IsFromFeature
        FROM
            ContentTypes
        WHERE
            ContentTypes.SiteId = @SiteId AND
            ContentTypes.Class = @Class AND
            ContentTypes.Scope = @Scope AND
            ContentTypes.ContentTypeId = @ContentTypeId AND
            IsFromFeature = 1
        IF (@@ROWCOUNT <> 0)
        BEGIN
            SET @Ret = 6009
            GOTO cleanup
        END
    END
    IF (@IsDeactivatingFeature <> 2)
    BEGIN
    DELETE FROM
        ContentTypeUsage
    WHERE
        SiteId = @SiteId AND
        ContentTypeId = @ContentTypeId AND
        IsFieldId = 1
    END
    IF @WebId IS NOT NULL
    BEGIN
        SElECT
            @ScopeDir = Scope,
            @ResourceDir = N'_cts/' + ResourceDir
        FROM
            ContentTypes
        WHERE
            ContentTypes.SiteId = @SiteId AND
            ContentTypes.Class = @Class AND
            ContentTypes.Scope = @Scope AND
            ContentTypes.ContentTypeId = @ContentTypeId
        IF (@@RowCount <> 0)
        BEGIN
            SET @ResourceUrl = CASE WHEN (DATALENGTH(@ScopeDir) = 0) THEN @ResourceDir WHEN (DATALENGTH(@ResourceDir) = 0) THEN @ScopeDir ELSE @ScopeDir + N'/' + @ResourceDir END        
            EXEC proc_DeleteUrl @SiteId, @WebId, @ResourceUrl, @UserId
        END
    END
    DELETE FROM
        ContentTypes
    WHERE
        ContentTypes.SiteId = @SiteId AND
        ContentTypes.Class = @Class AND
        ContentTypes.Scope = @Scope AND
        ContentTypes.ContentTypeId = @ContentTypeId
    IF (@@ROWCOUNT = 0 OR @@ERROR <> 0)
    BEGIN
        SET @Ret = 2
        GOTO cleanup
    END
    EXEC proc_LogContentTypeChange @SiteId, NULL, @Class, @Scope,
        @ContentTypeId, 16384
    EXEC proc_UpdateDiskUsed @SiteId
    SET @Ret = 0
cleanup:
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Ret

GO
