/****** Object:  StoredProcedure [dbo].[proc_ScorchList]    Script Date: 5/15/2018 12:12:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_ScorchList
(
    @ListId      uniqueidentifier
)
AS
    SET NOCOUNT ON
    DECLARE @SiteId uniqueidentifier
    DECLARE @WebId uniqueidentifier
    DECLARE @DirName nvarchar(256)
    DECLARE @LeafName nvarchar(128)
    DECLARE @ListUrl nvarchar(260)
    DECLARE @Ret int
    SELECT TOP 1
        @SiteId = SiteId,
        @WebId = Docs.WebId,
        @DirName = DirName,
        @LeafName = LeafName
    FROM
        Docs
    WHERE
        Docs.ListId = @ListId
    Order BY    
        DATALENGTH(DirName)
    IF (@SiteId IS NOT NULL)
    BEGIN
        SET @ListUrl = CASE WHEN (DATALENGTH(@DirName) = 0) THEN @LeafName WHEN (DATALENGTH(@LeafName) = 0) THEN @DirName ELSE @DirName + N'/' + @LeafName END      
    END
    ELSE
    BEGIN
        RETURN 3
    END
    EXEC @Ret = proc_DeleteUrl
        @SiteId,
        @WebId,
        @ListUrl,
        0, 
        0, 
        0, 
        0, 
        0,
        3,
        1 
    RETURN @Ret     

GO
