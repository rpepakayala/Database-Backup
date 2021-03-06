/****** Object:  StoredProcedure [dbo].[proc_SecAddWebMembership]    Script Date: 5/15/2018 12:12:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecAddWebMembership(
    @SiteId uniqueidentifier,
    @WebId uniqueidentifier,
    @UserId int)
AS
    SET NOCOUNT ON
    DECLARE @PermSrcWebId uniqueidentifier
    SELECT
        @PermSrcWebId = FirstUniqueAncestorWebId
    FROM
        Webs
    WHERE
        Id = @WebId
    IF @PermSrcWebId IS NULL
    BEGIN
        RETURN 3
    END
    IF NOT EXISTS(
        SELECT
            *
        FROM
            WebMembers
        WHERE
            WebId = @PermSrcWebId AND
            UserId = @UserId)
    BEGIN
        INSERT INTO WebMembers(
            WebId,
            UserId)
        VALUES(
            @PermSrcWebId,
            @UserId)
    END
    RETURN 0

GO
