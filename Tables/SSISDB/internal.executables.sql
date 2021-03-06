/****** Object:  Table [internal].[executables]    Script Date: 5/15/2018 12:06:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [internal].[executables](
	[executable_id] [bigint] IDENTITY(1,1) NOT NULL,
	[project_id] [bigint] NOT NULL,
	[project_version_lsn] [bigint] NOT NULL,
	[package_name] [nvarchar](260) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[package_location_type] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[package_path_full] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[executable_name] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[executable_guid] [nvarchar](38) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[package_path] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Executables] PRIMARY KEY CLUSTERED 
(
	[executable_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
