/****** Object:  StoredProcedure [dbo].[proc_putEmailEnabledList]    Script Date: 5/15/2018 12:13:07 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_putEmailEnabledList
(
    @Alias nvarchar(128),
    @SiteId uniqueidentifier, 
    @WebId uniqueidentifier,
    @ListId uniqueidentifier
) AS
    SET NOCOUNT ON
    BEGIN TRAN
    DECLARE @OldSiteId uniqueidentifier
    DECLARE @OldWebId uniqueidentifier
    DECLARE @OldListId uniqueidentifier
    DECLARE @OldDeleted bit
    SELECT
        @OldSiteId = SiteId,
        @OldWebId = WebId,
        @OldListId = ListId,
        @OldDeleted = Deleted
    FROM
        dbo.EmailEnabledLists WITH (UPDLOCK, SERIALIZABLE)
    WHERE
        Alias = @Alias
    IF (@OldSiteId IS NOT NULL)
    BEGIN
        IF (@OldSiteId = @SiteId AND
            @OldWebId = @WebId AND
            @OldListId = @ListId AND
            @OldDeleted = 0)
        BEGIN
            COMMIT TRAN
            RETURN 0
        END
        ELSE
        BEGIN
            ROLLBACK TRAN
            RETURN 1
        END
    END
    UPDATE 
        dbo.EmailEnabledLists
    SET
        Alias = @Alias
    WHERE
        SiteId = @SiteId AND
        WebId = @WebId AND
        ListId = @ListId AND
        Deleted = 0
    IF (@@rowcount = 0)
    BEGIN
        INSERT INTO dbo.EmailEnabledLists
        (
            Alias,
            SiteId, 
            WebId,
            ListId,
            Deleted
        )
        VALUES
        (
            @Alias,
            @SiteId, 
            @WebId,
            @ListId,
            0
        )
    END
    COMMIT TRAN
    RETURN 0 

GO
