/****** Object:  StoredProcedure [dbo].[proc_SecListScopesInWebs]    Script Date: 5/15/2018 12:12:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecListScopesInWebs(
    @SiteId uniqueidentifier,
    @WebId  uniqueidentifier)
AS
    SET NOCOUNT ON

GO
