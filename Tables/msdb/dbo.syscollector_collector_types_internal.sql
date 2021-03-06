/****** Object:  Table [dbo].[syscollector_collector_types_internal]    Script Date: 5/15/2018 12:03:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syscollector_collector_types_internal](
	[collector_type_uid] [uniqueidentifier] NOT NULL,
	[name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[parameter_schema] [xml] NULL,
	[parameter_formatter] [xml] NULL,
	[schema_collection] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[collection_package_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[collection_package_folderid] [uniqueidentifier] NOT NULL,
	[upload_package_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[upload_package_folderid] [uniqueidentifier] NOT NULL,
	[is_system] [bit] NOT NULL,
 CONSTRAINT [PK_syscollector_collector_types_internal] PRIMARY KEY CLUSTERED 
(
	[collector_type_uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_syscollector_collection_types_internal_name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[syscollector_collector_types_internal] ADD  DEFAULT ((0)) FOR [is_system]
ALTER TABLE [dbo].[syscollector_collector_types_internal]  WITH CHECK ADD  CONSTRAINT [FK_syscollector_collector_types_internal_collection_sysssispackages] FOREIGN KEY([collection_package_folderid], [collection_package_name])
REFERENCES [dbo].[sysssispackages] ([folderid], [name])
ALTER TABLE [dbo].[syscollector_collector_types_internal] CHECK CONSTRAINT [FK_syscollector_collector_types_internal_collection_sysssispackages]
ALTER TABLE [dbo].[syscollector_collector_types_internal]  WITH CHECK ADD  CONSTRAINT [FK_syscollector_collector_types_internal_upload_sysssispackages] FOREIGN KEY([upload_package_folderid], [upload_package_name])
REFERENCES [dbo].[sysssispackages] ([folderid], [name])
ALTER TABLE [dbo].[syscollector_collector_types_internal] CHECK CONSTRAINT [FK_syscollector_collector_types_internal_upload_sysssispackages]
GO
