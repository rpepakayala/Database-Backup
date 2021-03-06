/****** Object:  StoredProcedure [dbo].[FS_GetUnreadPosts]    Script Date: 5/15/2018 12:09:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		Name
-- Create date: 25.7.2007
-- Description:	Stores log records to DB
-- =============================================
CREATE PROCEDURE [dbo].[FS_GetUnreadPosts]
	@UserID int,
	@GroupID int,
	@ForumID int,
    @PostID int
AS
BEGIN
	--DECLARE @UserID INT
	--DECLARE @GroupID INT
	--DECLARE @ForumID INT
	--DECLARE @PostID INT
	--SET @UserID = 83
	--SET @GroupID = 5
	--SET @ForumID = 7 --7
	--SET @PostID = 35 --35

	-- SHOW ALL UNREAD FORUMS FOR A GROUP
	IF @GroupID <> 0 AND @ForumID = 0 AND @PostID = 0 -- CMSModules/Forums/Controls/Layouts/Flat/forum.ascx
	BEGIN
		SELECT DISTINCT ForumGroupID,PostForumID, NULL AS PostID, NULL AS PostParentID, 0 AS ReadPost
		FROM Forums_ForumPost p WITH (NOLOCK)
		INNER JOIN dbo.Forums_Forum f WITH (NOLOCK) ON f.forumid = p.postforumid
		WHERE f.ForumGroupID = @GroupID 
		AND postID NOT IN ( SELECT postID 
							FROM dbo.FS_Forums_UserRead r WITH (NOLOCK)
							WHERE p.postid = r.postid AND userid = @UserID )
		AND p.postuserid != @UserID
	END 
	ELSE IF @GroupID <> 0 AND @ForumID <> 0 AND @PostID = 0  -- threads.ascx. SHOW ALL UNREAD THREADS FOR A FORUM
	BEGIN
		SELECT DISTINCT ForumGroupID,PostForumID,
			CASE 
				WHEN PostParentID IS NOT NULL
					THEN dbo.GetTopLevelPostID(PostParentID)
				ELSE
					PostID
			END AS PostID, null AS PostParentID, 0 AS ReadPost
		FROM Forums_ForumPost p WITH (NOLOCK)
		INNER JOIN dbo.Forums_Forum f WITH (NOLOCK) ON f.forumid = p.postforumid
		WHERE f.ForumGroupID = @GroupID AND p.PostForumID = @ForumID
		AND postID NOT IN ( SELECT postID 
							FROM dbo.FS_Forums_UserRead r WITH (NOLOCK)
							WHERE p.postid = r.postid AND userid = @UserID )
		AND p.postuserid != @UserID
	END 
	ELSE  -- thread.ascx. SHOW ALL UNREAD POST UNDER A THREAD
	BEGIN
		SELECT DISTINCT f.ForumGroupID,p.PostForumID,p.PostID,p.PostParentID, 0 AS ReadPost
		FROM Forums_ForumPost p WITH (NOLOCK)
		INNER JOIN dbo.Forums_Forum f WITH (NOLOCK) ON f.forumid = p.postforumid
		WHERE f.ForumGroupID = @GroupID AND p.PostForumID = @ForumID
		AND postID IN (	SELECT DISTINCT * FROM dbo.GetAllRelatedPosts(@PostID, @UserID) )
		AND p.postuserid != @UserID
	END
END

GO
