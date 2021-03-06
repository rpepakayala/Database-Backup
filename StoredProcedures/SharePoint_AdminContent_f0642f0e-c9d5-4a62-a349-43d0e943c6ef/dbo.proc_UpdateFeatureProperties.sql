/****** Object:  StoredProcedure [dbo].[proc_UpdateFeatureProperties]    Script Date: 5/15/2018 12:13:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_UpdateFeatureProperties(
    @SiteId                     uniqueidentifier,
    @WebId                      uniqueidentifier, 
    @FeatureId                  uniqueidentifier,
    @Flags                      int = 0,
    @Properties                 ntext = NULL)
AS
    SET NOCOUNT ON
    DECLARE @iRet int
    SET @iRet = 0
    UPDATE
        Features
    SET
        Flags = @Flags,
        Properties = @Properties,
        PropertiesModified = GETUTCDATE()
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
