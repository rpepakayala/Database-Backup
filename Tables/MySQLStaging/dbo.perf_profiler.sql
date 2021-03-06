/****** Object:  Table [dbo].[perf_profiler]    Script Date: 5/15/2018 12:04:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[perf_profiler](
	[perf_profiler_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[start_time] [datetime2](0) NULL,
	[end_time] [datetime2](0) NULL,
	[duration] [decimal](10, 3) NULL,
	[action] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[module] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[query_string] [nvarchar](125) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[created_on] [datetime2](0) NULL,
	[num_queries] [int] NULL,
	[query_time] [decimal](7, 3) NULL,
	[response_size] [int] NULL,
 CONSTRAINT [PK_perf_profiler_perf_profiler_id] PRIMARY KEY CLUSTERED 
(
	[perf_profiler_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[perf_profiler] ADD  DEFAULT (NULL) FOR [start_time]
ALTER TABLE [dbo].[perf_profiler] ADD  DEFAULT (NULL) FOR [end_time]
ALTER TABLE [dbo].[perf_profiler] ADD  DEFAULT (NULL) FOR [duration]
ALTER TABLE [dbo].[perf_profiler] ADD  DEFAULT (NULL) FOR [action]
ALTER TABLE [dbo].[perf_profiler] ADD  DEFAULT (NULL) FOR [module]
ALTER TABLE [dbo].[perf_profiler] ADD  DEFAULT (NULL) FOR [query_string]
ALTER TABLE [dbo].[perf_profiler] ADD  DEFAULT (NULL) FOR [created_on]
ALTER TABLE [dbo].[perf_profiler] ADD  DEFAULT (NULL) FOR [num_queries]
ALTER TABLE [dbo].[perf_profiler] ADD  DEFAULT (NULL) FOR [query_time]
ALTER TABLE [dbo].[perf_profiler] ADD  DEFAULT (NULL) FOR [response_size]
GO
