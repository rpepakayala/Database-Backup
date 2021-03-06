/****** Object:  StoredProcedure [dbo].[proc_GetFeatureProperties]    Script Date: 5/15/2018 12:12:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetFeatureProperties(
    @SiteId                     uniqueidentifier,
    @WebId                      uniqueidentifier, 
    @FeatureId                  uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    SET @iRet = 0
    SELECT
        TimeActivated,
        Flags,
        Properties,
        PropertiesModified
    FROM
        Features
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        FeatureId = @FeatureId
    IF (@@ROWCOUNT <> 1 OR @@ERROR <> 0)
    BEGIN
        SET @iRet = 3
    END            
    RETURN @iRet

GO
