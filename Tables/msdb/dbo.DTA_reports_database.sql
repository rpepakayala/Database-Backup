/****** Object:  Table [dbo].[DTA_reports_database]    Script Date: 5/15/2018 12:02:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DTA_reports_database](
	[DatabaseID] [int] IDENTITY(1,1) NOT NULL,
	[SessionID] [int] NOT NULL,
	[DatabaseName] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsDatabaseSelectedToTune] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DatabaseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [DTA_reports_database_index]    Script Date: 5/15/2018 12:02:55 PM ******/
CREATE NONCLUSTERED INDEX [DTA_reports_database_index] ON [dbo].[DTA_reports_database]
(
	[SessionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
ALTER TABLE [dbo].[DTA_reports_database]  WITH CHECK ADD FOREIGN KEY([SessionID])
REFERENCES [dbo].[DTA_input] ([SessionID])
ON DELETE CASCADE
GO
