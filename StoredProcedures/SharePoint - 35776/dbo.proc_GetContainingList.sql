/****** Object:  StoredProcedure [dbo].[proc_GetContainingList]    Script Date: 5/15/2018 12:12:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetContainingList(
    @SiteId uniqueidentifier,
    @WebId  uniqueidentifier,
    @Url nvarchar(260))
AS
    DECLARE @iRet int
    DECLARE @ListId uniqueidentifier
    EXEC @iRet = proc_GetContainingListCore @SiteId, @WebId, @Url, 1,
        @ListId OUTPUT
    IF @ListId IS NOT NULL
        EXEC proc_GetEventReceivers @SiteId, @WebId, @ListId, 2
    RETURN @iRet

GO
