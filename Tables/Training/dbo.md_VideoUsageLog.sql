/****** Object:  Table [dbo].[md_VideoUsageLog]    Script Date: 5/15/2018 12:07:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[md_VideoUsageLog](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[VideoID] [int] NOT NULL,
	[WebNumber] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[VideoRuntime] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PageDuration] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VideoDuration] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LogDateTime] [datetime] NOT NULL,
	[ViewingStatus] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_md_video_usage_log] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
