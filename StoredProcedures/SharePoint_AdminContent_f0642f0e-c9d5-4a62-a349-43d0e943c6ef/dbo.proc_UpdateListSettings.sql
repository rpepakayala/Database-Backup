/****** Object:  StoredProcedure [dbo].[proc_UpdateListSettings]    Script Date: 5/15/2018 12:13:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateListSettings(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @BaseType int,
    @ServerTemplate int,
    @Title nvarchar(255),
    @ReadSecurity int,
    @WriteSecurity int,
    @NewDefaultView uniqueidentifier,
    @Description ntext,
    @TemplateDirName nvarchar(256),
    @TemplateLeafName nvarchar(128),
    @Fields ntext,
    @Direction int,
    @EventSinkAssembly nvarchar(255),
    @EventSinkClass nvarchar(255),
    @EventSinkData nvarchar(255),
    @Flags bigint,
    @ImageUrl nvarchar(255),
    @ThumbnailSize int,
    @WebImageWidth int,
    @WebImageHeight int,  
    @Version int,
    @ConvertToGlobalMtgDataList bit,
    @EmailInsertsFolder nvarchar(255),
    @EmailInsertsLastSyncTime nvarchar(50),
    @EmailAlias nvarchar(128),
    @SendToLocation nvarchar(512),
    @NavBarEid int,
    @AddOrRemoveFromNavBar bit,
    @UseRootFolderForNav bit,
    @MajorVersionCount int,
    @MajorMinorVersionCount int,
    @WorkFlowId uniqueidentifier,
    @RemoveSystemAlerts bit)
AS
    SET NOCOUNT ON
    IF NOT EXISTS(SELECT * FROM Lists WHERE tp_WebId = @WebId AND
        tp_Id = @ListId AND 
        tp_Title = @Title)
    BEGIN
        IF EXISTS(SELECT * FROM Lists WHERE tp_WebId = @WebId AND
            tp_Id != @ListId AND 
            tp_Title = @Title)
        BEGIN
            RETURN 52
        END
    END
    BEGIN TRAN
    DECLARE @Result int
    SET @Result = 0
    DECLARE @OldFlags bigint
    IF @ConvertToGlobalMtgDataList = 1
    BEGIN
        EXEC @Result = proc_ConvertToGlobalMtgDataList
            @SiteId,
            @WebId,
            @ListId,
            @BaseType,
            @ServerTemplate
        IF @Result <> 0
        BEGIN
            GOTO cleanup
        END
    END
    IF @NewDefaultView IS NOT NULL
    BEGIN
        EXEC @Result = proc_MakeViewDefaultForList @ListId,
            @NewDefaultView
        IF @Result <> 0
        BEGIN
            GOTO cleanup
        END
    END
    DECLARE @NewTemplateId uniqueidentifier
    IF LEN(@TemplateLeafName) > 0
    BEGIN
        DECLARE @TemplateUrl nvarchar(260)
        DECLARE @TemplateListId uniqueidentifier
        DECLARE @TemplateBaseType int
        DECLARE @TemplateExcludedType int
        SET @TemplateUrl = CASE WHEN (DATALENGTH(@TemplateDirName) = 0) THEN @TemplateLeafName WHEN (DATALENGTH(@TemplateLeafName) = 0) THEN @TemplateDirName ELSE @TemplateDirName + N'/' + @TemplateLeafName END
        EXEC proc_GetContainingListOutput
            @SiteId, @WebId, @TemplateUrl,
            @TemplateListId OUTPUT, @TemplateBaseType OUTPUT,
            @TemplateExcludedType OUTPUT
        IF @TemplateListId IS NULL OR @TemplateListId <> @ListId OR
            @TemplateBaseType IS NULL OR
            @TemplateBaseType <> 1 OR
            @TemplateExcludedType IS NULL OR
            @TemplateExcludedType <> 0x01
        BEGIN
            SET @Result = 15
            GOTO cleanup
        END
        SELECT
            @NewTemplateId = Id from Docs
        WHERE
            SiteId = @SiteId AND
                DirName = @TemplateDirName AND
                LeafName = @TemplateLeafName AND
                Type = 0
        IF @NewTemplateId IS NULL
        BEGIN
            SET @Result = 15
            GOTO cleanup
        END
    END
    IF @Fields IS NOT NULL SET @Flags = @Flags | 0x800000
    IF @Flags IS NOT NULL
    BEGIN
        SELECT
            @OldFlags = tp_Flags
        FROM
            Lists WITH (UPDLOCK)
        WHERE
            tp_WebId = @WebId AND
            tp_Id = @ListId AND
            tp_Version = @Version
    END
    DECLARE @NeedNewDTM bit
    IF (@Title IS NOT NULL) OR
        (@Fields IS NOT NULL) OR
        (@Flags IS NOT NULL) OR
        (@Description IS NOT NULL)
    BEGIN
        SET @NeedNewDTM = 1
    END
    ELSE
    BEGIN
        SET @NeedNewDTM = 0
    END
    DECLARE @NeedNewLSC bit
    IF (@ReadSecurity IS NOT NULL) OR
        (@WriteSecurity IS NOT NULL)
    BEGIN
        SET @NeedNewLSC = 1
    END
    ELSE
    BEGIN
        SET @NeedNewLSC = 0
    END
    DECLARE @Now datetime
    SET @Now = dbo.fn_RoundDateToNearestSecond(GETUTCDATE())
    UPDATE
        Lists
    SET
        tp_Title = CASE WHEN @Title IS NULL THEN tp_Title ELSE @Title END,
        tp_ReadSecurity = CASE WHEN @ReadSecurity IS NULL THEN 
            tp_ReadSecurity ELSE @ReadSecurity END,
        tp_WriteSecurity = CASE WHEN @WriteSecurity IS NULL THEN
            tp_WriteSecurity ELSE @WriteSecurity END,
        tp_Description = CASE WHEN @Description IS NULL THEN
            tp_Description ELSE @Description END,
        tp_Template =
            CASE WHEN LEN(@TemplateLeafName) = 0 THEN NULL
                WHEN @NewTemplateId IS NOT NULL THEN @NewTemplateId
            ELSE tp_Template END,
        tp_Fields = CASE WHEN @Fields IS NULL THEN
            tp_Fields ELSE @Fields END,
        tp_Direction = CASE WHEN @Direction IS NULL
            THEN tp_Direction ELSE @Direction END,          
        tp_EventSinkAssembly = CASE
            WHEN @EventSinkAssembly IS NULL then tp_EventSinkAssembly
            WHEN (DATALENGTH(@EventSinkAssembly) = 0) THEN NULL
            ELSE @EventSinkAssembly END,
        tp_EventSinkClass = CASE
            WHEN @EventSinkClass IS NULL then tp_EventSinkClass
            WHEN (DATALENGTH(@EventSinkClass) = 0) THEN NULL
            ELSE @EventSinkClass END,
        tp_EventSinkData = CASE
            WHEN @EventSinkData IS NULL then tp_EventSinkData
            WHEN (DATALENGTH(@EventSinkData) = 0) THEN NULL
            ELSE @EventSinkData END,
        tp_Flags = CASE WHEN @Flags IS NULL THEN
            tp_Flags ELSE @Flags END,
        tp_ImageUrl = CASE WHEN @ImageUrl IS NULL THEN
            tp_ImageUrl ELSE @ImageUrl END,
        tp_ThumbnailSize = CASE WHEN @ThumbnailSize IS NULL THEN
            tp_ThumbnailSize ELSE @ThumbnailSize END,          
        tp_WebImageWidth = CASE WHEN @WebImageWidth IS NULL THEN
            tp_WebImageWidth ELSE @WebImageWidth END,          
        tp_WebImageHeight = CASE WHEN @WebImageHeight IS NULL THEN
            tp_WebImageHeight ELSE @WebImageHeight END,
        tp_EmailInsertsFolder = CASE WHEN @EmailInsertsFolder IS NULL THEN
            tp_EmailInsertsFolder ELSE @EmailInsertsFolder END,
        tp_EmailInsertsLastSyncTime = CASE 
            WHEN @EmailInsertsLastSyncTime IS NULL THEN 
                tp_EmailInsertsLastSyncTime
            WHEN (DATALENGTH(@EmailInsertsLastSyncTime) = 0) THEN 
                CONVERT(NVARCHAR(50), GETUTCDATE(), 121)
            ELSE @EmailInsertsLastSyncTime END,
        tp_EmailAlias = CASE WHEN @EmailAlias IS NULL THEN
            tp_EmailAlias ELSE @EmailAlias END,
        tp_Version = tp_Version + 1,
        tp_Modified = CASE WHEN (@NeedNewDTM = 1) THEN
            @Now ELSE
            tp_Modified END,
        tp_LastSecurityChange = CASE WHEN (@NeedNewLSC = 1) THEN
            @Now ELSE
            tp_LastSecurityChange END,
        tp_SendToLocation = CASE WHEN @SendToLocation IS NULL THEN
            tp_SendToLocation ELSE @SendToLocation END,
        tp_MaxMajorVersionCount  = @MajorVersionCount,
        tp_MaxMajorwithMinorVersionCount = @MajorMinorVersionCount,
        tp_DefaultWorkflowId = @WorkFlowId
    WHERE
        tp_WebId = @WebId AND
        tp_Id = @ListId AND
        tp_Version = @Version
    IF @@ROWCOUNT = 1
    BEGIN
        IF @AddOrRemoveFromNavBar = 0 
          EXEC proc_RemoveListNavNode @WebId, @ListId, @UseRootFolderForNav
        ELSE
        BEGIN
          DECLARE @AddIfNotThere bit
          SET @AddIfNotThere = ISNULL(@AddOrRemoveFromNavBar, 0)
          EXEC proc_UpdateListNavNode @WebId, @ListId,
              @NewDefaultView, @Title, @NavBarEid, @AddIfNotThere, @UseRootFolderForNav
        END
        EXEC proc_LogChange @SiteId, @WebId, @ListId, NULL, NULL, NULL, NULL,
          NULL, 8192, 2, @Now
        IF (@ReadSecurity IS NOT NULL AND @ReadSecurity = 0x00000002)
        BEGIN
            EXEC proc_LogChange @SiteId, @WebId, NULL, NULL, NULL, NULL, NULL,
                NULL, 8192, 4, NULL
            UPDATE Webs
            SET 
                Flags = Flags | 0x400
            WHERE
                Id = @WebId
        END
        IF @NeedNewDTM = 1
        BEGIN
          EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, 0, 1
        END
        IF @NeedNewLSC = 1
        BEGIN
          EXEC proc_SecUpdateSiteLevelSecurityMetadata @SiteId, 0, 0
        END
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT * FROM Lists WHERE tp_WebId = @WebId AND
            tp_Id = @ListId)
        BEGIN
            SET @Result = 1150
            GOTO cleanup
        END
        ELSE
        BEGIN
            SET @Result = 3
            GOTO cleanup
        END
    END
    IF @Title IS NOT NULL OR @ReadSecurity IS NOT NULL OR @RemoveSystemAlerts = 1
    BEGIN
        EXEC proc_UpdateSubsListSettings
            @SiteId,
            @ListId, 
            @Title,
            @ReadSecurity,
            @RemoveSystemAlerts
    END
    IF @Flags IS NOT NULL AND (@OldFlags & 0x10000 <>
        @Flags & 0x10000)
    BEGIN
        DECLARE @EmailEnabled bit
        SET @EmailEnabled = CASE WHEN @Flags & 0x10000 = 0
            THEN 0 ELSE 1 END
        EXEC proc_UpdateEmailEnabledSettings
            @SiteId,
            @WebId,
            @EmailEnabled
    END
    EXEC proc_QMChangeSiteDiskUsedAndContentTimestamp @SiteId, 0, 1
cleanup:
    IF (@Result <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Result

GO
