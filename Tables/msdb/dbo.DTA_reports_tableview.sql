/****** Object:  Table [dbo].[DTA_reports_tableview]    Script Date: 5/15/2018 12:02:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DTA_reports_tableview](
	[TableID] [int] NOT NULL,
	[ViewID] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [DTA_reports_tableview_index]    Script Date: 5/15/2018 12:02:56 PM ******/
CREATE CLUSTERED INDEX [DTA_reports_tableview_index] ON [dbo].[DTA_reports_tableview]
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
/****** Object:  Index [DTA_reports_tableview_index2]    Script Date: 5/15/2018 12:02:56 PM ******/
CREATE NONCLUSTERED INDEX [DTA_reports_tableview_index2] ON [dbo].[DTA_reports_tableview]
(
	[ViewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
ALTER TABLE [dbo].[DTA_reports_tableview]  WITH NOCHECK ADD FOREIGN KEY([TableID])
REFERENCES [dbo].[DTA_reports_table] ([TableID])
ON DELETE CASCADE
ALTER TABLE [dbo].[DTA_reports_tableview]  WITH NOCHECK ADD FOREIGN KEY([ViewID])
REFERENCES [dbo].[DTA_reports_table] ([TableID])
GO
