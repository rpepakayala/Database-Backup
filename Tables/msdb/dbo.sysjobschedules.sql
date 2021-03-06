/****** Object:  Table [dbo].[sysjobschedules]    Script Date: 5/15/2018 12:03:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysjobschedules](
	[schedule_id] [int] NULL,
	[job_id] [uniqueidentifier] NULL,
	[next_run_date] [int] NOT NULL,
	[next_run_time] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [clust]    Script Date: 5/15/2018 12:03:04 PM ******/
CREATE UNIQUE CLUSTERED INDEX [clust] ON [dbo].[sysjobschedules]
(
	[job_id] ASC,
	[schedule_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [NC_sysjobschedules_schedule_id]    Script Date: 5/15/2018 12:03:04 PM ******/
CREATE NONCLUSTERED INDEX [NC_sysjobschedules_schedule_id] ON [dbo].[sysjobschedules]
(
	[schedule_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[sysjobschedules] ADD  DEFAULT ((0)) FOR [next_run_date]
ALTER TABLE [dbo].[sysjobschedules] ADD  DEFAULT ((0)) FOR [next_run_time]
ALTER TABLE [dbo].[sysjobschedules]  WITH CHECK ADD FOREIGN KEY([job_id])
REFERENCES [dbo].[sysjobs] ([job_id])
ALTER TABLE [dbo].[sysjobschedules]  WITH CHECK ADD FOREIGN KEY([schedule_id])
REFERENCES [dbo].[sysschedules] ([schedule_id])
GO
