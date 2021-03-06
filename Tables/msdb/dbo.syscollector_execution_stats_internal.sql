/****** Object:  Table [dbo].[syscollector_execution_stats_internal]    Script Date: 5/15/2018 12:03:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syscollector_execution_stats_internal](
	[log_id] [bigint] NOT NULL,
	[task_name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[execution_row_count_in] [int] NULL,
	[execution_row_count_out] [int] NULL,
	[execution_row_count_errors] [int] NULL,
	[execution_time_ms] [int] NULL,
	[log_time] [datetime] NOT NULL,
 CONSTRAINT [PK_syscollector_execution_stats] PRIMARY KEY CLUSTERED 
(
	[log_id] ASC,
	[task_name] ASC,
	[log_time] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[syscollector_execution_stats_internal]  WITH CHECK ADD  CONSTRAINT [FK_syscollector_execution_stats_log_id] FOREIGN KEY([log_id])
REFERENCES [dbo].[syscollector_execution_log_internal] ([log_id])
ON DELETE CASCADE
ALTER TABLE [dbo].[syscollector_execution_stats_internal] CHECK CONSTRAINT [FK_syscollector_execution_stats_log_id]
GO
