/****** Object:  StoredProcedure [dbo].[proc_TestAttachmentsFlag]    Script Date: 5/15/2018 12:12:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_TestAttachmentsFlag(
    @SiteID     uniqueidentifier,
    @DirName    nvarchar(256),
    @UrlFlag    tinyint,
    @ListID     uniqueidentifier = NULL OUTPUT,
    @ReadSecurity  int = NULL OUTPUT,
    @WriteSecurity int = NULL OUTPUT)
AS
    DECLARE @RootDirName        nvarchar(256)
    DECLARE @RootLeafName       nvarchar(128)
    DECLARE @AttachSubFolder    nvarchar(128)
    IF @UrlFlag = 3
    BEGIN
        EXEC proc_SplitUrl @DirName, @RootDirName OUTPUT, 
            @RootLeafName OUTPUT
    END
    ELSE IF @UrlFlag = 1
    BEGIN
        EXEC proc_SplitUrl  @DirName, @DirName OUTPUT,
            @AttachSubFolder OUTPUT
        SET @RootDirName = LEFT(@DirName, LEN(@DirName) - 
            12)
        EXEC proc_SplitUrl @RootDirName, @RootDirName OUTPUT, 
            @RootLeafName OUTPUT
    END
    ELSE IF @UrlFlag = 2
    BEGIN
        SET @RootDirName = LEFT(@DirName, LEN(@DirName) - 
            12)
        EXEC proc_SplitUrl @RootDirName, @RootDirName OUTPUT, 
            @RootLeafName OUTPUT
    END
    ELSE
        RETURN 0        
    SELECT 
        @ListID        = Lists.tp_ID,
        @ReadSecurity  = tp_ReadSecurity,
        @WriteSecurity = tp_WriteSecurity
    FROM
        Docs, Lists
    WHERE
        Docs.SiteId  = @SiteID AND
        Docs.DirName = @RootDirName AND
        Docs.LeafName = @RootLeafName AND
        Docs.WebId   = Lists.tp_WebId AND
        Docs.ListId  = Lists.tp_ID AND
        Docs.Id      = Lists.tp_RootFolder AND
        Lists.tp_BaseType <> 1  AND
        Lists.tp_BaseType <> 4 AND
        Lists.tp_Flags & 0x08 = 0
    IF (@ListID IS NULL)
        RETURN 0
    ELSE
        RETURN 1

GO
