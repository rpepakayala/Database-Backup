/****** Object:  StoredProcedure [dbo].[proc_DeleteSubscription]    Script Date: 5/15/2018 12:11:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteSubscription(
    @SiteId         uniqueidentifier,
    @SubId          uniqueidentifier,
    @UserId         int)
AS
    SET NOCOUNT ON
    DECLARE @WebId uniqueidentifier
    DECLARE @ListId uniqueidentifier
    DECLARE @ItemId int
    DECLARE @AlertType int
    SELECT
        @WebId = WebId,
        @AlertType = AlertType,
        @ListId = ListId,
        @ItemId = ItemId
    FROM
        ImmedSubscriptions
    WHERE
        SiteId = @SiteId AND
        UserId = @UserId AND
        Id = @SubId
    IF (@@ROWCOUNT = 0)
    BEGIN
        SELECT
            @WebId = WebId,
            @AlertType = AlertType,
            @ListId = ListId,
            @ItemId = ItemId
        FROM
            SchedSubscriptions
        WHERE
            SiteId = @SiteId AND
            UserId = @UserId AND
            Id = @SubId
    END
    DECLARE @Ret int
    SET @Ret = 1359
    BEGIN TRAN
    DELETE
        ImmedSubscriptions
    WHERE
        SiteId      = @SiteId   AND
        UserId      = @UserId   AND
        Id          = @SubId
    IF (@@ROWCOUNT = 0)
    BEGIN
        DELETE
            EventSubsMatches 
        WHERE
            SubId = @SubId
        DELETE
            SchedSubscriptions
        WHERE
            SiteId      = @SiteId   AND
            UserId      = @UserId   AND
            Id          = @SubId
        IF (@@ROWCOUNT = 0)
        BEGIN
            SET @Ret = 31
            GOTO cleanup
        END
    END
    EXEC proc_LogChange @SiteId, @WebId, @ListId, @ItemId, NULL, @SubId, NULL,
        NULL, 16384,  64, NULL
    IF ((@AlertType & 15 = 0 OR 
         @AlertType & 15 = 1) AND
        (0 = (SELECT COUNT(*) FROM ImmedSubscriptions WHERE SiteId = @SiteId AND ListId = @ListId)) AND
        (0 = (SELECT COUNT(*) FROM SchedSubscriptions WHERE SiteId = @SiteId AND ListId = @ListId)))
    BEGIN
        UPDATE
            Lists
        SET
            tp_Subscribed = 0
        WHERE
            Lists.tp_WebId  = @WebId            AND
            Lists.tp_ID     = @ListId
    END
    SET @Ret = 0
cleanup:
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Ret

GO
