/****** Object:  Table [dbo].[MSSCrawlHistory]    Script Date: 5/15/2018 12:09:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSCrawlHistory](
	[CrawlID] [int] IDENTITY(40,1) NOT NULL,
	[ProjectID] [int] NOT NULL,
	[CrawlType] [int] NOT NULL,
	[RequestTime] [datetime] NOT NULL,
	[Status] [int] NOT NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
 CONSTRAINT [PK_WSSCrawlHistory] PRIMARY KEY CLUSTERED 
(
	[CrawlID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[MSSCrawlHistory] ADD  CONSTRAINT [DF_WSSCrawlHistory_RequestTime]  DEFAULT (getdate()) FOR [RequestTime]
ALTER TABLE [dbo].[MSSCrawlHistory] ADD  CONSTRAINT [DF_MSSCrawlHistory_Status]  DEFAULT ((0)) FOR [Status]
GO
