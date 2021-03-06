/****** Object:  Table [dbo].[DTA_reports_column]    Script Date: 5/15/2018 12:02:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DTA_reports_column](
	[ColumnID] [int] IDENTITY(1,1) NOT NULL,
	[TableID] [int] NOT NULL,
	[ColumnName] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ColumnID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [DTA_reports_column_index]    Script Date: 5/15/2018 12:02:54 PM ******/
CREATE NONCLUSTERED INDEX [DTA_reports_column_index] ON [dbo].[DTA_reports_column]
(
	[TableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[DTA_reports_column]  WITH NOCHECK ADD FOREIGN KEY([TableID])
REFERENCES [dbo].[DTA_reports_table] ([TableID])
ON DELETE CASCADE
GO
