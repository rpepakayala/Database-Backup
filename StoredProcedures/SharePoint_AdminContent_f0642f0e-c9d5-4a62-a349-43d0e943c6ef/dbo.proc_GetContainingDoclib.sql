/****** Object:  StoredProcedure [dbo].[proc_GetContainingDoclib]    Script Date: 5/15/2018 12:12:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetContainingDoclib(
    @SiteId uniqueidentifier,
    @WebId  uniqueidentifier,
    @Url nvarchar(260),
    @bReturnDoclibMetadata bit,
    @DoclibId uniqueidentifier = NULL OUTPUT)
AS
    DECLARE @iRet int
    DECLARE @BaseType int
    EXEC @iRet = proc_GetContainingListCore @SiteId, @WebId, @Url,
        @bReturnDoclibMetadata,
        @DoclibId OUTPUT, @BaseType OUTPUT
    IF @DoclibId IS NOT NULL AND @BaseType <> 1
    BEGIN
        SET @DoclibId = NULL
    END
    RETURN @iRet

GO
