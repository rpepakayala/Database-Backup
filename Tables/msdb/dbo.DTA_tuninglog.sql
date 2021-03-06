/****** Object:  Table [dbo].[DTA_tuninglog]    Script Date: 5/15/2018 12:02:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DTA_tuninglog](
	[SessionID] [int] NOT NULL,
	[RowID] [int] NOT NULL,
	[CategoryID] [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Event] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Statement] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Frequency] [int] NOT NULL,
	[Reason] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [DTA_tuninglog_index]    Script Date: 5/15/2018 12:02:56 PM ******/
CREATE CLUSTERED INDEX [DTA_tuninglog_index] ON [dbo].[DTA_tuninglog]
(
	[SessionID] ASC,
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
ALTER TABLE [dbo].[DTA_tuninglog]  WITH NOCHECK ADD FOREIGN KEY([SessionID])
REFERENCES [dbo].[DTA_input] ([SessionID])
ON DELETE CASCADE
GO
