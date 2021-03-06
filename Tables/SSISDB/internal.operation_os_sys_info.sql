/****** Object:  Table [internal].[operation_os_sys_info]    Script Date: 5/15/2018 12:06:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [internal].[operation_os_sys_info](
	[info_id] [bigint] IDENTITY(1,1) NOT NULL,
	[operation_id] [bigint] NOT NULL,
	[total_physical_memory_kb] [bigint] NOT NULL,
	[available_physical_memory_kb] [bigint] NULL,
	[total_page_file_kb] [bigint] NULL,
	[available_page_file_kb] [bigint] NOT NULL,
	[cpu_count] [int] NOT NULL,
 CONSTRAINT [PK_Operation_Os_Sys_Info] PRIMARY KEY CLUSTERED 
(
	[info_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_OsSysInfo_Operation_id]    Script Date: 5/15/2018 12:06:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_OsSysInfo_Operation_id] ON [internal].[operation_os_sys_info]
(
	[operation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [internal].[operation_os_sys_info]  WITH CHECK ADD  CONSTRAINT [FK_OssysInfo_Operations] FOREIGN KEY([operation_id])
REFERENCES [internal].[operations] ([operation_id])
ON DELETE CASCADE
ALTER TABLE [internal].[operation_os_sys_info] CHECK CONSTRAINT [FK_OssysInfo_Operations]
GO
