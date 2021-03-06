/****** Object:  UserDefinedFunction [dbo].[fn_CanUserViewMembershipOfGroup]    Script Date: 5/15/2018 12:15:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_CanUserViewMembershipOfGroup(
    @SiteId uniqueidentifier,
    @UserId int,
    @SiteAuditor bit,
    @GroupId int,
    @BelongsToGroup bit, 
    @GroupOwnerId int,
    @CurrentUserIsOwner bit)
RETURNS bit
AS
BEGIN
    IF @SiteAuditor = 1
        RETURN 1
    IF dbo.fn_CanUserManageGroup(@SiteId, @UserId, @SiteAuditor, @GroupId, @GroupOwnerId, @CurrentUserIsOwner) = 1
        RETURN 1
    DECLARE @Flags int
    SELECT
        @Flags = Flags
    FROM
        Groups
    WHERE
        SiteId = @SiteId AND
        ID = @GroupId
    IF @Flags IS NULL
        RETURN 0
    IF (@Flags & 1) <> 0 AND
        @BelongsToGroup = 0
        RETURN 0
    RETURN 1
END

GO
