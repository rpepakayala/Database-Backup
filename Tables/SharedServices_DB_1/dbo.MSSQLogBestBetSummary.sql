/****** Object:  Table [dbo].[MSSQLogBestBetSummary]    Script Date: 5/15/2018 12:05:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSQLogBestBetSummary](
	[searchDate] [smalldatetime] NULL,
	[siteId] [int] NULL,
	[bestBetId] [int] NULL,
	[numClicks] [int] NULL
) ON [PRIMARY]

/****** Object:  Index [PK_MSSQLogBestBetSummary]    Script Date: 5/15/2018 12:05:14 PM ******/
CREATE CLUSTERED INDEX [PK_MSSQLogBestBetSummary] ON [dbo].[MSSQLogBestBetSummary]
(
	[searchDate] ASC,
	[siteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
