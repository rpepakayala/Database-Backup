/****** Object:  StoredProcedure [dbo].[proc_SetNextId]    Script Date: 5/15/2018 12:12:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SetNextId(
    @WebId uniqueidentifier,
    @ListId uniqueidentifier,
    @NextAvailableId int)
AS
    SET NOCOUNT ON
    DECLARE @NextId int
    BEGIN TRAN
    SELECT
        @NextId = tp_NextAvailableId
    FROM
        Lists WITH (UPDLOCK)
    WHERE
        tp_WebId = @WebId AND
        tp_ID = @ListId
    IF @NextAvailableId > @NextId
        UPDATE
            Lists
        SET
            tp_NextAvailableId = @NextAvailableId
        WHERE
            tp_WebId = @WebId AND
            tp_ID = @ListId
    COMMIT TRAN

GO
