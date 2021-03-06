/****** Object:  StoredProcedure [dbo].[proc_DeleteSmartPagePersonalization]    Script Date: 5/15/2018 12:12:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteSmartPagePersonalization(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @UserId int)
AS
    SET NOCOUNT ON
    DECLARE @DocId uniqueidentifier
    DECLARE @Ret int
    SET @Ret = 0
    SELECT TOP 1
        @DocId = Id
    FROM
        dbo.Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName
    IF @DocId IS NULL
    BEGIN
        RETURN 2
    END
    BEGIN TRAN
    IF @UserId IS NULL    
    BEGIN
        DELETE FROM
            Personalization
        WHERE
            tp_SiteID = @SiteId AND
            tp_PageUrlID = @DocId
        IF (@@ERROR <> 0)
        BEGIN
            SET @Ret = 1
            GOTO cleanup
        END
        DELETE FROM
            WebPartLists
        WHERE
            tp_SiteID = @SiteId AND
            tp_PageUrlID = @DocId AND
            tp_UserID IS NOT NULL
        IF (@@ERROR <> 0)
        BEGIN
            SET @Ret = 1
            GOTO cleanup
        END
        DELETE FROM
            WebParts
        WHERE
            tp_SiteID = @SiteId AND
            tp_PageUrlID = @DocId AND
            tp_UserID IS NOT NULL
    END
    ELSE                    
    BEGIN
        DELETE FROM
            dbo.Personalization
        WHERE
            tp_SiteID = @SiteId AND
            tp_PageUrlID = @DocId AND
            tp_UserID = @UserId
        IF (@@ERROR <> 0)
        BEGIN
            SET @Ret = 1
            GOTO cleanup
        END
        DELETE FROM
            WebPartLists
        WHERE
            tp_SiteID = @SiteId AND
            tp_PageUrlID = @DocId AND
            tp_UserID = @UserId
        IF (@@ERROR <> 0)
        BEGIN
            SET @Ret = 1
            GOTO cleanup
        END
        DELETE FROM
            WebParts
        WHERE
            tp_SiteID = @SiteId AND
            tp_PageUrlID = @DocId AND
            tp_UserID = @UserId
        IF (@@ERROR <> 0)
        BEGIN
            SET @Ret = 1
            GOTO cleanup
        END
    END
cleanup:
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Ret

GO
