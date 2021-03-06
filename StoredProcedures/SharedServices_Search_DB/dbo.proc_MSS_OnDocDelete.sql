/****** Object:  StoredProcedure [dbo].[proc_MSS_OnDocDelete]    Script Date: 5/15/2018 12:11:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_OnDocDelete
                    @nCatalogId SMALLINT,
                    @docid int
AS

    SET NOCOUNT ON

    SET XACT_ABORT ON

    BEGIN TRANSACTION

    DECLARE @strDocid NVARCHAR(128)
    SELECT @strDocid = CONVERT(NVARCHAR(128), @docid)

    DECLARE @strCatalogId NVARCHAR(128)
    SELECT @strCatalogId = CONVERT(NVARCHAR(128), @nCatalogId)

    declare @strCommand nvarchar(4000)

    select @strCommand = 'delete from MSSDocSdids where docid = ' + @strDocid
    exec(@strCommand)

    select @strCommand = 'delete from MSSDocProps where docid = ' + @strDocid
    exec(@strCommand)

    select @strCommand = 'delete from MSSDuplicateHashes where docid = ' + @strDocid
    exec(@strCommand)

    select @strCommand = 'delete from MSSDefinitions where docid = ' + @strDocid
    exec(@strCommand)

    COMMIT TRANSACTION

    RETURN 1


GO
