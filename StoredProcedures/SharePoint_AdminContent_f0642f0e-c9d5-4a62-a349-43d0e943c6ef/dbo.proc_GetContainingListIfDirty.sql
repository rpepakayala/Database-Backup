/****** Object:  StoredProcedure [dbo].[proc_GetContainingListIfDirty]    Script Date: 5/15/2018 12:12:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetContainingListIfDirty(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @Url nvarchar(260))
AS
    DECLARE @ListId uniqueidentifier,
        @BaseType int,
        @ExcludedType int,
        @ListFlags int,
        @iRet int
    EXEC @iRet = proc_GetContainingListCore @SiteId, @WebId, @Url, 0,
        @ListId OUTPUT,
        @BaseType OUTPUT,
        @ExcludedType OUTPUT,
        0, 
        @ListFlags OUTPUT
    IF @iRet <> 0
        RETURN @iRet
    IF @ListId IS NOT NULL AND
        @ListFlags & 1 <> 0
    BEGIN
        EXEC proc_GetListMetaData @WebId, @ListId, 0
    END
    ELSE
    BEGIN
        SELECT NULL WHERE 1 = 0
    END
    RETURN @iRet

GO
