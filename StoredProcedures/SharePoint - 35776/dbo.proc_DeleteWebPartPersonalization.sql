/****** Object:  StoredProcedure [dbo].[proc_DeleteWebPartPersonalization]    Script Date: 5/15/2018 12:11:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteWebPartPersonalization(
    @SiteId uniqueidentifier,
    @DirName nvarchar(256),
    @LeafName nvarchar(128),
    @UserId int,
    @WebPartID uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @DocId uniqueidentifier
    DECLARE @PartDocId uniqueidentifier
    DECLARE @Ret int
    SET @Ret = 0
    SELECT TOP 1
        @DocId = Id
    FROM
        Docs
    WHERE
        SiteId = @SiteId AND
        DirName = @DirName AND
        LeafName = @LeafName
    IF @DocId IS NULL
    BEGIN
        RETURN 2
    END
    SELECT TOP 1
        @PartDocId=tp_PageUrlID
    FROM
        WebParts
    WHERE
        tp_SiteID = @SiteId AND
        tp_ID = @WebPartID
    IF (@DocId <> @PartDocId)
    BEGIN
        RETURN 5
    END
    BEGIN TRAN
    IF @UserId IS NULL                
    BEGIN
        DELETE FROM
            Personalization
        WHERE
            tp_SiteID = @SiteId AND
            tp_PageUrlID = @DocId AND
            tp_WebPartID = @WebPartID
    END
    ELSE
    BEGIN
        DELETE FROM
            dbo.Personalization
        WHERE
            tp_SiteID = @SiteId AND
            tp_PageUrlID = @DocId AND
            tp_UserID = @UserId AND
            tp_WebPartID = @WebPartID
    END
    IF (@@ERROR <> 0 OR @Ret <> 0)
    BEGIN
        IF (@Ret = 0)
            SET @Ret = 1
        GOTO cleanup
    END
cleanup:
    IF (@Ret <> 0 AND @@TRANCOUNT = 1) ROLLBACK TRAN ELSE COMMIT TRAN
    RETURN @Ret

GO
