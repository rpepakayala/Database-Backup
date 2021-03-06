/****** Object:  StoredProcedure [dbo].[proc_SecUpdateUser]    Script Date: 5/15/2018 12:12:59 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecUpdateUser(
    @SiteId uniqueidentifier,
    @CurrentUserId int,
    @UserIdToUpdate int,
    @Title nvarchar(255),
    @Email nvarchar(255),
    @Notes nvarchar(1023),
    @SiteAdmin bit) 
AS
    SET NOCOUNT ON
    IF @SiteAdmin = 0
    BEGIN
        DECLARE @SiteOwnerId        int
        DECLARE @SecondaryContactId int
        DECLARE @OtherAdminId       int
        SELECT
            @SiteOwnerId        = OwnerID,
            @SecondaryContactId = SecondaryContactID
        FROM
            Sites
        WHERE
            Id = @SiteId
        SELECT TOP 1
            @OtherAdminId = tp_Id
        FROM
            UserInfo
        WHERE    
            tp_SiteId = @SiteId AND
            tp_Id <> @UserIdToUpdate AND
            tp_DomainGroup = 0 AND
            tp_Deleted = 0 AND
            tp_SiteAdmin = 1
        IF @OtherAdminId IS NULL
            RETURN 4335
        IF @UserIdToUpdate = @SiteOwnerId OR 
            @UserIdToUpdate = @SecondaryContactId
        BEGIN        
            DECLARE @IsCurrentUserSiteAdmin bit
            DECLARE @NomineeId int
            SELECT 
                @IsCurrentUserSiteAdmin = tp_SiteAdmin
            FROM
                UserInfo
            WHERE
                tp_SiteId = @SiteId AND
                tp_Id = @CurrentUserId AND
                tp_DomainGroup = 0 AND
                tp_Deleted = 0
            IF @IsCurrentUserSiteAdmin = 1 AND @CurrentUserId <> @UserIdToUpdate
            BEGIN
                SET @NomineeId = @CurrentUserId
            END
            ELSE
            BEGIN
                SET @NomineeId = @OtherAdminId
            END
            IF @SiteOwnerId = @UserIdToUpdate
            BEGIN
                SET @SiteOwnerId = @NomineeId
            END
            IF @SecondaryContactId = @UserIdToUpdate
            BEGIN
                SET @SecondaryContactId = @NomineeId
            END
            IF @SecondaryContactId = @SiteOwnerId
            BEGIN
               SET @SecondaryContactId = NULL 
            END
            UPDATE
                Sites
            SET
                OwnerID = @SiteOwnerId,
                SecondaryContactID = @SecondaryContactId
            WHERE
                Id = @SiteId
        END
    END
    ELSE IF @SiteAdmin = 1
    BEGIN
        IF ((SELECT
            tp_DomainGroup
            FROM
                UserInfo
            WHERE
                tp_SiteId = @SiteId AND
                tp_Id = @UserIdToUpdate) = 1)
        BEGIN
            RETURN 1399
        END
    END
    DECLARE @WasUserToUpdateSiteAdmin bit
    SELECT 
        @WasUserToUpdateSiteAdmin = tp_SiteAdmin
    FROM
        UserInfo
    WHERE
        tp_SiteId = @SiteId AND
        tp_Id = @UserIdToUpdate
    UPDATE
        UserInfo
    SET
        tp_Title = @Title,
        tp_Email = @Email,
        tp_Notes = @Notes,
        tp_SiteAdmin = COALESCE(@SiteAdmin, tp_SiteAdmin)
    WHERE
        tp_SiteId = @SiteId AND
        tp_Id = @UserIdToUpdate
    DECLARE @data nvarchar(255)
    DECLARE @FlagsChangeUser int
    IF @SiteAdmin <> @WasUserToUpdateSiteAdmin 
    BEGIN
        DECLARE @auditEvent int
        IF @SiteAdmin = 1
        BEGIN
            SET @auditEvent = 32
        END
        ELSE
        BEGIN
            SET @auditEvent = 33
        END
        SET @data = '<siteadmin />' + STUFF(STUFF('</>', 3, 0, 'user'), 1, 0, STUFF(CONVERT(nvarchar(64), @UserIdToUpdate), 1, 0, STUFF('<>', 2, 0, 'user')))
        EXEC proc_AddSiteAuditEntryFromSql 
            @SiteId, 
            @CurrentUserId, 
            @auditEvent,
            @data,
            0x00000100    
        SET @FlagsChangeUser = 1
    END
    ELSE
    BEGIN
        SET @FlagsChangeUser = 0
    END
    EXEC proc_LogChange @SiteId, NULL, NULL, NULL, NULL, NULL, @UserIdToUpdate,
        NULL, 8192, 128, NULL, NULL, @FlagsChangeUser
    IF @SiteAdmin IS NOT NULL
    BEGIN
        EXEC proc_SecUpdateSiteLevelSecurityMetadata @SiteId, 0, 0
    END
    UPDATE
        ImmedSubscriptions
    SET
        UserEmail = @Email
    WHERE
        SiteId = @SiteId AND
        UserId = @UserIdToUpdate
    UPDATE
        SchedSubscriptions
    SET
        UserEmail = @Email
    WHERE
        SiteId = @SiteId AND
        UserId = @UserIdToUpdate
    RETURN 0

GO
