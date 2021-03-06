/****** Object:  StoredProcedure [dbo].[proc_SecAddUser]    Script Date: 5/15/2018 12:12:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecAddUser(
    @SiteId uniqueidentifier,
    @SystemId tSystemID,
    @ExternalToken image,
    @ExternalTokenTime datetime,
    @IsDomainGroup bit,
    @IsActive bit,
    @Login nvarchar(255),
    @Title nvarchar(255),
    @Email nvarchar(255),
    @Notes nvarchar(1023),
    @MembershipWebId uniqueidentifier = NULL,
    @IncrementUserCount bit = 0,
    @ImportDeleted bit = 0,
    @AddedToTable bit OUTPUT,
    @UserIdOut int OUTPUT,
    @LoginOut nvarchar(255) OUTPUT,
    @TitleOut nvarchar(255) OUTPUT,
    @EmailOut nvarchar(255) OUTPUT,
    @NotesOut nvarchar(1023) OUTPUT,
    @DeletedOut bit OUTPUT)
AS
    SET NOCOUNT ON
    DECLARE @UserId int
    DECLARE @Deleted bit
    DECLARE @OldIsActive bit
    DECLARE @ActivateUserId int
    SET @AddedToTable = 0
    SET @UserIdOut = NULL
    SET @LoginOut = NULL
    SET @TitleOut = NULL
    SET @EmailOut = NULL
    SET @NotesOut = NULL
    IF @SystemId IS NULL
        SET @SystemId = 0x010100000000000000000000
    SELECT
        @UserId = tp_ID
    FROM
        UserInfo WITH (NOLOCK)
    WHERE
        tp_SiteId = @SiteId AND
        tp_Login = @Login AND
        tp_Deleted = 0 AND
        tp_SystemId <> @SystemId
    IF @UserId IS NOT NULL
    BEGIN
        RETURN 80
    END
    SELECT
        @UserId = tp_ID,
        @OldIsActive = tp_IsActive,
        @Deleted = CASE WHEN tp_Deleted = 0 THEN 0 ELSE 1 END
    FROM
        UserInfo
    WHERE
        tp_SiteId = @SiteId AND
        tp_SystemId = @SystemId
    DECLARE @UserIdOld int
    SET @UserIdOld = @UserId
    IF @UserId IS NULL
    BEGIN
        DECLARE @UserGuid uniqueidentifier
        SET @UserGuid = NEWID()
        IF @SystemId <> 0x010100000000000000000000
            EXEC @UserId = proc_SecGetSitePrincipalId @SiteId
        ELSE
            SET @UserId = 1073741823
        IF @IncrementUserCount = 0
        BEGIN
            INSERT INTO UserInfo(
                tp_SiteId,
                tp_ID,
                tp_DomainGroup,                
                tp_GUID,
                tp_SystemID,
                tp_ExternalToken,
                tp_ExternalTokenLastUpdated,
                tp_SiteAdmin,
                tp_IsActive,
                tp_Login,
                tp_Title,
                tp_Email,
                tp_Notes,
                tp_Deleted)
            VALUES(
                @SiteId,
                @UserId,
                @IsDomainGroup,                
                @UserGuid,
                @SystemId,
                @ExternalToken,
                @ExternalTokenTime,
                0,
                @IsActive,
                @Login,
                @Title,
                @Email,
                @Notes,
                CASE WHEN @ImportDeleted = 0 THEN 0 ELSE @UserId END)
            SET @AddedToTable = 1
            IF @IsActive = 1
            BEGIN
                SET @ActivateUserId = @UserId
            END
            EXEC proc_LogChange @SiteId, NULL, NULL, @ActivateUserId, NULL, NULL, @UserId,
                NULL, 4096, 128, NULL
        END
        ELSE
        BEGIN
            BEGIN TRAN
            DECLARE @UsersCount int
            DECLARE @UserQuota int
            SELECT
                @UsersCount = UsersCount 
            FROM
                Sites WITH (UPDLOCK) 
            WHERE
                Sites.Id = @SiteId
            SELECT
                @UserQuota = UserQuota
            FROM
                Sites 
            WHERE
                Sites.Id = @SiteId
            IF ((@UserQuota <> 0) AND (@UserQuota <= @UsersCount))
            BEGIN
                ROLLBACK
                RETURN 1816
            END
            UPDATE
                Sites
            SET
                UsersCount = @UsersCount + 1
            WHERE
                Id = @SiteId
            INSERT INTO UserInfo(
                tp_SiteId,
                tp_ID,
                tp_DomainGroup,                
                tp_GUID,
                tp_SystemID,
                tp_ExternalToken,
                tp_ExternalTokenLastUpdated,
                tp_SiteAdmin,
                tp_IsActive,
                tp_Login,
                tp_Title,
                tp_Email,
                tp_Notes,
                tp_Deleted)
            VALUES(
                @SiteId,
                @UserId,
                @IsDomainGroup,                
                @UserGuid,
                @SystemId,
                @ExternalToken,
                @ExternalTokenTime,
                0,
                @IsActive,
                @Login,
                @Title,
                @Email,
                @Notes,
                CASE WHEN @ImportDeleted = 0 THEN 0 ELSE @UserId END)
            SET @AddedToTable = 1
            IF @IsActive = 1
            BEGIN
                SET @ActivateUserId = @UserId
            END
            EXEC proc_LogChange @SiteId, NULL, NULL, @ActivateUserId, NULL, NULL, @UserId,
                NULL, 4096, 128, NULL
            COMMIT TRAN
        END
    END
    ELSE IF @Deleted = 1
    BEGIN
        UPDATE
            UserInfo
        SET
            tp_Deleted = 0,
            tp_SiteAdmin = 0,
            tp_IsActive = @IsActive,
            tp_ExternalToken = @ExternalToken,
            tp_ExternalTokenLastUpdated = @ExternalTokenTime,
            tp_Login = @Login,
            tp_DomainGroup = @IsDomainGroup,
            tp_Title = @Title,
            tp_Email = @Email,
            tp_Notes = @Notes
        WHERE
            tp_SiteId = @SiteId AND
            tp_ID = @UserId
        IF @IsActive = 1
        BEGIN
            SET @ActivateUserId = @UserId
        END
        EXEC proc_LogChange @SiteId, NULL, NULL, @ActivateUserId, NULL, NULL, @UserId,
            NULL, 4096, 128, NULL
    END
    ELSE
    BEGIN
        UPDATE
            UserInfo
        SET
            tp_Login = @Login,
            tp_IsActive = @IsActive,
            tp_Email = CASE WHEN LEN(tp_Email) = 0 THEN @Email ELSE
                tp_Email END,
            tp_ExternalToken = CASE 
                WHEN @ExternalToken IS NULL THEN tp_ExternalToken
                ELSE @ExternalToken END,
            tp_ExternalTokenLastUpdated = CASE
                WHEN @ExternalTokenTime IS NULL THEN tp_ExternalTokenLastUpdated
                ELSE @ExternalTokenTime END
        WHERE
            tp_SiteId = @SiteId AND
            tp_ID = @UserId
        IF @IsActive = 1 AND @IsActive <> @OldIsActive
        BEGIN
            SET @ActivateUserId = @UserId
        END        
        EXEC proc_LogChange @SiteId, NULL, NULL, @ActivateUserId, NULL, NULL, @UserId,
            NULL, 8192, 128, NULL
    END
    IF @IsDomainGroup = 1
    BEGIN
        EXEC proc_SecUpdateSiteLevelSecurityMetadata @SiteId, 0, 1
    END
    IF @UserIdOld IS NOT NULL
    BEGIN
        UPDATE
            ImmedSubscriptions
        SET
            UserEmail = CASE 
                WHEN (@Deleted <> 1 AND LEN(UserEmail) <> 0)
                THEN UserEmail
                ELSE @Email
                END
        WHERE
            SiteId = @SiteId AND
            UserId = @UserId
        UPDATE
            SchedSubscriptions
        SET
            UserEmail = CASE 
                WHEN (@Deleted <> 1 AND LEN(UserEmail) <> 0)
                THEN UserEmail
                ELSE @Email
                END
        WHERE
            SiteId = @SiteId AND
            UserId = @UserId
    END
    IF @MembershipWebId IS NOT NULL
    BEGIN
        EXEC proc_SecAddWebMembership
            @SiteId,
            @MembershipWebId,
            @UserId
    END
    SELECT 
        @UserIdOut = tp_ID,
        @LoginOut = tp_Login,
        @TitleOut = tp_Title,
        @EmailOut = tp_Email,
        @NotesOUt = tp_Notes,
        @Deleted = CASE WHEN tp_Deleted = 0 THEN 0 ELSE 1 END
    FROM
        UserInfo
    WHERE
        tp_SiteId = @SiteId AND
        tp_ID = @UserId
    RETURN 0

GO
