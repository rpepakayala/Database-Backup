/****** Object:  Table [dbo].[DTA_input]    Script Date: 5/15/2018 12:02:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DTA_input](
	[SessionName] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SessionID] [int] IDENTITY(1,1) NOT NULL,
	[TuningOptions] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[ScheduledStartTime] [datetime] NOT NULL,
	[ScheduledJobName] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[InteractiveStatus] [tinyint] NOT NULL,
	[LogTableName] [nvarchar](1280) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[GlobalSessionID] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[SessionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[DTA_input] ADD  DEFAULT (getdate()) FOR [CreationTime]
ALTER TABLE [dbo].[DTA_input] ADD  DEFAULT (getdate()) FOR [ScheduledStartTime]
ALTER TABLE [dbo].[DTA_input] ADD  DEFAULT ('') FOR [ScheduledJobName]
ALTER TABLE [dbo].[DTA_input] ADD  DEFAULT ((0)) FOR [InteractiveStatus]
ALTER TABLE [dbo].[DTA_input] ADD  DEFAULT ('') FOR [LogTableName]
ALTER TABLE [dbo].[DTA_input] ADD  DEFAULT (newid()) FOR [GlobalSessionID]
GO
