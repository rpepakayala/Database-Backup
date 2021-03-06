/****** Object:  StoredProcedure [dbo].[md_VideoRemove]    Script Date: 5/15/2018 12:13:20 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE md_VideoRemove 
(
	@videoID int
)
AS

DELETE FROM md_VideosInCategories 
	WHERE videoID = @videoID

DELETE FROM md_RelatedLinksInVideos
	WHERE videoID = @videoID

DELETE FROM md_videos
	WHERE videoID = @videoID
GO
