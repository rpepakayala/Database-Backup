/****** Object:  Table [dbo].[sysmaintplan_logdetail]    Script Date: 5/15/2018 12:03:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sysmaintplan_logdetail](
	[task_detail_id] [uniqueidentifier] NOT NULL,
	[line1] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[line2] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[line3] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[line4] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[line5] [nvarchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[server_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[start_time] [datetime] NULL,
	[end_time] [datetime] NULL,
	[error_number] [int] NULL,
	[error_message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[command] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[succeeded] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[sysmaintplan_logdetail]  WITH CHECK ADD  CONSTRAINT [FK_sysmaintplan_log_detail_task_id] FOREIGN KEY([task_detail_id])
REFERENCES [dbo].[sysmaintplan_log] ([task_detail_id])
ON DELETE CASCADE
ALTER TABLE [dbo].[sysmaintplan_logdetail] CHECK CONSTRAINT [FK_sysmaintplan_log_detail_task_id]
GO
