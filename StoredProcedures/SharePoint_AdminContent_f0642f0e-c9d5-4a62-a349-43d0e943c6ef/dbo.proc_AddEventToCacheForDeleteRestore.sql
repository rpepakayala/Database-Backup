/****** Object:  StoredProcedure [dbo].[proc_AddEventToCacheForDeleteRestore]    Script Date: 5/15/2018 12:12:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddEventToCacheForDeleteRestore(
    @SiteId             uniqueidentifier,
    @WebId              uniqueidentifier,
    @ListId             uniqueidentifier,
    @ItemId             int,
    @ItemName           nvarchar(255),
    @ItemFullUrl        nvarchar(260),
    @DocId uniqueidentifier, 
    @EventType          int,
    @UserId             int,
    @TimeLastModified   datetime,
    @EventData          image,
    @ACL                image)
AS
    DECLARE @UserTitle nvarchar(255)
    IF (@UserId = 0)
    BEGIN
        SET @UserTitle = N''
    END
    ELSE
    BEGIN
        DECLARE @ListFlags bigint
        SELECT
            @ListFlags = tp_Flags
        FROM
            Lists
        WHERE
            tp_WebId = @WebId AND
            tp_Id = @ListId
        IF (@ListFlags & 0x1000) = 0
        BEGIN
            SET @UserTitle = N'***'
        END
        ELSE
        BEGIN
            SELECT
                @UserTitle = tp_Title
            FROM
                UserInfo
            WHERE
                tp_SiteID = @SiteId AND 
                tp_ID = @UserId
        END
    END
    EXEC proc_AddEventToCache
        @SiteId,
        @WebId,
        @ListId,
        @ItemId,
        @ItemName,
        @ItemFullUrl,
        @DocId,
        @EventType,
        @UserTitle,
        @TimeLastModified,
        @EventData,
        @ACL
    RETURN 0

GO
