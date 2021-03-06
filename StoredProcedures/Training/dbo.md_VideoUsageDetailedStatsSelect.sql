/****** Object:  StoredProcedure [dbo].[md_VideoUsageDetailedStatsSelect]    Script Date: 5/15/2018 12:13:21 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE PROCEDURE md_VideoUsageDetailedStatsSelect 
(
	@videoID int
)
AS

-- YTD
SELECT 
	videoID, 
	ViewingStatus,
	"ytd" AS  ResultType,
        	Count(videoID) AS Total
FROM 
	md_videoUsageLog
WHERE 
	YEAR(logDateTime) = YEAR(GETDATE()) 
AND 
	VideoID = @videoID
GROUP BY 
	VideoID, 
	ViewingStatus

-- MTD
SELECT 
	videoID, 
	ViewingStatus,
             "mtd" AS  ResultType,
	 Count(videoID) AS Total
FROM 
	md_videoUsageLog
WHERE 
	YEAR(logDateTime) = YEAR(GETDATE()) 
AND 
	MONTH(logDateTime) = MONTH(GETDATE())
AND 
	VideoID = @videoID
GROUP BY 
	VideoID, 
	ViewingStatus


-- TODAY
SELECT 
	videoID, 
	ViewingStatus,
	"today" AS  ResultType,
	Count(videoID) AS Total
FROM 
	md_videoUsageLog
WHERE 
	YEAR(logDateTime) = YEAR(GETDATE()) 
AND 
	MONTH(logDateTime) = MONTH(GETDATE())
AND 
	DAY(logDateTime) = DAY(GETDATE())
AND
	VideoID = @videoID
GROUP BY 
	VideoID, 
	ViewingStatus

GO
