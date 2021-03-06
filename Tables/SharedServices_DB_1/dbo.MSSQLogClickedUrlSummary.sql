/****** Object:  Table [dbo].[MSSQLogClickedUrlSummary]    Script Date: 5/15/2018 12:05:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSQLogClickedUrlSummary](
	[searchDate] [smalldatetime] NULL,
	[siteId] [int] NULL,
	[clickedUrlId] [int] NULL,
	[numClicks] [int] NULL
) ON [PRIMARY]

/****** Object:  Index [PK_MSSQLogClickedUrlSummary]    Script Date: 5/15/2018 12:05:15 PM ******/
CREATE CLUSTERED INDEX [PK_MSSQLogClickedUrlSummary] ON [dbo].[MSSQLogClickedUrlSummary]
(
	[searchDate] ASC,
	[siteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
