/****** Object:  Table [dbo].[DTA_reports_queryindex]    Script Date: 5/15/2018 12:02:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DTA_reports_queryindex](
	[QueryID] [int] NOT NULL,
	[SessionID] [int] NOT NULL,
	[IndexID] [int] NOT NULL,
	[IsRecommendedConfiguration] [bit] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [DTA_reports_queryindex_index]    Script Date: 5/15/2018 12:02:56 PM ******/
CREATE CLUSTERED INDEX [DTA_reports_queryindex_index] ON [dbo].[DTA_reports_queryindex]
(
	[SessionID] ASC,
	[QueryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
/****** Object:  Index [DTA_reports_queryindex_index2]    Script Date: 5/15/2018 12:02:56 PM ******/
CREATE NONCLUSTERED INDEX [DTA_reports_queryindex_index2] ON [dbo].[DTA_reports_queryindex]
(
	[IndexID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
ALTER TABLE [dbo].[DTA_reports_queryindex]  WITH NOCHECK ADD  CONSTRAINT [DTA_reports_queryindex_fk] FOREIGN KEY([SessionID], [QueryID])
REFERENCES [dbo].[DTA_reports_query] ([SessionID], [QueryID])
ON DELETE CASCADE
ALTER TABLE [dbo].[DTA_reports_queryindex] CHECK CONSTRAINT [DTA_reports_queryindex_fk]
ALTER TABLE [dbo].[DTA_reports_queryindex]  WITH NOCHECK ADD FOREIGN KEY([IndexID])
REFERENCES [dbo].[DTA_reports_index] ([IndexID])
GO
