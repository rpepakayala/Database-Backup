/****** Object:  Table [internal].[executions]    Script Date: 5/15/2018 12:06:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [internal].[executions](
	[execution_id] [bigint] NOT NULL,
	[folder_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[project_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[package_name] [nvarchar](260) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[reference_id] [bigint] NULL,
	[reference_type] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[environment_folder_name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[environment_name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[project_lsn] [bigint] NULL,
	[executed_as_sid] [varbinary](85) NOT NULL,
	[executed_as_name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[use32bitruntime] [bit] NOT NULL,
 CONSTRAINT [PK_Executions] PRIMARY KEY CLUSTERED 
(
	[execution_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [internal].[executions]  WITH CHECK ADD  CONSTRAINT [FK_Executions_ExecutionId_Operations] FOREIGN KEY([execution_id])
REFERENCES [internal].[operations] ([operation_id])
ON DELETE CASCADE
ALTER TABLE [internal].[executions] CHECK CONSTRAINT [FK_Executions_ExecutionId_Operations]
GO
