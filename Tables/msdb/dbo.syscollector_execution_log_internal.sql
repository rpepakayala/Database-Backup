/****** Object:  Table [dbo].[syscollector_execution_log_internal]    Script Date: 5/15/2018 12:03:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syscollector_execution_log_internal](
	[log_id] [bigint] IDENTITY(1,1) NOT NULL,
	[parent_log_id] [bigint] NULL,
	[collection_set_id] [int] NOT NULL,
	[collection_item_id] [int] NULL,
	[start_time] [datetime] NOT NULL,
	[last_iteration_time] [datetime] NULL,
	[finish_time] [datetime] NULL,
	[runtime_execution_mode] [smallint] NULL,
	[status] [smallint] NOT NULL,
	[operator] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[package_id] [uniqueidentifier] NULL,
	[package_execution_id] [uniqueidentifier] NULL,
	[failure_message] [nvarchar](2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_syscollector_execution_log] PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[syscollector_execution_log_internal]  WITH CHECK ADD  CONSTRAINT [FK_syscollector_execution_log_collection_set_id] FOREIGN KEY([collection_set_id])
REFERENCES [dbo].[syscollector_collection_sets_internal] ([collection_set_id])
ALTER TABLE [dbo].[syscollector_execution_log_internal] CHECK CONSTRAINT [FK_syscollector_execution_log_collection_set_id]
GO
