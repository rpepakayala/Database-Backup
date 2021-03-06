/****** Object:  StoredProcedure [dbo].[md_VideoUsageStatsSelect]    Script Date: 5/15/2018 12:13:21 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE md_VideoUsageStatsSelect AS
SELECT 
	A.videoID, 
	A.title, 
        MAX(VideoDuration) as  duration,
	(
	     SELECT 
 			COUNT(videoID) 
	     FROM 
			md_videoUsageLog 
	     WHERE 
			YEAR(logDateTime) = YEAR(GETDATE()) 
	     AND 
			videoID = A.videoID 
        ) AS YTD,
	
        (
	     SELECT 
 			COUNT(videoID) 
	     FROM 
			md_videoUsageLog 
	     WHERE 
			YEAR(logDateTime) = YEAR(GETDATE()) 
	     AND 
			MONTH(logDateTime) = MONTH(GETDATE())
	     AND
			videoID = A.videoID
        ) AS MTD, 
        (
	     SELECT 
 			COUNT(videoID) 
	     FROM 
			md_videoUsageLog 
	     WHERE 
			YEAR(logDateTime) = YEAR(GETDATE()) 
	     AND 
			MONTH(logDateTime) = MONTH(GETDATE())
	     AND
			DAY(logDateTime) = DAY(GETDATE())
	     AND
			videoID = A.videoID
        ) AS Today
 
from md_videos A
left join md_videoUsageLog B
on A.videoID = B.VideoID
group by A.videoID, A.title
ORDER BY A.VideoID

GO
