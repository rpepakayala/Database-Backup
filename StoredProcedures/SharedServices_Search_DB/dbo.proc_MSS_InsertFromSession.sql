/****** Object:  StoredProcedure [dbo].[proc_MSS_InsertFromSession]    Script Date: 5/15/2018 12:11:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_InsertFromSession
                    @nCatalogId SMALLINT,
                    @nIsAlt int
WITH RECOMPILE
AS

    SET NOCOUNT ON

    SET XACT_ABORT ON 

    BEGIN TRANSACTION

    declare @strAlt nvarchar(128)
    select @strAlt = ''

    if (@nIsAlt=1)
    begin
        select @strAlt = 'Alt'
    end

    DECLARE @strSessionDocProps NVARCHAR(128)
    SELECT @strSessionDocProps = 'MSSSessionDocProps' + @strAlt

    DECLARE @strCatalogId NVARCHAR(128)
    SELECT @strCatalogId = CONVERT(NVARCHAR(128), @nCatalogId)

    DECLARE @strSessionDocSdids NVARCHAR(128)
    SELECT @strSessionDocSdids = 'MSSSessionDocSdids' + @strAlt

    DECLARE @strSessionExistingDocs NVARCHAR(128)
    SELECT @strSessionExistingDocs = 'MSSSessionExistingDocs' + @strAlt

    declare @strCommand nvarchar(4000)

    DECLARE @NoExistingDocs BIT
    SET @NoExistingDocs = 0

    DECLARE @NoDocs BIT
    SET @NoDocs = 0

    DECLARE @SecurityOnly BIT
    SET @SecurityOnly = 0

    SELECT @strCommand = 
        N'IF NOT EXISTS (SELECT TOP 1 1 FROM '+ @strSessionDocProps + ') 
            SET @NoDocs = 1'
    EXEC sp_executesql @strCommand, N'@NoDocs BIT OUTPUT', @NoDocs OUTPUT

    IF @NoDocs = 1
    BEGIN
        SET @strCommand = 
            N'IF EXISTS (SELECT TOP 1 1 FROM '+ @strSessionDocSdids + ') 
                SET @SecurityOnly = 1'
        EXEC sp_executesql @strCommand, N'@SecurityOnly BIT OUTPUT', @SecurityOnly OUTPUT

        IF @SecurityOnly = 1
            EXEC dbo.proc_MSS_InsertSdidsFromSession @nIsAlt, @NoExistingDocs

    END
    ELSE
    BEGIN
        SELECT @strCommand = 
            N'IF NOT EXISTS (SELECT TOP 1 1 FROM '+ @strSessionExistingDocs + ') 
                SET @NoExistingDocs = 1'
        EXEC sp_executesql @strCommand, N'@NoExistingDocs bit OUTPUT', @NoExistingDocs OUTPUT

        EXEC dbo.proc_MSS_InsertDocSignaturesFromSession @nIsAlt, @NoExistingDocs

        EXEC dbo.proc_MSS_InsertDocPropsFromSession @nIsAlt, @NoExistingDocs

        EXEC dbo.proc_MSS_InsertDuplicateHashesFromSession @nIsAlt, @NoExistingDocs

        EXEC dbo.proc_MSS_InsertDefinitionsFromSession @nIsAlt, @NoExistingDocs

        EXEC dbo.proc_MSS_InsertSdidsFromSession @nIsAlt, @NoExistingDocs
    end

    SELECT @strCommand = '
        TRUNCATE TABLE '+ @strSessionDocProps
    EXEC(@strCommand)

    SELECT @strCommand = '
        TRUNCATE TABLE '+ @strSessionExistingDocs
    EXEC(@strCommand)

    COMMIT TRANSACTION

    RETURN 1


GO
