/****** Object:  StoredProcedure [dbo].[proc_ProvisionContentType]    Script Date: 5/15/2018 12:12:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC dbo.proc_ProvisionContentType(
    @SiteId uniqueidentifier,
    @Scope nvarchar(256),
    @Class tinyint,
    @NextChildByte tinyint,    
    @ContentTypeId tContentTypeId,
    @ResourceDir nvarchar(128) = NULL)
AS
    SET NOCOUNT ON
    DECLARE @WebId uniqueidentifier
    DECLARE @ctsName nvarchar(256)
    IF NOT EXISTS(SELECT * FROM ContentTypes WHERE
        SiteId =  @SiteId AND Scope = @Scope AND ContentTypeId = @ContentTypeId)
    BEGIN
        INSERT INTO
            ContentTypes(
            SiteId,
            Class,
            Scope,
            ContentTypeId,
            Version,
            NextChildByte,
            Size,
            Definition,
            ResourceDir,
            IsFromFeature)
        VALUES(
            @SiteId,
            @Class,
            @Scope,
            @ContentTypeId,
            0,
            @NextChildByte,
            16,
            NULL,
            @ResourceDir,
            1)
        IF @ResourceDir IS NOT NULL
        BEGIN
            SELECT
                @WebId = Id
            FROM
                Webs
            WHERE
                SiteId = @SiteId AND
                ParentWebId IS NULL
            IF NOT EXISTS(SELECT Id FROM Docs WHERE
                SiteId = @SiteId AND
                DirName = @Scope AND
                LeafName = N'_cts')
            BEGIN
                EXEC proc_CreateDir
                    @SiteId,
                    @WebId,
                    @Scope,
                    N'_cts',
                    1,
                    0,
                    0,
                    16
            END
            IF @Scope = N''
            BEGIN
                SET @ctsName = N'_cts'
            END
            ELSE
            BEGIN
                SET @ctsName = @Scope + '/_cts'
            END
            IF NOT EXISTS(SELECT Id FROM Docs WHERE
                SiteId = @SiteId AND
                DirName = @ctsName AND
                LeafName = @ResourceDir)
            BEGIN            
                EXEC proc_CreateDir
                    @SiteId,
                    @WebId,
                    @ctsName,
                    @ResourceDir,
                    1,
                    0,
                    0,
                    16
            END                
        END                
    END
    RETURN 0

GO
