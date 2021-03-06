/****** Object:  Table [internal].[execution_component_phases]    Script Date: 5/15/2018 12:06:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [internal].[execution_component_phases](
	[phase_stats_id] [bigint] IDENTITY(1,1) NOT NULL,
	[execution_id] [bigint] NOT NULL,
	[package_name] [nvarchar](260) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[package_location_type] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[package_path_full] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[task_name] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[subcomponent_name] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[phase] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[is_start] [bit] NULL,
	[phase_time] [datetimeoffset](7) NULL,
	[execution_path] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sequence_id] [int] NULL,
 CONSTRAINT [PK_Execution_component_phases] PRIMARY KEY CLUSTERED 
(
	[phase_stats_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Unique_sequence_id]    Script Date: 5/15/2018 12:06:12 PM ******/
CREATE NONCLUSTERED INDEX [Unique_sequence_id] ON [internal].[execution_component_phases]
(
	[sequence_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [internal].[execution_component_phases]  WITH CHECK ADD  CONSTRAINT [FK_ExecCompPhases_ExecutionId_Executions] FOREIGN KEY([execution_id])
REFERENCES [internal].[executions] ([execution_id])
ON DELETE CASCADE
ALTER TABLE [internal].[execution_component_phases] CHECK CONSTRAINT [FK_ExecCompPhases_ExecutionId_Executions]
GO
