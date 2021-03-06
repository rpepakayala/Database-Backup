/****** Object:  StoredProcedure [dbo].[proc_GetThicketFolder]    Script Date: 5/15/2018 12:12:05 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetThicketFolder(
    @WebSiteId       uniqueidentifier,
    @DirName    nvarchar(256),
    @LeafName   nvarchar(128),
    @ThicketLeaf   nvarchar(128) OUTPUT,
    @ThicketFolder nvarchar(260) OUTPUT
)
AS
    DECLARE @TFO nvarchar(128)
    DECLARE @TFO2 nvarchar(1024)
    DECLARE @idx int
    SET @idx = CHARINDEX(N'.',
        @LeafName
        COLLATE Latin1_General_BIN)
    SET @TFO = 
    CASE WHEN @idx > 0 THEN LEFT(@LeafName, @idx - 1) ELSE @LeafName END
    EXEC proc_EscapeForLike @TFO, @TFO2 OUTPUT, 0
    SET @TFO2 = @TFO2 + '[._-]%'
    SELECT TOP 1
        @ThicketLeaf = LeafName,
        @ThicketFolder = CASE WHEN (DATALENGTH(DirName) = 0) THEN LeafName WHEN (DATALENGTH(LeafName) = 0) THEN DirName ELSE DirName + N'/' + LeafName END
    FROM
        Docs
    WHERE
        SiteId = @WebSiteId AND
        DirName = @DirName AND
        LeafName LIKE @TFO2 AND
        Type = 1 AND
        ThicketFlag = 1

GO
