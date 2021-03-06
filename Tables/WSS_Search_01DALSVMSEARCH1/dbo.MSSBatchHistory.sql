/****** Object:  Table [dbo].[MSSBatchHistory]    Script Date: 5/15/2018 12:09:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSBatchHistory](
	[BatchID] [int] IDENTITY(1,1) NOT NULL,
	[CrawlID] [int] NOT NULL,
	[Stamp] [datetime] NOT NULL
) ON [PRIMARY]

ALTER TABLE [dbo].[MSSBatchHistory] ADD  CONSTRAINT [DF_MSSBatchHistory_Stamp]  DEFAULT (getdate()) FOR [Stamp]
GO
