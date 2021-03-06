/****** Object:  StoredProcedure [dbo].[proc_SetSiteProps]    Script Date: 5/15/2018 12:13:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SetSiteProps(
    @SiteId uniqueidentifier,
    @OwnerID int,
    @SecondaryContactID int)
AS
    SET NOCOUNT ON
    UPDATE
        Sites
    SET 
        OwnerID           = @OwnerID,
        SecondaryContactID= @SecondaryContactID
    WHERE
        Id = @SiteId
    IF @@ROWCOUNT = 1
    BEGIN
        IF @OwnerID IS NOT NULL
            EXEC proc_SecUpdateUserActiveStatus @SiteId, @OwnerID
        IF @SecondaryContactID IS NOT NULL
            EXEC proc_SecUpdateUserActiveStatus @SiteId, @SecondaryContactID
        EXEC proc_LogChange @SiteId, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
            8192,  8, NULL
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN 3
    END

GO
