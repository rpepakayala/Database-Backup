/****** Object:  Table [dbo].[sysjobservers]    Script Date: 5/15/2018 12:03:04 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysjobservers](
	[job_id] [uniqueidentifier] NOT NULL,
	[server_id] [int] NOT NULL,
	[last_run_outcome] [tinyint] NOT NULL,
	[last_outcome_message] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_run_date] [int] NOT NULL,
	[last_run_time] [int] NOT NULL,
	[last_run_duration] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [clust]    Script Date: 5/15/2018 12:03:04 PM ******/
CREATE CLUSTERED INDEX [clust] ON [dbo].[sysjobservers]
(
	[job_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [nc1]    Script Date: 5/15/2018 12:03:04 PM ******/
CREATE NONCLUSTERED INDEX [nc1] ON [dbo].[sysjobservers]
(
	[server_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
