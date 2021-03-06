/****** Object:  Table [dbo].[msdb_version]    Script Date: 5/15/2018 12:02:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[msdb_version](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[version_string] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[version_major] [int] NOT NULL,
	[version_minor] [int] NOT NULL,
	[version_build] [int] NOT NULL,
	[version_revision] [int] NOT NULL
) ON [PRIMARY]

GO
