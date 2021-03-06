/****** Object:  Table [dbo].[DTA_progress]    Script Date: 5/15/2018 12:02:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DTA_progress](
	[ProgressEventID] [int] IDENTITY(1,1) NOT NULL,
	[SessionID] [int] NULL,
	[TuningStage] [tinyint] NOT NULL,
	[WorkloadConsumption] [tinyint] NOT NULL,
	[EstImprovement] [int] NOT NULL,
	[ProgressEventTime] [datetime] NOT NULL,
	[ConsumingWorkLoadMessage] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PerformingAnalysisMessage] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GeneratingReportsMessage] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

/****** Object:  Index [DTA_progress_index]    Script Date: 5/15/2018 12:02:54 PM ******/
CREATE CLUSTERED INDEX [DTA_progress_index] ON [dbo].[DTA_progress]
(
	[SessionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
ALTER TABLE [dbo].[DTA_progress] ADD  DEFAULT ((0)) FOR [TuningStage]
ALTER TABLE [dbo].[DTA_progress] ADD  DEFAULT ((0)) FOR [EstImprovement]
ALTER TABLE [dbo].[DTA_progress] ADD  DEFAULT (getdate()) FOR [ProgressEventTime]
ALTER TABLE [dbo].[DTA_progress]  WITH CHECK ADD FOREIGN KEY([SessionID])
REFERENCES [dbo].[DTA_input] ([SessionID])
ON DELETE CASCADE
ALTER TABLE [dbo].[DTA_progress]  WITH CHECK ADD CHECK  (([WorkloadConsumption]>=(0) AND [WorkloadConsumption]<=(100)))
GO
