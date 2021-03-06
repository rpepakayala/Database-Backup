/****** Object:  StoredProcedure [dbo].[proc_ScorchWeb]    Script Date: 5/15/2018 12:12:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ScorchWeb
(
    @WebId      uniqueidentifier
)
AS
    SET NOCOUNT ON
    DECLARE @SiteId uniqueidentifier
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    DECLARE @WebUrl nvarchar(260)
    DECLARE @FailedUrl nvarchar(260)
    DECLARE @Ret int
    SELECT
        @SiteId = SiteId,
        @DirName = DirName,
        @LeafName = LeafName
    FROM 
        Docs
    WHERE
        WebId = @WebId AND
        Type = 2
    IF (@SiteId IS NOT NULL)
    BEGIN
        SET @WebUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END      
    END
    ELSE
    BEGIN
        SELECT TOP 1
            @SiteId = SiteId,
            @DirName = DirName,
            @LeafName = LeafName
        FROM
            Docs
        WHERE
            WebId = @WebId AND
            ListId IS NULL AND
            DoclibRowId IS NULL
        ORDER BY
           DATALENGTH(DirName)
        SET @WebUrl = @DirName
        IF (@SiteId IS NULL)   
            RETURN 3
    END
    EXEC @Ret = proc_DeleteWeb @SiteId, @WebUrl, @FailedUrl OUTPUT, 8, @WebId
    RETURN @Ret     

GO
