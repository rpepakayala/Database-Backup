/****** Object:  StoredProcedure [dbo].[proc_ForceDeleteList]    Script Date: 5/15/2018 12:12:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ForceDeleteList(
    @SiteId                     uniqueidentifier,
    @DirName                    nvarchar(256),
    @LeafName                   nvarchar(128),
    @UserId                     int)
AS
    SET NOCOUNT ON
    DECLARE @IsListRoot bit,
        @WebId uniqueidentifier,
        @Url nvarchar(260),
        @ReturnCode int
    SELECT @IsListRoot =
        CASE
            WHEN Docs.Id = Lists.tp_RootFolder
            THEN 1
            ELSE 0
        END,
        @WebId = Docs.WebId
    FROM Docs
    LEFT OUTER JOIN Lists 
    ON Docs.WebId = Lists.tp_WebId AND
        Docs.ListId = Lists.tp_ID
    WHERE Docs.SiteId = @SiteId AND
        Docs.DirName = @DirName AND
        Docs.LeafName = @LeafName AND
        Docs.Level = 1
    IF @IsListRoot IS NULL
        RETURN 2
    IF @IsListRoot = 0
        RETURN 87
    SET @Url = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END
    EXEC @ReturnCode = proc_DeleteUrl
         @SiteId,
         @WebId,
         @Url,
         @UserId,
         1, 
         0, 
         0, 
         0,
         0,
         1, 
         3,
         1 
    RETURN @ReturnCode

GO
