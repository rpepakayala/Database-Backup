/****** Object:  StoredProcedure [dbo].[proc_SecResetAllInheritedSubwebs]    Script Date: 5/15/2018 12:12:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecResetAllInheritedSubwebs(
    @SiteId             uniqueidentifier,
    @WebId              uniqueidentifier,
    @WebUrl             nvarchar(256), 
    @UrlLike            nvarchar(1024),
    @OldScopeId         uniqueidentifier,
    @NewScopeId         uniqueidentifier,
    @UserId             int)
AS
    BEGIN
        DECLARE @DirName nvarchar(256)
        DECLARE @LeafName nvarchar(128)
        EXEC proc_SplitUrl @WebUrl, @DirName OUTPUT, @LeafName OUTPUT
        DECLARE @PermAncestor uniqueidentifier
        SELECT
            @PermAncestor = FirstUniqueAncestorWebId
        FROM
            Webs
        WHERE
            Id = @WebId
        INSERT INTO WebMembers
            SELECT
                @WebId,
                WebMembers.UserId
            FROM
                WebMembers
            LEFT OUTER JOIN 
                WebMembers AS wm2 
            ON
                wm2.WebId = @WebId AND
                wm2.UserId = WebMembers.UserId
            WHERE
                WebMembers.WebID = @PermAncestor AND
                wm2.UserId IS NULL
        UPDATE
            Webs
        SET
            ScopeId = @NewScopeId,
            FirstUniqueAncestorWebId = @WebId
        WHERE
            SiteId = @SiteId AND
            FirstUniqueAncestorWebId = @PermAncestor AND
            (FullUrl = @WebUrl OR FullUrl LIKE @UrlLike)
        UPDATE Docs
        SET 
            ScopeId = @NewScopeId
        WHERE 
            SiteId = @SiteId AND
            ScopeId = @OldScopeId AND
            ( (DirName = @DirName AND LeafName = @LeafName) OR
               DirName = @WebUrl OR 
               DirName LIKE @UrlLike)
        UPDATE Lists
        SET 
            tp_ScopeId = @NewScopeId
        WHERE
            tp_ScopeId = @OldScopeId AND
            tp_WebId IN
                (SELECT Id
                 FROM Webs
                 WHERE
                    SiteId = @SiteId AND
                    ScopeId = @NewScopeId)
        DECLARE @userEmail nvarchar(255)
        SELECT 
            @userEmail = tp_Email 
        FROM 
            UserInfo 
        WHERE 
            tp_ID = @UserId AND 
            tp_SiteID = @SiteId
        UPDATE
            Webs
        SET
            RequestAccessEmail = @userEmail
        WHERE
            SiteId = @SiteId AND
            Id = @WebId
    END

GO
