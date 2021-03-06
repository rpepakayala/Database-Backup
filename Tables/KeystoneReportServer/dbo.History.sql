/****** Object:  Table [dbo].[History]    Script Date: 5/15/2018 12:02:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[History](
	[HistoryID] [uniqueidentifier] NOT NULL,
	[ReportID] [uniqueidentifier] NOT NULL,
	[SnapshotDataID] [uniqueidentifier] NOT NULL,
	[SnapshotDate] [datetime] NOT NULL,
 CONSTRAINT [PK_History] PRIMARY KEY NONCLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_History]    Script Date: 5/15/2018 12:02:20 PM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_History] ON [dbo].[History]
(
	[ReportID] ASC,
	[SnapshotDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_SnapshotDataID]    Script Date: 5/15/2018 12:02:20 PM ******/
CREATE NONCLUSTERED INDEX [IX_SnapshotDataID] ON [dbo].[History]
(
	[SnapshotDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Trigger [dbo].[History_Notifications]    Script Date: 5/15/2018 12:02:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE TRIGGER [dbo].[History_Notifications] ON [dbo].[History]  
AFTER INSERT
AS 
   insert
      into [dbo].[Event]
      ([EventID], [EventType], [EventData], [TimeEntered]) 
      select NewID(), 'ReportHistorySnapshotCreated', inserted.[HistoryID], GETUTCDATE()
   from inserted

/****** Object:  Trigger [dbo].[HistoryDelete_SnapshotRefcount]    Script Date: 5/15/2018 12:02:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE TRIGGER [dbo].[HistoryDelete_SnapshotRefcount] ON [dbo].[History] 
AFTER DELETE
AS
   UPDATE [dbo].[SnapshotData]
   SET [PermanentRefcount] = [PermanentRefcount] - 1
   FROM [SnapshotData] SD INNER JOIN deleted D on SD.[SnapshotDataID] = D.[SnapshotDataID]

GO
