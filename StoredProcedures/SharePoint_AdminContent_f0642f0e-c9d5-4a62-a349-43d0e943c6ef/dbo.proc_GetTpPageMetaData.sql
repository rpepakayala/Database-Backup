/****** Object:  StoredProcedure [dbo].[proc_GetTpPageMetaData]    Script Date: 5/15/2018 12:12:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetTpPageMetaData(
    @SiteId uniqueidentifier,
    @DocId uniqueidentifier,
    @ListId uniqueidentifier,
    @WebId uniqueidentifier,
    @Collation smallint,
    @Level tinyint,
    @UserId int,
    @PrefetchListScope bit,
    @GetViewBodies bit)
AS
    SET NOCOUNT ON
    DECLARE @UserInfoListId uniqueidentifier
    DECLARE @RootWebId uniqueidentifier
    SELECT 
        @UserInfoListId = UserInfoListId,
        @RootWebId = RootWebId        
    FROM 
        Sites 
    WHERE 
        Sites.Id = @SiteId        
    DECLARE @WebScopeId uniqueidentifier
    SELECT
        @WebScopeId = ScopeId
    FROM
        Webs
    WHERE
        Id = @WebId
    SELECT
        Lists.tp_ID,
        Lists.tp_Title,
        Lists.tp_Modified,
        Lists.tp_Created,
        Lists.tp_LastDeleted,
        Lists.tp_Version,
        Lists.tp_BaseType,
        Lists.tp_FeatureId,
        Lists.tp_ServerTemplate,
        AllDocs1.DirName,        
        AllDocs1.LeafName,
        AllDocs2.DirName,        
        AllDocs2.LeafName,
        Lists.tp_ReadSecurity,
        Lists.tp_WriteSecurity,
        Lists.tp_Description,
        CASE WHEN Webs.Flags & 0x200 = 0x200 OR
                  Lists.tp_Flags & 0x200000000 = 0x200000000
        THEN
             NULL
        ELSE
             Lists.tp_Fields
        END,
        Lists.tp_Direction,
        CASE WHEN Lists.tp_ScopeId = @WebScopeId 
             THEN NULL
             ELSE Perms.AnonymousPermMask
        END,
        Lists.tp_Flags,
        Lists.tp_ThumbnailSize,
        Lists.tp_WebImageWidth,
        Lists.tp_WebImageHeight,
        Lists.tp_ImageUrl,
        Lists.tp_ItemCount,
        Lists.tp_Author,
        Lists.tp_HasInternalFGP,
        Lists.tp_ScopeId,
        CASE WHEN Lists.tp_ScopeId = @WebScopeId 
             THEN NULL
             ELSE Perms.Acl
        END,
        Lists.tp_EventSinkAssembly,
        Lists.tp_EventSinkClass,
        Lists.tp_EventSinkData,
        Lists.tp_EmailInsertsFolder,
        Lists.tp_EmailInsertsLastSyncTime,
        Lists.tp_EmailAlias,
        N'/' + Webs.FullUrl AS tp_WebFullUrl,
        Webs.Id AS tp_WebId,
        Webs.Title AS tp_WebTitle,
        Webs.WebTemplate AS tp_WebTemplate,
        Webs.Language AS tp_WebLanguage,
        Webs.Collation AS tp_WebCollation,
        Lists.tp_SendToLocation,
        ISNULL(Lists.tp_MaxMajorVersionCount, 0),
        ISNULL(Lists.tp_MaxMajorwithMinorVersionCount, 0),                                      
        Lists.tp_MaxRowOrdinal,
        Lists.tp_ListDataDirty,
        Lists.tp_DefaultWorkflowId,
        CASE WHEN Webs.Flags & 0x200 = 0x200 OR
                  Lists.tp_Flags & 0x200000000 = 0x200000000
        THEN
            NULL
        ELSE
            Lists.tp_ContentTypes
        END,
        Lists.tp_Subscribed
    FROM
    	fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId, @ListId, @UserInfoListId, @UserId, @Level) AS WebPartList
    INNER JOIN
        Lists
    ON
        Lists.tp_ID = WebPartList.tp_ListId AND
        Lists.tp_WebId = WebPartList.tp_WebId
    INNER JOIN
        Perms
    ON
        Perms.SiteId = @SiteId AND
        Perms.ScopeId = Lists.tp_ScopeId
    INNER JOIN
        Webs
    ON
        Webs.Id = Lists.tp_WebId
    INNER JOIN
        AllDocs AS AllDocs1
    ON
        AllDocs1.Id = Lists.tp_RootFolder AND
        AllDocs1.Level = 1
    LEFT OUTER JOIN
        AllDocs AS AllDocs2
    ON
        AllDocs2.Id = Lists.tp_Template AND
        AllDocs2.Level = 1
    ORDER BY
        Lists.tp_WebId,
        Lists.tp_ID
    OPTION (FORCE ORDER)
    IF @@ROWCOUNT = 0
    BEGIN
        RETURN 0
    END
    SELECT
        Id, Name, SiteId, WebId, HostId, HostType, ItemId, DirName, LeafName, Type, SequenceNumber, Assembly, Class, Data, Filter, SourceId, SourceType, Credential, ContextType, ContextEventType, ContextId, ContextObjectId, ContextCollectionId
    FROM
        EventReceivers
    INNER JOIN
    	fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId, @ListId, @UserInfoListId, @UserId, @Level) AS WebPartList
    ON
        SiteId = @SiteId AND
    	WebId = WebPartList.tp_WebId AND
    	HostId = WebPartList.tp_ListId
    WHERE
        SiteId = @SiteId AND
        HostType = 2
    ORDER BY
        SiteId, WebId, HostId, Type, HostType, SequenceNumber, Assembly
    IF (@PrefetchListScope = 1)
    BEGIN
        DECLARE @HasFGPLists int
        DECLARE @HasInternalFGPLists int
        SELECT
            @HasFGPLists = SUM(CASE WHEN tp_HasFGP <> 0 THEN 1 ELSE 0 END),
            @HasInternalFGPLists = SUM(CASE WHEN tp_HasInternalFGP <> 0 THEN 1 ELSE 0 END)
        FROM
            fn_GetPageListIdTable(@SiteId, @DocId, @RootWebId,
            @WebId, @ListId, @UserInfoListId, @UserId, @Level)
        AS FGPLists
        IF (@HasInternalFGPLists > 0)
        BEGIN
            EXEC dbo.proc_GetTpPageFGPInfo @SiteId, @DocId, @RootWebId,
                 @WebId, @ListId, @UserInfoListId, @UserId, @Level
        END
        ELSE
        BEGIN
            IF @HasFGPLists = 0
            BEGIN
               SELECT 
                   tp_ListId AS ListId,
                   0x0 AS ScopeId,
                   NULL AS Acl,
                   0 AS AnonymousPermMask
               FROM 
                   fn_GetPageListIdTable(@SiteId, @DocId, @RootWebId,
                   @WebId, @ListId, @UserInfoListId, @UserId, @Level)
               AS WebPartList
               ORDER BY
                   ListId
            END
            ELSE
            BEGIN
               SELECT 
                   WebPartList.tp_ListId AS ListId,
                   COALESCE(WebPartList.tp_ScopeId, 0x0) AS ScopeId,
                   Perms.Acl AS Acl,
                   COALESCE(Perms.AnonymousPermMask, 0) AS AnonymousPermMask
               FROM 
                   fn_GetPageListIdTable(@SiteId, @DocId, @RootWebId,
                   @WebId, @ListId, @UserInfoListId, @UserId, @Level)
               AS WebPartList
               LEFT OUTER JOIN
                   Perms
               ON
                   Perms.SiteId = @SiteId AND
                   Perms.ScopeId = WebPartList.tp_ScopeId
               ORDER BY
                   ListId
            END
        END
    END
    DECLARE @CollationName nvarchar(32)
    IF (@Collation IS NOT NULL AND @Collation <> 25)
    BEGIN
	    SELECT
	    	@CollationName = CollationName
	   	FROM
	   		CollationNames
	   	WHERE
	   		Collation = @Collation
	END	   		
    IF (@CollationName = N'Latin1_General_CI_AS')    
	BEGIN
       IF @GetViewBodies = 1
       BEGIN
	    SELECT
	        WebParts.tp_ListID,
	        WebParts.tp_Type,
	        WebParts.tp_ID,
	        WebParts.tp_Flags,
	        WebParts.tp_DisplayName,
	        CASE WHEN AllDocs.DirName = N'' THEN
	            AllDocs.LeafName
	        ELSE
	            AllDocs.DirName + N'/' + AllDocs.LeafName END
	        AS
	            tp_PageUrl,
	        WebParts.tp_BaseViewId
,
             WebParts.tp_View AS tp_ViewBody,
	        WebParts.tp_Level,
	        WebParts.tp_ContentTypeId
	    FROM
            fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId,
	        @ListId, @UserInfoListId, @UserId, @Level) PageLists
        INNER LOOP JOIN
            WebParts 
        ON
            PageLists.tp_ListId = WebParts.tp_ListId AND
            (WebParts.tp_UserId IS NULL OR
             WebParts.tp_UserId = @UserId) AND
             WebParts.tp_Deleted = 0
        INNER JOIN
            AllDocs
        ON
            AllDocs.Id = WebParts.tp_PageUrlId AND
            AllDocs.Level = WebParts.tp_Level
        WHERE
            ((AllDocs.Id = @DocId AND AllDocs.Level = @Level) OR
             (AllDocs.Id <> @DocId AND AllDocs.Level = 1))
	    ORDER BY
	        WebParts.tp_ListId,
	        WebParts.tp_DisplayName COLLATE Latin1_General_CI_AS,
        	WebParts.tp_CreationTime
        OPTION (FORCE ORDER)
       END
       ELSE
       BEGIN
	    SELECT
	        WebParts.tp_ListID,
	        WebParts.tp_Type,
	        WebParts.tp_ID,
	        WebParts.tp_Flags,
	        WebParts.tp_DisplayName,
	        CASE WHEN AllDocs.DirName = N'' THEN
	            AllDocs.LeafName
	        ELSE
	            AllDocs.DirName + N'/' + AllDocs.LeafName END
	        AS
	            tp_PageUrl,
	        WebParts.tp_BaseViewId
,
             NULL AS tp_ViewBody,
	        WebParts.tp_Level,
	        WebParts.tp_ContentTypeId
	    FROM
            fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId,
	        @ListId, @UserInfoListId, @UserId, @Level) PageLists
        INNER LOOP JOIN
            WebParts 
        ON
            PageLists.tp_ListId = WebParts.tp_ListId AND
            (WebParts.tp_UserId IS NULL OR
             WebParts.tp_UserId = @UserId) AND
             WebParts.tp_Deleted = 0
        INNER JOIN
            AllDocs
        ON
            AllDocs.Id = WebParts.tp_PageUrlId AND
            AllDocs.Level = WebParts.tp_Level
        WHERE
            ((AllDocs.Id = @DocId AND AllDocs.Level = @Level) OR
             (AllDocs.Id <> @DocId AND AllDocs.Level = 1))
	    ORDER BY
	        WebParts.tp_ListId,
	        WebParts.tp_DisplayName COLLATE Latin1_General_CI_AS,
        	WebParts.tp_CreationTime
        OPTION (FORCE ORDER)
       END
	END
	ELSE 
    IF (@CollationName = N'Japanese_CI_AS')    
	BEGIN
       IF @GetViewBodies = 1
       BEGIN
	    SELECT
	        WebParts.tp_ListID,
	        WebParts.tp_Type,
	        WebParts.tp_ID,
	        WebParts.tp_Flags,
	        WebParts.tp_DisplayName,
	        CASE WHEN AllDocs.DirName = N'' THEN
	            AllDocs.LeafName
	        ELSE
	            AllDocs.DirName + N'/' + AllDocs.LeafName END
	        AS
	            tp_PageUrl,
	        WebParts.tp_BaseViewId
,
             WebParts.tp_View AS tp_ViewBody,
	        WebParts.tp_Level,
	        WebParts.tp_ContentTypeId
	    FROM
            fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId,
	        @ListId, @UserInfoListId, @UserId, @Level) PageLists
        INNER LOOP JOIN
            WebParts 
        ON
            PageLists.tp_ListId = WebParts.tp_ListId AND
            (WebParts.tp_UserId IS NULL OR
             WebParts.tp_UserId = @UserId) AND
             WebParts.tp_Deleted = 0
        INNER JOIN
            AllDocs
        ON
            AllDocs.Id = WebParts.tp_PageUrlId AND
            AllDocs.Level = WebParts.tp_Level
        WHERE
            ((AllDocs.Id = @DocId AND AllDocs.Level = @Level) OR
             (AllDocs.Id <> @DocId AND AllDocs.Level = 1))
	    ORDER BY
	        WebParts.tp_ListId,
	        WebParts.tp_DisplayName COLLATE Japanese_CI_AS,
        	WebParts.tp_CreationTime
        OPTION (FORCE ORDER)
       END
       ELSE
       BEGIN
	    SELECT
	        WebParts.tp_ListID,
	        WebParts.tp_Type,
	        WebParts.tp_ID,
	        WebParts.tp_Flags,
	        WebParts.tp_DisplayName,
	        CASE WHEN AllDocs.DirName = N'' THEN
	            AllDocs.LeafName
	        ELSE
	            AllDocs.DirName + N'/' + AllDocs.LeafName END
	        AS
	            tp_PageUrl,
	        WebParts.tp_BaseViewId
,
             NULL AS tp_ViewBody,
	        WebParts.tp_Level,
	        WebParts.tp_ContentTypeId
	    FROM
            fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId,
	        @ListId, @UserInfoListId, @UserId, @Level) PageLists
        INNER LOOP JOIN
            WebParts 
        ON
            PageLists.tp_ListId = WebParts.tp_ListId AND
            (WebParts.tp_UserId IS NULL OR
             WebParts.tp_UserId = @UserId) AND
             WebParts.tp_Deleted = 0
        INNER JOIN
            AllDocs
        ON
            AllDocs.Id = WebParts.tp_PageUrlId AND
            AllDocs.Level = WebParts.tp_Level
        WHERE
            ((AllDocs.Id = @DocId AND AllDocs.Level = @Level) OR
             (AllDocs.Id <> @DocId AND AllDocs.Level = 1))
	    ORDER BY
	        WebParts.tp_ListId,
	        WebParts.tp_DisplayName COLLATE Japanese_CI_AS,
        	WebParts.tp_CreationTime
        OPTION (FORCE ORDER)
       END
	END
	ELSE 
    IF (@CollationName = N'Modern_Spanish_CI_AS')    
	BEGIN
       IF @GetViewBodies = 1
       BEGIN
	    SELECT
	        WebParts.tp_ListID,
	        WebParts.tp_Type,
	        WebParts.tp_ID,
	        WebParts.tp_Flags,
	        WebParts.tp_DisplayName,
	        CASE WHEN AllDocs.DirName = N'' THEN
	            AllDocs.LeafName
	        ELSE
	            AllDocs.DirName + N'/' + AllDocs.LeafName END
	        AS
	            tp_PageUrl,
	        WebParts.tp_BaseViewId
,
             WebParts.tp_View AS tp_ViewBody,
	        WebParts.tp_Level,
	        WebParts.tp_ContentTypeId
	    FROM
            fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId,
	        @ListId, @UserInfoListId, @UserId, @Level) PageLists
        INNER LOOP JOIN
            WebParts 
        ON
            PageLists.tp_ListId = WebParts.tp_ListId AND
            (WebParts.tp_UserId IS NULL OR
             WebParts.tp_UserId = @UserId) AND
             WebParts.tp_Deleted = 0
        INNER JOIN
            AllDocs
        ON
            AllDocs.Id = WebParts.tp_PageUrlId AND
            AllDocs.Level = WebParts.tp_Level
        WHERE
            ((AllDocs.Id = @DocId AND AllDocs.Level = @Level) OR
             (AllDocs.Id <> @DocId AND AllDocs.Level = 1))
	    ORDER BY
	        WebParts.tp_ListId,
	        WebParts.tp_DisplayName COLLATE Modern_Spanish_CI_AS,
        	WebParts.tp_CreationTime
        OPTION (FORCE ORDER)
       END
       ELSE
       BEGIN
	    SELECT
	        WebParts.tp_ListID,
	        WebParts.tp_Type,
	        WebParts.tp_ID,
	        WebParts.tp_Flags,
	        WebParts.tp_DisplayName,
	        CASE WHEN AllDocs.DirName = N'' THEN
	            AllDocs.LeafName
	        ELSE
	            AllDocs.DirName + N'/' + AllDocs.LeafName END
	        AS
	            tp_PageUrl,
	        WebParts.tp_BaseViewId
,
             NULL AS tp_ViewBody,
	        WebParts.tp_Level,
	        WebParts.tp_ContentTypeId
	    FROM
            fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId,
	        @ListId, @UserInfoListId, @UserId, @Level) PageLists
        INNER LOOP JOIN
            WebParts 
        ON
            PageLists.tp_ListId = WebParts.tp_ListId AND
            (WebParts.tp_UserId IS NULL OR
             WebParts.tp_UserId = @UserId) AND
             WebParts.tp_Deleted = 0
        INNER JOIN
            AllDocs
        ON
            AllDocs.Id = WebParts.tp_PageUrlId AND
            AllDocs.Level = WebParts.tp_Level
        WHERE
            ((AllDocs.Id = @DocId AND AllDocs.Level = @Level) OR
             (AllDocs.Id <> @DocId AND AllDocs.Level = 1))
	    ORDER BY
	        WebParts.tp_ListId,
	        WebParts.tp_DisplayName COLLATE Modern_Spanish_CI_AS,
        	WebParts.tp_CreationTime
        OPTION (FORCE ORDER)
       END
	END
	ELSE 
    IF (@CollationName = N'French_CI_AS')    
	BEGIN
       IF @GetViewBodies = 1
       BEGIN
	    SELECT
	        WebParts.tp_ListID,
	        WebParts.tp_Type,
	        WebParts.tp_ID,
	        WebParts.tp_Flags,
	        WebParts.tp_DisplayName,
	        CASE WHEN AllDocs.DirName = N'' THEN
	            AllDocs.LeafName
	        ELSE
	            AllDocs.DirName + N'/' + AllDocs.LeafName END
	        AS
	            tp_PageUrl,
	        WebParts.tp_BaseViewId
,
             WebParts.tp_View AS tp_ViewBody,
	        WebParts.tp_Level,
	        WebParts.tp_ContentTypeId
	    FROM
            fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId,
	        @ListId, @UserInfoListId, @UserId, @Level) PageLists
        INNER LOOP JOIN
            WebParts 
        ON
            PageLists.tp_ListId = WebParts.tp_ListId AND
            (WebParts.tp_UserId IS NULL OR
             WebParts.tp_UserId = @UserId) AND
             WebParts.tp_Deleted = 0
        INNER JOIN
            AllDocs
        ON
            AllDocs.Id = WebParts.tp_PageUrlId AND
            AllDocs.Level = WebParts.tp_Level
        WHERE
            ((AllDocs.Id = @DocId AND AllDocs.Level = @Level) OR
             (AllDocs.Id <> @DocId AND AllDocs.Level = 1))
	    ORDER BY
	        WebParts.tp_ListId,
	        WebParts.tp_DisplayName COLLATE French_CI_AS,
        	WebParts.tp_CreationTime
        OPTION (FORCE ORDER)
       END
       ELSE
       BEGIN
	    SELECT
	        WebParts.tp_ListID,
	        WebParts.tp_Type,
	        WebParts.tp_ID,
	        WebParts.tp_Flags,
	        WebParts.tp_DisplayName,
	        CASE WHEN AllDocs.DirName = N'' THEN
	            AllDocs.LeafName
	        ELSE
	            AllDocs.DirName + N'/' + AllDocs.LeafName END
	        AS
	            tp_PageUrl,
	        WebParts.tp_BaseViewId
,
             NULL AS tp_ViewBody,
	        WebParts.tp_Level,
	        WebParts.tp_ContentTypeId
	    FROM
            fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId,
	        @ListId, @UserInfoListId, @UserId, @Level) PageLists
        INNER LOOP JOIN
            WebParts 
        ON
            PageLists.tp_ListId = WebParts.tp_ListId AND
            (WebParts.tp_UserId IS NULL OR
             WebParts.tp_UserId = @UserId) AND
             WebParts.tp_Deleted = 0
        INNER JOIN
            AllDocs
        ON
            AllDocs.Id = WebParts.tp_PageUrlId AND
            AllDocs.Level = WebParts.tp_Level
        WHERE
            ((AllDocs.Id = @DocId AND AllDocs.Level = @Level) OR
             (AllDocs.Id <> @DocId AND AllDocs.Level = 1))
	    ORDER BY
	        WebParts.tp_ListId,
	        WebParts.tp_DisplayName COLLATE French_CI_AS,
        	WebParts.tp_CreationTime
        OPTION (FORCE ORDER)
       END
	END
	ELSE IF (@CollationName IS NOT NULL)
	BEGIN
		DECLARE @param1 nvarchar(40)
       SET @param1 = CASE WHEN @SiteId IS NULL THEN N'NULL' ELSE N'''' + CAST(@SiteId AS nvarchar(40)) + N'''' END
		DECLARE @param2 nvarchar(40)
       SET @param2 = CASE WHEN @DocId IS NULL THEN N'NULL' ELSE N'''' + CAST(@DocId AS nvarchar(40)) + N'''' END
		DECLARE @param3 nvarchar(40)
       SET @param3 = CASE WHEN @WebId IS NULL THEN N'NULL' ELSE N'''' + CAST(@WebId AS nvarchar(40)) + N'''' END
		DECLARE @param4 nvarchar(40)
       SET @param4 = CASE WHEN @Level IS NULL THEN N'NULL' ELSE CAST(@Level AS nvarchar(40)) END
		DECLARE @param5 nvarchar(40)
       SET @param5 = CASE WHEN @UserId IS NULL THEN N'NULL' ELSE CAST(@UserId AS nvarchar(40)) END
		DECLARE @param6 nvarchar(40)
       SET @param6 = CASE WHEN @PrefetchListScope IS NULL THEN N'NULL' ELSE CAST(@PrefetchListScope AS nvarchar(40)) END
  		DECLARE @param7 nvarchar(40)
       SET @param7 = CASE WHEN @GetViewBodies IS NULL THEN N'NULL' ELSE CAST(@GetViewBodies AS nvarchar(40)) END
  		DECLARE @param8 nvarchar(40)
       SET @param8 = CASE WHEN @RootWebId IS NULL THEN N'NULL' ELSE N'''' + CAST(@RootWebId AS nvarchar(40)) + N'''' END
  		DECLARE @param9 nvarchar(40)
       SET @param9 = CASE WHEN @ListId IS NULL THEN N'NULL' ELSE N'''' + CAST(@ListId AS nvarchar(40)) + N'''' END
  		DECLARE @param10 nvarchar(40)
       SET @param10 = CASE WHEN @UserInfoListId IS NULL THEN N'NULL' ELSE N'''' + CAST(@UserInfoListId AS nvarchar(40)) + N'''' END
	EXEC(N'
	    DECLARE @SiteId uniqueidentifier
	    DECLARE @DocId uniqueidentifier
	    DECLARE @WebId uniqueidentifier
	    DECLARE @Level tinyint
	    DECLARE @UserId int
	    DECLARE @PrefetchListScope bit
	    DECLARE @GetViewBodies bit
	    DECLARE @RootWebId uniqueidentifier
	    DECLARE @ListId uniqueidentifier
	    DECLARE @UserInfoListId uniqueidentifier
	    SET @SiteId = ' + @param1 + N'
	    SET @DocId = ' + @param2 + N'
	    SET @WebId = ' + @param3 + N'
	    SET @Level = ' + @param4 + N'
	    SET @UserId = ' + @param5 + N'
	    SET @PrefetchListScope = ' + @param6 + N'
	    SET @GetViewBodies = ' + @param7 + N'
	    SET @RootWebId = ' + @param8 + N'
	    SET @ListId = ' + @param9 + N'
	    SET @UserInfoListId = ' + @param10 + N'
       IF @GetViewBodies = 1
       BEGIN
	    SELECT
	        WebParts.tp_ListID,
	        WebParts.tp_Type,
	        WebParts.tp_ID,
	        WebParts.tp_Flags,
	        WebParts.tp_DisplayName,
	        CASE WHEN AllDocs.DirName = N'''' THEN
	            AllDocs.LeafName
	        ELSE
	            AllDocs.DirName + N''/'' + AllDocs.LeafName END
	        AS
	            tp_PageUrl,
	        WebParts.tp_BaseViewId
,
             WebParts.tp_View AS tp_ViewBody,
	        WebParts.tp_Level,
	        WebParts.tp_ContentTypeId
	    FROM
            fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId,
	        @ListId, @UserInfoListId, @UserId, @Level) PageLists
        INNER LOOP JOIN
            WebParts 
        ON
            PageLists.tp_ListId = WebParts.tp_ListId AND
            (WebParts.tp_UserId IS NULL OR
             WebParts.tp_UserId = @UserId) AND
             WebParts.tp_Deleted = 0
        INNER JOIN
            AllDocs
        ON
            AllDocs.Id = WebParts.tp_PageUrlId AND
            AllDocs.Level = WebParts.tp_Level
        WHERE
            ((AllDocs.Id = @DocId AND AllDocs.Level = @Level) OR
             (AllDocs.Id <> @DocId AND AllDocs.Level = 1))
	    ORDER BY
	        WebParts.tp_ListId,
	        WebParts.tp_DisplayName COLLATE ' + @CollationName + N',
        	WebParts.tp_CreationTime
        OPTION (FORCE ORDER)
       END
       ELSE
       BEGIN
	    SELECT
	        WebParts.tp_ListID,
	        WebParts.tp_Type,
	        WebParts.tp_ID,
	        WebParts.tp_Flags,
	        WebParts.tp_DisplayName,
	        CASE WHEN AllDocs.DirName = N'''' THEN
	            AllDocs.LeafName
	        ELSE
	            AllDocs.DirName + N''/'' + AllDocs.LeafName END
	        AS
	            tp_PageUrl,
	        WebParts.tp_BaseViewId
,
             NULL AS tp_ViewBody,
	        WebParts.tp_Level,
	        WebParts.tp_ContentTypeId
	    FROM
            fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId,
	        @ListId, @UserInfoListId, @UserId, @Level) PageLists
        INNER LOOP JOIN
            WebParts 
        ON
            PageLists.tp_ListId = WebParts.tp_ListId AND
            (WebParts.tp_UserId IS NULL OR
             WebParts.tp_UserId = @UserId) AND
             WebParts.tp_Deleted = 0
        INNER JOIN
            AllDocs
        ON
            AllDocs.Id = WebParts.tp_PageUrlId AND
            AllDocs.Level = WebParts.tp_Level
        WHERE
            ((AllDocs.Id = @DocId AND AllDocs.Level = @Level) OR
             (AllDocs.Id <> @DocId AND AllDocs.Level = 1))
	    ORDER BY
	        WebParts.tp_ListId,
	        WebParts.tp_DisplayName COLLATE ' + @CollationName + N',
        	WebParts.tp_CreationTime
        OPTION (FORCE ORDER)
       END')
	END
	ELSE
	BEGIN
       IF @GetViewBodies = 1
       BEGIN
	    SELECT
	        WebParts.tp_ListID,
	        WebParts.tp_Type,
	        WebParts.tp_ID,
	        WebParts.tp_Flags,
	        WebParts.tp_DisplayName,
	        CASE WHEN AllDocs.DirName = N'' THEN
	            AllDocs.LeafName
	        ELSE
	            AllDocs.DirName + N'/' + AllDocs.LeafName END
	        AS
	            tp_PageUrl,
	        WebParts.tp_BaseViewId
,
             WebParts.tp_View AS tp_ViewBody,
	        WebParts.tp_Level,
	        WebParts.tp_ContentTypeId
	    FROM
            fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId,
	        @ListId, @UserInfoListId, @UserId, @Level) PageLists
        INNER LOOP JOIN
            WebParts 
        ON
            PageLists.tp_ListId = WebParts.tp_ListId AND
            (WebParts.tp_UserId IS NULL OR
             WebParts.tp_UserId = @UserId) AND
             WebParts.tp_Deleted = 0
        INNER JOIN
            AllDocs
        ON
            AllDocs.Id = WebParts.tp_PageUrlId AND
            AllDocs.Level = WebParts.tp_Level
        WHERE
            ((AllDocs.Id = @DocId AND AllDocs.Level = @Level) OR
             (AllDocs.Id <> @DocId AND AllDocs.Level = 1))
	    ORDER BY
	        WebParts.tp_ListId,
	        WebParts.tp_DisplayName,
        	WebParts.tp_CreationTime
        OPTION (FORCE ORDER)
       END
       ELSE
       BEGIN
	    SELECT
	        WebParts.tp_ListID,
	        WebParts.tp_Type,
	        WebParts.tp_ID,
	        WebParts.tp_Flags,
	        WebParts.tp_DisplayName,
	        CASE WHEN AllDocs.DirName = N'' THEN
	            AllDocs.LeafName
	        ELSE
	            AllDocs.DirName + N'/' + AllDocs.LeafName END
	        AS
	            tp_PageUrl,
	        WebParts.tp_BaseViewId
,
             NULL AS tp_ViewBody,
	        WebParts.tp_Level,
	        WebParts.tp_ContentTypeId
	    FROM
            fn_GetPageListIdTableNoListInfo(@SiteId, @DocId, @RootWebId, @WebId,
	        @ListId, @UserInfoListId, @UserId, @Level) PageLists
        INNER LOOP JOIN
            WebParts 
        ON
            PageLists.tp_ListId = WebParts.tp_ListId AND
            (WebParts.tp_UserId IS NULL OR
             WebParts.tp_UserId = @UserId) AND
             WebParts.tp_Deleted = 0
        INNER JOIN
            AllDocs
        ON
            AllDocs.Id = WebParts.tp_PageUrlId AND
            AllDocs.Level = WebParts.tp_Level
        WHERE
            ((AllDocs.Id = @DocId AND AllDocs.Level = @Level) OR
             (AllDocs.Id <> @DocId AND AllDocs.Level = 1))
	    ORDER BY
	        WebParts.tp_ListId,
	        WebParts.tp_DisplayName,
        	WebParts.tp_CreationTime
        OPTION (FORCE ORDER)
       END
	END
    IF (0 <> @@ERROR)
        RETURN 1
    RETURN 0

GO
