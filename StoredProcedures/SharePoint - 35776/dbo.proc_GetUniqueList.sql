/****** Object:  StoredProcedure [dbo].[proc_GetUniqueList]    Script Date: 5/15/2018 12:12:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_GetUniqueList(
    @WebId               uniqueidentifier,
    @ServerTemplate      int,
    @@ListID             uniqueidentifier OUTPUT)
AS
    SET NOCOUNT ON
    SELECT TOP 1
        @@ListID = tp_ID
    FROM
        Lists
    WHERE
        tp_WebId = @WebId AND
        tp_ServerTemplate = @ServerTemplate

GO
