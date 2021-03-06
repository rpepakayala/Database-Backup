/****** Object:  StoredProcedure [dbo].[proc_SecGetDomainGroupMapData]    Script Date: 5/15/2018 12:12:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecGetDomainGroupMapData(
    @SiteId uniqueidentifier, 
    @DGCacheVersion bigint)
AS
    SET NOCOUNT ON
    DECLARE @RealVer bigint
    DECLARE @CacheVer bigint
    IF (@DGCacheVersion = -2)
    BEGIN
        SELECT @DGCacheVersion AS RealVersion, @DGCacheVersion AS CachedVersion, @DGCacheVersion AS FrontEndVersion
        RETURN 0
    END
    SELECT 
        @RealVer = DomainGroupMapVersion,
        @CacheVer = DomainGroupMapCacheVersion
    FROM
        Sites WITH (NOLOCK)
    WHERE
        Id = @SiteId
    SELECT @RealVer AS RealVersion, @CacheVer AS CachedVersion, @DGCacheVersion AS FrontEndVersion
    IF (@RealVer > @CacheVer)
    BEGIN
        SELECT 
            tp_Id, tp_SystemId, GroupId
        FROM 
            UserInfo
        LEFT OUTER JOIN
            GroupMembership
        ON
            GroupMembership.SiteId = @SiteId AND GroupMembership.MemberId = UserInfo.tp_Id
        WHERE
            tp_SiteId = @SiteId AND
            tp_DomainGroup = 1
        ORDER BY
            tp_Id       
    END
    ELSE
    BEGIN
        SELECT
            CASE WHEN @DGCacheVersion < @CacheVer THEN DomainGroupMapCache ELSE NULL END AS DomainGroupMapCache
        FROM
            Sites WITH (NOLOCK)
        WHERE
            Id = @SiteId
    END

GO
