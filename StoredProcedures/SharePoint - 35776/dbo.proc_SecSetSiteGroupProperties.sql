/****** Object:  StoredProcedure [dbo].[proc_SecSetSiteGroupProperties]    Script Date: 5/15/2018 12:12:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecSetSiteGroupProperties(
    @SiteId         uniqueidentifier,
    @GroupId        int,
    @Title          nvarchar(255),
    @Description    nvarchar(512),
    @OwnerID        int,
    @OwnerIsUser    bit,
    @UserID         int,
    @SiteAdmin      bit,
    @GroupOwnerId   int,
    @CurrentUserIsOwner bit,
    @DLAlias        nvarchar(255),
    @DLErrorMessage nvarchar(255),
    @DLFlags        int,
    @DLJobId        int,
    @DLArchives     varchar(4000),
    @RequestEmail   nvarchar(255),
    @Flags          int)
AS
    SET NOCOUNT ON
    IF dbo.fn_CanUserManageGroup(@SiteId, @UserId, @SiteAdmin, @GroupId, @GroupOwnerId, @CurrentUserIsOwner) = 0 RETURN 5
    UPDATE
        Groups
    SET
        Title = @Title,
        Description = @Description,
        Owner = @OwnerID,
        OwnerIsUser = @OwnerIsUser,
        DLAlias = @DLAlias,
        DLErrorMessage = @DLErrorMessage,
        DLFlags = @DLFlags,
        DLJobId = @DLJobId,
        DLArchives = @DLArchives,
        RequestEmail = @RequestEmail,
        Flags = @Flags
    WHERE
        SiteId = @SiteId AND
        ID = @GroupId
    IF (0 <> @@error)
    BEGIN
        RETURN 80
    END
    ELSE
    BEGIN
    IF (@OwnerIsUser = 1)
    BEGIN
        EXEC proc_SecUpdateUserActiveStatus @SiteId, @OwnerID
    END
    EXEC proc_LogChange @SiteId, NULL, NULL, NULL, NULL, NULL, @GroupId,
        NULL, 8192, 256, NULL
        RETURN 0
    END

GO
