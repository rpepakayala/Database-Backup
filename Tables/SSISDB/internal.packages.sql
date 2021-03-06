/****** Object:  Table [internal].[packages]    Script Date: 5/15/2018 12:06:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [internal].[packages](
	[package_id] [bigint] IDENTITY(1,1) NOT NULL,
	[project_version_lsn] [bigint] NOT NULL,
	[name] [nvarchar](260) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[package_guid] [uniqueidentifier] NOT NULL,
	[description] [nvarchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[package_format_version] [int] NOT NULL,
	[version_major] [int] NOT NULL,
	[version_minor] [int] NOT NULL,
	[version_build] [int] NOT NULL,
	[version_comments] [nvarchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[version_guid] [uniqueidentifier] NOT NULL,
	[project_id] [bigint] NOT NULL,
	[entry_point] [bit] NOT NULL,
	[validation_status] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[last_validation_time] [datetimeoffset](7) NULL,
	[package_data] [varbinary](max) NULL,
 CONSTRAINT [PK_Packages] PRIMARY KEY CLUSTERED 
(
	[package_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_Packages_Name]    Script Date: 5/15/2018 12:06:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Packages_Name] ON [internal].[packages]
(
	[name] ASC
)
INCLUDE ( 	[package_id],
	[project_version_lsn],
	[project_id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [internal].[packages]  WITH CHECK ADD  CONSTRAINT [FK_Packages_ProjectId_Projects] FOREIGN KEY([project_id])
REFERENCES [internal].[projects] ([project_id])
ON DELETE CASCADE
ALTER TABLE [internal].[packages] CHECK CONSTRAINT [FK_Packages_ProjectId_Projects]
ALTER TABLE [internal].[packages]  WITH CHECK ADD  CONSTRAINT [FK_Packages_ProjectVersionLsn_ObjectVersions] FOREIGN KEY([project_version_lsn])
REFERENCES [internal].[object_versions] ([object_version_lsn])
ON DELETE CASCADE
ALTER TABLE [internal].[packages] CHECK CONSTRAINT [FK_Packages_ProjectVersionLsn_ObjectVersions]
GO
