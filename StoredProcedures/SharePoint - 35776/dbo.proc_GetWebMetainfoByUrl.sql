/****** Object:  StoredProcedure [dbo].[proc_GetWebMetainfoByUrl]    Script Date: 5/15/2018 12:12:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetWebMetainfoByUrl(
    @WebSiteId uniqueidentifier,
    @Url nvarchar(260),
    @DGCacheVersion bigint,
    @SystemId tSystemId = NULL)
AS
    SET NOCOUNT ON
    DECLARE @WebUrl nvarchar(256)
    DECLARE @WebDirName nvarchar(256)
    DECLARE @WebLeafName nvarchar(128)
    DECLARE @WebId uniqueidentifier
    DECLARE @iRet integer
    SET @iRet = 0
    EXEC @iRet = proc_UrlToWebUrlOutput @WebSiteId, @Url, 
        @WebDirName OUTPUT, @WebLeafName OUTPUT
    IF (@iRet <> 0)
    BEGIN
        GOTO CLEANUP             
    END
    IF @WebDirName IS NULL OR @WebLeafName IS NULL
    BEGIN
        SET @iRet = 3
        GOTO CLEANUP
    END
    SET @WebUrl = CASE WHEN (DATALENGTH(@WebDirName) = 0) THEN @WebLeafName WHEN (DATALENGTH(@WebLeafName) = 0) THEN @WebDirName ELSE @WebDirName + N'/' + @WebLeafName END
    SELECT @WebUrl
    EXEC proc_GetWebMetaInfo @WebSiteId, @WebDirName, @WebLeafName, @DGCacheVersion, @SystemId
CLEANUP:
    RETURN @iRet

GO
