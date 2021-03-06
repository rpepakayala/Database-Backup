/****** Object:  Table [internal].[environments]    Script Date: 5/15/2018 12:06:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [internal].[environments](
	[environment_id] [bigint] IDENTITY(1,1) NOT NULL,
	[environment_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[folder_id] [bigint] NOT NULL,
	[description] [nvarchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[created_by_sid] [varbinary](85) NOT NULL,
	[created_by_name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[created_time] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_Environments] PRIMARY KEY CLUSTERED 
(
	[environment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Unique_Folder_Environment] UNIQUE NONCLUSTERED 
(
	[environment_name] ASC,
	[folder_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [internal].[environments]  WITH CHECK ADD  CONSTRAINT [FK_Environments_FolderId_Folders] FOREIGN KEY([folder_id])
REFERENCES [internal].[folders] ([folder_id])
ALTER TABLE [internal].[environments] CHECK CONSTRAINT [FK_Environments_FolderId_Folders]
GO
