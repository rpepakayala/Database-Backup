/****** Object:  StoredProcedure [dbo].[proc_GetAllWebPartsInternal]    Script Date: 5/15/2018 12:12:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetAllWebPartsInternal(
    @SiteId uniqueidentifier,
    @AllUsers bit,
    @UserID int,
    @DocID uniqueidentifier,
    @ListID uniqueidentifier,
    @WebID uniqueidentifier,
    @Collation smallint,
    @Level tinyint,
    @PrefetchListScope bit,
    @GetViewBodies bit)
AS
    SET NOCOUNT ON
    DECLARE @Ret int
    SET @Ret = 0
    IF (@AllUsers = 1)
    BEGIN
        SELECT
            dbo.WebParts.tp_ID,
            dbo.WebParts.tp_ZoneID,
            dbo.WebParts.tp_WebPartTypeId,
            dbo.WebParts.tp_IsIncluded,
            dbo.WebParts.tp_FrameState,
            dbo.WebParts.tp_AllUsersProperties,
            dbo.WebParts.tp_PerUserProperties,
            dbo.WebParts.tp_PartOrder,
            COALESCE(dbo.WebParts.tp_Flags, 0),
            1,    
            dbo.WebParts.tp_Cache,
            NULL,
            N'{' + CAST(dbo.WebParts.tp_ListId AS nvarchar(36)) + N'}',
            dbo.WebParts.tp_Type,
            dbo.WebParts.tp_Source,
            dbo.WebParts.tp_View
        FROM
            dbo.WebParts
        WHERE
            dbo.WebParts.tp_SiteID = @SiteID AND
            dbo.WebParts.tp_PageUrlID = @DocID AND
            dbo.WebParts.tp_UserID IS NULL AND
            dbo.WebParts.tp_Level = @Level
        ORDER BY
            dbo.WebParts.tp_CreationTime
    END
    ELSE
    BEGIN
        SELECT
            dbo.WebParts.tp_ID,
            COALESCE(dbo.Personalization.tp_ZoneID,
                dbo.WebParts.tp_ZoneID),
            dbo.WebParts.tp_WebPartTypeId,
            COALESCE(dbo.Personalization.tp_IsIncluded,
                dbo.WebParts.tp_IsIncluded),
            COALESCE(dbo.Personalization.tp_FrameState,
                dbo.WebParts.tp_FrameState),
            dbo.WebParts.tp_AllUsersProperties,
            CASE
                WHEN dbo.Personalization.tp_UserID IS NULL THEN dbo.WebParts.tp_PerUserProperties
                ELSE dbo.Personalization.tp_PerUserProperties
            END,
            COALESCE(dbo.Personalization.tp_PartOrder,
                dbo.WebParts.tp_PartOrder),
            COALESCE(dbo.WebParts.tp_Flags, 0),
            CASE
                WHEN dbo.WebParts.tp_UserID IS NOT NULL THEN 3    
                WHEN dbo.Personalization.tp_UserID IS NULL THEN 1    
                ELSE 2    
            END,
            dbo.WebParts.tp_Cache,
            CASE 
                WHEN @Level = 1 THEN dbo.Personalization.tp_Cache
                ELSE NULL
            END,
            N'{' + CAST(dbo.WebParts.tp_ListId AS nvarchar(36)) + N'}',
            dbo.WebParts.tp_Type,
            dbo.WebParts.tp_Source,
            dbo.WebParts.tp_View
        FROM
            dbo.WebParts
                LEFT OUTER JOIN
                    dbo.Personalization
                ON(
                    dbo.Personalization.tp_SiteID = dbo.WebParts.tp_SiteID AND
                    dbo.Personalization.tp_PageUrlID = dbo.WebParts.tp_PageUrlID
                    AND dbo.Personalization.tp_UserID = @UserID
                    AND dbo.Personalization.tp_WebPartID = dbo.WebParts.tp_ID)
        WHERE
            dbo.WebParts.tp_SiteId = @SiteId
            AND dbo.WebParts.tp_PageUrlID = @DocID
            AND dbo.WebParts.tp_Level = @Level
            AND (dbo.WebParts.tp_UserID IS NULL OR
                dbo.WebParts.tp_UserID = @UserID
            )
        ORDER BY
            dbo.WebParts.tp_CreationTime
    END
    IF (@@ERROR <> 0 OR @Ret <> 0)
    BEGIN
        IF (@Ret = 0)
            SET @Ret = 1
        GOTO cleanup
    END
    EXEC @Ret = proc_GetTpPageMetaData @SiteId, @DocId, @ListID, @WebId, @Collation,
        @Level, @UserId, @PrefetchListScope, @GetViewBodies
    IF (@@ERROR <> 0 OR @Ret <> 0)
    BEGIN
        IF (@Ret = 0)
            SET @Ret = 1 
        GOTO cleanup
    END
cleanup:
    RETURN @Ret

GO
