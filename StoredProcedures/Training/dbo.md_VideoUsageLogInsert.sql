/****** Object:  StoredProcedure [dbo].[md_VideoUsageLogInsert]    Script Date: 5/15/2018 12:13:21 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE  md_VideoUsageLogInsert
(
   @VideoID INT,
   @WebNumber INT,
   @UserID INT,
   @VideoRunTime varchar(15),
   @PageDuration varchar(15),
   @VideoDuration varchar(15),
   @LogDateTime DATETIME,
   @ViewingStatus VARCHAR (10)
)

AS

INSERT INTO md_VideoUsageLog 
(
 	VideoID,
	WebNumber,
	UserID,
	VideoRunTime,
	PageDuration,
             VideoDuration,
	LogDateTime,
	ViewingStatus
)
VALUES
(
	@VideoID,
	@WebNumber,
	@UserID,
	@VideoRunTime,
             @PageDuration,
	@VideoDuration,
             @LogDatetime,
	@ViewingStatus
)

GO
